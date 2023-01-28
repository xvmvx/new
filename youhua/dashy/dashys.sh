#!/bin/bash
echo "即将安装dashys版，端口808o"
docker run -d \
  -p 8080:80 \
  -v /docker/dashy/confs.yml:/app/public/conf.yml \
  --name s-dashboard \
  --restart=always \
  lissy93/dashy:latest
