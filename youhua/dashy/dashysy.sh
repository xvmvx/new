#!/bin/bash
echo "即将安装dashy首页端口8088："
docker run -d \
  -p 8088:80 \
  -v /docker/dashy/confsy.yml:/app/public/conf.yml \
  --name sy-dashboard \
  --restart=always \
  lissy93/dashy:latest
