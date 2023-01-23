#!/bin/bash
# 判断是否安装docker
if dpkg -l | grep -q docker; then
  echo "docker已安装"
else
  # 安装docker
  echo "请先安装docker"
fi

# 判断是否安装docker Compose 
if dpkg -l | grep -q docker-compose; then
  echo "Docker Compose已安装."
else
  # 安装Docker Compose
  echo "docker-compose未安装，自行判断是否要安装"
fi

cd /
cd docker
if [ $? != '0' ]; then
cd /
mkdir docker
cd docker
fi
