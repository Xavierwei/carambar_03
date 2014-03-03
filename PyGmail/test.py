# -*- coding: utf-8 -*-

import os
import sys
basepath = os.path.abspath(os.path.dirname(__file__))

import sys
sys.path.append(os.path.join(basepath, "poster"))
from poster.encode import multipart_encode
from poster.streaminghttp import register_openers
import urllib2

__author__="jackey"
__date__ ="$Jan 28, 2014 9:15:24 PM$"

if __name__ == "__main__":
    register_openers()
    
    datagen, headers = multipart_encode({"image1": open(os.path.join(basepath ,"attachments/like.png"), "rb")})
    request = urllib2.Request("http://bankapi.local/node/postbymail", datagen, headers)
    res = urllib2.urlopen(request).read()
    import json
    res = json.loads(res)
    print res
