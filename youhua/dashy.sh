#!/bin/bash
mkdir /docker
mkdir /docker/dashy
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/conf.yml
docker run -d \
  -p 8080:80 \
  -v /docker/dashy/conf.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
