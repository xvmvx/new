#!/bin/bash
echo "即将安装dashy版，端口8087"
docker run -d \
  -p 8087:80 \
  -v /docker/dashy/confd.yml:/app/public/conf.yml \
  --name d-dashboard \
  --restart=always \
  lissy93/dashy:latest
