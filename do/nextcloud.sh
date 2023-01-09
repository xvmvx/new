#!/bin/bash
echo "即将安装【nextcloud】--是一套用于创建和使用文件托管服务的客户端-服务器软件"
echo "    将使用docker进行安装。。。"

# 判断是否安装docker
if dpkg -l | grep -q docker; then
  echo "docker已安装"
else
  # 安装docker
  sudo apt-get update
  sudo apt-get install docker
fi

# 判断是否安装docker Compose 
if dpkg -l | grep -q docker-compose; then
  echo "Docker Compose已安装."
else
  # 安装Docker Compose
  sudo apt-get update
  sudo apt-get install docker-compose
fi

# 录入需要保存的文件夹
read -p "输入要安装的位置: " folder_name

# 判断文件是否存在
if [ ! -d "$folder_name" ]; then
  mkdir $folder_name
fi

# 输入需要映射的端口
echo "默认使用 80:80   8080:8080   8443:8443 进行安装"
read -p "输入需要修改80端口（1），修改8080端口（2），8443端口（3）：   " port
port_number1=80
port_number2=8080
port_number3=8443
if [ "$port" = "1" ]; then
  read -p "输入需要映射的http端口：   " port1
  # 判断端口是否占用
  if lsof -i :$port1; then
    # 判断端口是否占用，如占用重新输入
    read -p "端口 $port1 已经被使用，请录入新的端口: " port1
    port_number1=$port1
  else
    port_number1=80
  fi
elif [ "$port" = "1" ]; then
  read -p "输入需要映射的https端口：   " port2
  # 判断端口是否占用
  if lsof -i :$port2; then
    # 判断端口是否占用，如占用重新输入
    read -p "端口 $port2 已经被使用，请录入新的端口: " port2
    port_number2=$port2
  else
    port_number2=8080
  fi
elif [ "$port" = "3" ]; then
  read -p "输入需要映射的https端口：   " port3
  # 判断端口是否占用
  if lsof -i :$port3; then
    # 判断端口是否占用，如占用重新输入
    read -p "端口 $port3 已经被使用，请录入新的端口: " port3
    port_number3=$port3
  else
    port_number3=8443
  fi
fi
cd $folder_name
sudo docker run \
--sig-proxy=false \
--name nextcloud-aio-mastercontainer \
--restart always \
--publish $port_number1:80 \
--publish $port_number2:8080 \
--publish $port_number3:8443 \
--volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
--volume /var/run/docker.sock:/var/run/docker.sock:ro \
nextcloud/all-in-one:latest

ip1=$(curl ifconfig.me)
if [ $? = '0' ]; then
  echo "fastos 安装成功✅✅✅！  端口:$port_number1"
  echo "web地址：http://$ip1:$port_number1"
elif [ $? != '0' ]; then
  echo "安装失败，人工检查！"
  exit 1
fi
