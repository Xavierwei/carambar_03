#!/usr/bin/env bash

DIR="$( cd $( dirname ${BASH_SOURCE[0]} ) && pwd )"

if [[ ! -d $DIR/result ]]; then
  mkdir $DIR/results
fi

# 测试10秒，模拟4个客户端 （客户端数字是  cpu核心数 * 2）
python pylot/run.py -x $DIR/testcase.xml -a 1 -d 1 -o $DIR/results --log_msgs

