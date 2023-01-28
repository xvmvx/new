#!/bin/bash
echo "即将安装dashy网络版，端口8086"
docker run -d \
  -p 8086:80 \
  -v /docker/dashy/confn.yml:/app/public/conf.yml \
  --name n-dashboard \
  --restart=always \
  lissy93/dashy:latest
