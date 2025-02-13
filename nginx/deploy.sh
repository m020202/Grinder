#!/bin/bash

IS_GREEN_EXIST=$(docker ps | grep green)
DEFAULT_CONF=" /etc/nginx/nginx.conf"

# blue가 실행 중이면 green을 up
if [ -z $IS_GREEN_EXIST ];then
  docker-compose pull m020202/green:latest
  docker-compose up -d green
  sleep 2
  sudo ln -s -f /etc/nginx/sites-available/green /etc/nginx/sites-enabled/default
  sudo nginx -s reload
  docker-compose stop blue

# green이 실행 중이면 blue를 up
else
  docker-compose pull m020202/blue:latest
  docker-compose up -d blue
  sleep 2
  sudo ln -s -f /etc/nginx/sites-available/blue /etc/nginx/sites-enabled/default
  docker-compose stop green
fi

