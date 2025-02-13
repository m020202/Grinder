#!/bin/bash

IS_GREEN_EXIST=$(docker ps | grep green)
DEFAULT_CONF=" /etc/nginx/nginx.conf"

# blue가 실행 중이면 green을 up
if [ -z $IS_GREEN_EXIST ];then
  docker image rm m020202/green:latest
  docker run -d -p 8082:8080 --name green m020202/green:latest
  sleep 2
  sudo ln -s -f /etc/nginx/sites-available/green /etc/nginx/sites-enabled/default
  sudo nginx -s reload
  docker stop blue
  docker rm blue

# green이 실행 중이면 blue를 up
else
  docker image rm m020202/blue:latest
  docker run -d -p 8081:8080 --name blue m020202/blue:latest
  sleep 2
  sudo ln -s -f /etc/nginx/sites-available/blue /etc/nginx/sites-enabled/default
  sudo nginx -s reload
  docker stop green
  docker rm green
fi

