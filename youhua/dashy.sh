#!/bin/bash
mkdir /docker
mkdir /docker/dashy
wget https://gist.githubusercontent.com/Lissy93/000f712a5ce98f212817d20bc16bab10/raw/b08f2473610970c96d9bc273af7272173aa93ab1/Example%25206%2520-%2520Networking%2520Services%2520-%2520conf.yml  /docker/dashy
cp /docker/dashy/'Example 6 - Networking Services - conf.yml'  /docker/dashy/conf.yml
docker run -d \
  -p 8080:80 \
  -v /docker/dashy/conf.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
