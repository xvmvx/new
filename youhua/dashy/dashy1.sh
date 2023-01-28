#!/bin/bash
echo "即将安装dashy简化版，端口8081"
docker run -d \
  -p 8081:80 \
  -v /docker/dashy/conf1.yml:/app/public/conf.yml \
  --name 1-dashboard \
  --restart=always \
  lissy93/dashy:latest
