#!/bin/bash
echo "即将安装dashy-ctf版，端口8085"
docker run -d \
  -p 8085:80 \
  -v /docker/dashy/confctf.yml:/app/public/conf.yml \
  --name ctf-dashboard \
  --restart=always \
  lissy93/dashy:latest
