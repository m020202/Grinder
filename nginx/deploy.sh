#!/bin/bash

# 🔹 active_version.conf에서 현재 활성화된 버전 가져오기
ACTIVE_VERSION=$(grep -oP '(?<=set \$active_version )\w+' /etc/nginx/conf.d/active_version.conf)

# 다음 배포할 버전 결정
if [ "$ACTIVE_VERSION" == "blue" ]; then
  NEW_VERSION="green"
  OLD_VERSION="blue"
else
  NEW_VERSION="blue"
  OLD_VERSION="green"
fi

# 새로운 버전 컨테이너 실행
docker-compose up -d --no-deps --build $NEW_VERSION

# 🔹 Nginx의 active_version 변경
echo "set \$active_version $NEW_VERSION;"

# Nginx 설정 리로드 (무중단 트래픽 전환)
docker exec nginx-server nginx -s reload

# 만약 실행 중이라면, 기존 버전 컨테이너 종료
if docker ps --format "{{.Names}}" | grep -q "^$OLD_VERSION$"; then
  docker stop $OLD_VERSION && docker rm $OLD_VERSION
fi
