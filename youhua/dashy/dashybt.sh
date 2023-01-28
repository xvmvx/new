#!/bin/bash
echo "即将安装dashy虚拟货币版，端口8089"
docker run -d \
  -p 8089:80 \
  -v /docker/dashy/confbt.yml:/app/public/conf.yml \
  --name bt-dashboard \
  --restart=always \
  lissy93/dashy:latest
