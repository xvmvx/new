#!/bin/bash
echo "即将安装dashy-HOME版，端口8083"
docker run -d \
  -p 8083:80 \
  -v /docker/dashy/confh.yml:/app/public/conf.yml \
  --name h-dashboard \
  --restart=always \
  lissy93/dashy:latest
