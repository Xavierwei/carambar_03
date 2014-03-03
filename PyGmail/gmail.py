# -*- coding: utf-8 -*-

import imaplib, email, base64
from email.header import decode_header
import os
import sys
import subprocess
import pickle
import datetime
from ConfigParser import ConfigParser
import os.path
from smtplib import SMTP

reload(sys)
sys.setdefaultencoding('utf-8')

print sys.getdefaultencoding()

basepath = os.path.abspath(os.path.dirname(__file__))

def post_media_to_bankwall(desc="description", user="xx@xx.com", media="/path/to/media"):
  sys.path.append(os.path.join(basepath, "poster"))
  from poster.encode import multipart_encode
  from poster.streaminghttp import register_openers
  import urllib2
  import json

  register_openers()
  
  datagen, headers = multipart_encode({"photo": open(os.path.join(basepath , media), "rb"), 
    "desc": desc,
    "user": user})
  request = urllib2.Request("http://64.207.184.106/sgwall/api/node/postbymail", datagen, headers)
  res = urllib2.urlopen(request).read()
  res = json.loads(res)
  print res["message"]
  return res["message"]

def reply_mail(mail_obj, is_success=True):
  print "begin to reply email to [%s] "  %(mail_obj["From"] or mail_obj["Reply-To"])
  original = mail_obj
  config = dict(load_config().items("smtp"))
  smtp = SMTP()
  smtp.connect('smtp.gmail.com', 587)
  smtp.starttls()
  smtp.login(config["user"], config["pass"])
  from_addr = "testdev@fuel-it-up.com"
  to_addr = original["Reply-To"] or original["From"]
  subj = "Re: "+original["Subject"]
  date = datetime.datetime.now().strftime( "%d/%m/%Y %H:%M" )
  message_text = "Hello\nThis is a mail from your server\n\nBye\n"
  msg = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" % ( from_addr, to_addr, subj, date, is_success.replace('\\n','\n') )
  smtp.sendmail(from_addr, to_addr, msg)
  smtp.quit()
  print "replied email to [%s] "  %(mail_obj["From"] or mail_obj["Reply-To"])
  

def is_media(file):
  """ 判断是否是Media (图片/视频) """
  file = file.replace("(", "\(").replace(")", "\)")
  cmd = "/usr/bin/file -b --mime %s" % (file)
  mime = subprocess.Popen(cmd, shell=True, \
  stdout = subprocess.PIPE).communicate()[0]
  mime = mime.rstrip()
  print "mime is [%s]" %(mime)
  
  if mime in ["image/jpeg", "image/png", "image/jpg", "image/gif", "video/mov", "video/quicktime", "video/wmv", "video/mp4", "video/avi", "video/3gp", "video/mpeg", "video/mpg", "application/octet-stream", "video/3gpp"]:
    return True
  return False

def cache_mail(uuid, gmail_mail, filepath):
  """缓存邮件内容"""
  print "mail id [%s] is being to cached " %(uuid)
  # From
  mfrom = email.utils.parseaddr(gmail_mail["From"])
  # Subject
  subject = gmail_mail["Subject"]
  subject, encoding = decode_header(subject)[0]
  
  # 打印提示
  print "Cached %s Email with %s subject !" %(mfrom, subject)
  
  cache_dir = os.path.join(basepath, "caches")
  if not os.path.isdir(cache_dir):
    os.mkdir(cache_dir)
  
  cache_file = os.path.join(cache_dir, uuid);
  if os.path.isfile(cache_file):
    return False
  cache_data = [uuid, mfrom, subject, filepath]
  sdata = pickle.dumps(cache_data)
  fp = open(cache_file, "wb")
  fp.write(sdata)
  fp.close()
  
  return cache_data

def rm_cache_mail(uuid):
  cache_dir = os.path.join(basepath, "caches")
  if not os.path.isdir(cache_dir):
    os.mkdir(cache_dir)
  
  cache_file = os.path.join(cache_dir, uuid);
  if os.path.isfile(cache_file) is False:
    return True

  os.unlink(cache_file)
  return True

def is_cached(uuid):
  cache_dir = os.path.join(basepath, "caches")
  
  if not os.path.isdir(cache_dir):
    os.mkdir(cache_dir)
  
  cache_file = os.path.join(cache_dir, uuid)
  if not os.path.isfile(cache_file):
    return False
  return True

def reconnect_gmail(user, password):
  conn = imaplib.IMAP4_SSL("imap.gmail.com", 993)
  try:
    conn.login(user, password)
    print "login in mail account [%s] success" %(user)
    conn.select("inbox")
  except:
    print "Error when login with %s" %(user)
    return None
  return conn

def fetching_gamil(user, password):
  # 只取最近10条邮件
  num = 10
  attachmentpath = "./attachments";
  attachmentpath = os.path.abspath(attachmentpath)
  if not os.path.isdir(attachmentpath):
    os.mkdir(attachmentpath)

  conn = imaplib.IMAP4_SSL("imap.gmail.com", 993)
  try:
    conn.login(user, password)
    print "login in mail account [%s] success" %(user)
    conn.select("inbox")
  except:
    print "Error when login with %s" %(user)
    return

  # 选择一个 inbox

  # 执行search 命令
  # 只查询前2天的邮件 (多查询几天免得漏掉邮件)
  date = (datetime.date.today() - datetime.timedelta(2)).strftime("%d-%b-%Y")
  print "Fetching email since %s" %("(SENTSINCE {date})".format(date=date))
  result, data = conn.uid("search", None, "(SENTSINCE {date})".format(date=date))
  # result, data = conn.uid("search", None, "ALL")

  ids = data[0]
  id_list = ids.split()

  print "ids [%s] of mail that be fetched " %(id_list)

  for eid in id_list:
      
    # 对取每个邮件进行异常处理
    try:
      result, email_data = conn.uid("fetch", eid, "(RFC822)")
    except:
        while (True):
          conn = reconnect_gmail(user, password)
          if conn is None:
              continue
          result, email_data = conn.uid("fetch", eid, "(RFC822)")
          break
    if result != "OK":
        continue

    gmail_mail = email.message_from_string(email_data[0][1])

    # Get attachment
    for part in gmail_mail.walk():
      if part.get_content_maintype() == "multipart":
        continue
      if part.get("Content-Disposition") is None:
        continue

      if part.get_filename() is None:
        continue
      filename = "".join(part.get_filename().split())
      import time,hashlib
      #nowtimestamp = unicode(int(time.time())).encode("utf-8")
      #filename = unicode(filename).encode("utf-8")
      nowtimestamp =str(int(time.time()))
      md5 = hashlib.md5()
      md5.update(str(filename))
      ext=os.path.splitext(filename)[1]
      filename = ''.join([nowtimestamp , md5.hexdigest(), ext])

      if bool(filename):
        filepath = os.path.join(attachmentpath, filename)
	print filepath
        if not os.path.isfile(filepath):
          fp = open(filepath, "wb")
          fp.write(part.get_payload(decode=True))
          fp.close()
        else:
          # Exist same name file
          print "File : [%s] is downloaded" %(filepath)

        if is_media(filepath):
          # 在这里，先看是否已经有了缓存文件，如果有则不去发送图片到网站了
          if is_cached(eid):
            print "Mail with uuid [%s] is cached " %(eid)
            continue
          else:
            # 如果没有则先缓存图片再发送图片到网站
            data = cache_mail(eid, gmail_mail, filepath)

            if data is not None:
              print "begin to post data to bank wall"
              # 如果保存成功就发送数据到后台保存
              # From
              mfrom = email.utils.parseaddr(gmail_mail["From"])[1]
              # Subject
              subject = gmail_mail["Subject"]
              subject, encoding = decode_header(subject)[0]
              try:
                ret = post_media_to_bankwall(desc=subject, user=mfrom, media=filepath)
              except Exception as e:
                rm_cache_mail(eid)
                ret = None
                print e
              finally:
                if ret is not None:
                  reply_mail(gmail_mail, ret)
        else:
          print "File [%s] is not media " %(filepath)
  conn.close()
  conn.logout()
  
  
def clean_dir(dir):
    if os.path.isdir(dir):
        paths = os.listdir(dir)
        for path in paths:
            filepath = os.path.join(dir, path)
            if os.path.isfile(filepath):
                try:
                    os.unlink(filepath)
                except:
                    print "error when remove attachment %s " %(filepath)
    return True

def load_config():
  try:
    config = ConfigParser()
    config.read("setting.ini")

    return config
  except Exception as e:
    print "setting.ini is not exists!"
    sys.exit(1)

if __name__ == "__main__":
  config = load_config()
  account = dict(config.items("mailaccount"))

  # There's only one process do fetch job in each time
  if not os.path.isfile(".lock"):
    f = open(".lock", "w+")
    f.close()
  
  f = open(".lock", "r+")
  p = f.read()
  print p
  # If empty, that means we can run it
  if len(p) == 0:
    f.write("True")
  # Otherwise, we exit it imedirecly
  else:
    print "Another process is runing"
    sys.exit(0)

  f.close()

  try:
    print "begin fetch mail from account [%s] " %(account['user'])
    fetching_gamil(account['user'], account['pass'])

    # After finished fetching mail, we empty .lock file
    with open(".lock", "w+") as f:
      f.write("")

  except Exception as e:
    print "Exception when fetch email !"
    exc_type, exc_value, exc_traceback = sys.exc_info()
    import traceback
    traceback.print_exception(exc_type, exc_value, exc_traceback)

    os.unlink(".lock")
    print e
  
  finally:
    os.unlink(".lock")
      
  clean_dir("./attachments")
  

