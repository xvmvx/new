#!/bin/bash
echo "即将安装dashy-tf版，端口8084"
docker run -d \
  -p 8084:80 \
  -v /docker/dashy/conftf.yml:/app/public/conf.yml \
  --name tf-dashboard \
  --restart=always \
  lissy93/dashy:latest
