#!/bin/bash
echo "即将安装【npm】--反向代理神器"
echo "    请确保1080.1081.10443端口正常开放"

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

# 输入需要映射的端口
# read -p "输入需要映射的http端口：   " port_number1
# 判断端口是否占用
# if lsof -i :$port_number1; then
  # 判断端口是否占用，如占用重新输入
#   read -p "端口 $port_number1 已经被使用，请录入新的端口: " port_number1
# fi


# read -p "输入需要映射的https端口：   " port_number2
# 判断端口是否占用
# if lsof -i :$port_number2; then
  # 判断端口是否占用，如占用重新输入
#  read -p "端口 $port_number2 已经被使用，请录入新的端口: " port_number2
# fi



# 编写docker-compose文件
echo "version: '3'" >> $folder_name/docker-compose.yml
echo "services:" >> $folder_name/docker-compose.yml
echo "  npm:" >> $folder_name/docker-compose.yml
echo "    image: 'jc21/nginx-proxy-manager:latest'" >> $folder_name/docker-compose.yml
echo "    restart: unless-stopped" >> $folder_name/docker-compose.yml
echo "    ports:" >> $folder_name/docker-compose.yml
echo "      - '1080:80'" >> $folder_name/docker-compose.yml
echo "      - '1081:81'" >> $folder_name/docker-compose.yml
echo "      - '10443:443'" >> $folder_name/docker-compose.yml
echo "    volumes:" >> $folder_name/docker-compose.yml
echo "      - ./data:/data" >> $folder_name/docker-compose.yml
echo "      - ./letsencrypt:/etc/letsencrypt" >> $folder_name/docker-compose.yml

# 进入文件夹并开始执行
cd $folder_name
docker-compose up -d

ip1=$(curl ifconfig.me)
if [ $? = '0' ]; then
  echo "npm 安装成功✅✅✅！  端口:81"
  echo "web地址：http://$ip1:$port_number1"
elif [ $? != '0' ]; then
  echo "安装失败，人工检查！参考代码如下，自行修改并运行
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'  # 冒号左边可以改成自己服务器未被占用的端口
      - '81:81'  # 冒号左边可以改成自己服务器未被占用的端口
      - '443:443' # 冒号左边可以改成自己服务器未被占用的端口
    volumes:
      - ./data:/data # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 data 文件夹中
      - ./letsencrypt:/etc/letsencrypt  # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 letsencrypt 文件夹中 "
  exit 1
fi
