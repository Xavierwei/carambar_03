import os.path
#-*- coding: utf-8 -*-

import sys
import os
import gmail

root = os.path.abspath(os.path.dirname(__file__))

def load_mail_ids():
  paths = os.listdir(os.path.join(root, "caches"))
  ids = []
  for path in paths:
    ids.append(path)
    
  return ids

def connect_gmail():
  return gmail.reconnect_gmail(dict(config.items("mailaccount"))["user"], dict(config.items("mailaccount"))["pass"])

if __name__ == "__main__":
    config = gmail.load_config()
    ids = load_mail_ids()
    try:
      conn = connect_gmail()
      type, response = conn.store(",".join(ids), "+FLAGS" ,r"(\Deleted)")
      type, response = conn.expunge()
      
      print "Deleted mail. UUID is [%s] " %(",".join(ids))
    except Exception as e:
      print "Exception happend: [%s]" %(e)
    finally:
      conn.close()
      conn.logout()
    