#!/bin/bash
echo "即将安装dashy书签版，端口8082"
docker run -d \
  -p 8082:80 \
  -v /docker/dashy/confb.yml:/app/public/conf.yml \
  --name b-dashboard \
  --restart=always \
  lissy93/dashy:latest
