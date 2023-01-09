#!/bin/bash
echo "即将安装【ward】--一个使用 Java 开发的简单而简约的服务器监控工具"
echo "    将使用docker安装，适合单台服务器。"

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
read -p "输入要保存的位置: " folder_name

# 判断文件是否存在
if [ ! -d "$folder_name" ]; then
  mkdir $folder_name
fi
cd $folder_name
git clone https://github.com/AntonyLeons/Ward
cd Ward 
docker build . --tag ward

# 输入需要映射的端口
echo "默认使用 4000端口 进行安装"
# read -p "输入需要修改80端口（1），修改8080端口（2），8443端口（3）：   " port
port_number1=3000
port_number2=4444
# port_number3=8443
# if [ "$port" = "1" ]; then
  read -p "输入需要映射的http端口：   " port1
  # 判断端口是否占用
  if lsof -i :$port1; then
    # 判断端口是否占用，如占用重新输入
    read -p "端口 $port1 已经被使用，请录入新的端口: " port1
    port_number1=$port1
  else
    port_number1=4000
  fi
# elif [ "$port" = "1" ]; then
  read -p "本应用配置时需要用到一个端口号，默认4444，更改请输入：   " port2
  # 判断端口是否占用
   if lsof -i :$port2; then
    # 判断端口是否占用，如占用重新输入
     read -p "端口 $port2 已经被使用，请录入新的端口: " port2
     port_number2=$port2
   else
     port_number2=4444
   fi
docker run -d --name ward -p $port_number1:4000 \
-p $port_number2:$port_number2 \
--privileged=true \
--restart always \
ward:latest

ip1=$(curl ifconfig.me)
if [ $? = '0' ]; then
  echo "$folder_name 安装成功✅✅✅！  端口:$port_number1"
  echo "web地址：http://$ip1:$port_number1"
  echo "Application Port : $port_number2"
  echo "设置成功后运行：docker exec -it ward /bin/sh"
  echo "如果出错，修改配置文件   setup.ini"
elif [ $? != '0' ]; then
  echo "安装失败，git clone https://github.com/AntonyLeons/Ward.git  更换镜像检查检查！"
  exit 1
fi
