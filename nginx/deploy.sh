#!/bin/bash

# 현재 활성화된 버전 확인
ACTIVE_VERSION=$(docker ps --format "{{.Names}}" | grep -E 'blue|green')

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

# 정상 작동하는지 확인
sleep 10
if ! curl -s http://localhost:8082 | grep "Success"; then
  exit 1
fi

# 🔹 Nginx의 active_version 변경
echo "set \$active_version $NEW_VERSION;"

# Nginx 설정 리로드 (무중단 트래픽 전환)
docker exec nginx-server nginx -s reload

# 기존 버전 컨테이너 종료
docker stop $OLD_VERSION && docker rm $OLD_VERSION
