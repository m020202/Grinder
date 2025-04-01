#!/bin/bash

if docker ps | grep -q blue; then
  IS_BLUE_RUNNING=true
else
  IS_BLUE_RUNNING=false
fi

DEFAULT_CONF=" /etc/nginx/nginx.conf"

# blue가 실행 중이면 green을 up
if [ "IS_BLUE_RUNNING" = true ];then
  docker run -d -p 8081:8080 --name green m020202/grinder:latest
  sleep 2
  sudo sh -c 'echo "set \$service_url green;" > /etc/nginx/conf.d/service_url.inc'
  sudo nginx -s reload
  docker rm -f blue

# green이 실행 중이면 blue를 up
else
  docker run -d -p 8080:8080 --name blue m020202/grinder:latest
  sleep 2
  sudo sh -c 'echo "set \$service_url blue;" > /etc/nginx/conf.d/service_url.inc'
  sudo nginx -s reload
  docker rm -f green
fi

