#!/bin/bash
echo "即将安装【Umami】--一个网站的可视化监控web面板"
echo "    将使用docker安装，默认端口号3000。"

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
echo "默认使用 3000端口 进行安装"
# read -p "输入需要修改80端口（1），修改8080端口（2），8443端口（3）：   " port
port_number1=3000
# port_number2=8080
# port_number3=8443
# if [ "$port" = "1" ]; then
  read -p "输入需要映射的http端口：   " port1
  # 判断端口是否占用
  if lsof -i :$port1; then
    # 判断端口是否占用，如占用重新输入
    read -p "端口 $port1 已经被使用，请录入新的端口: " port1
    port_number1=$port1
  else
    port_number1=3000
  fi
# elif [ "$port" = "1" ]; then
#  read -p "输入需要映射的https端口：   " port2
  # 判断端口是否占用
#   if lsof -i :$port2; then
    # 判断端口是否占用，如占用重新输入
#     read -p "端口 $port2 已经被使用，请录入新的端口: " port2
#     port_number2=$port2
#   else
#     port_number2=8080
#   fi
# elif [ "$port" = "3" ]; then
#   read -p "输入需要映射的https端口：   " port3
  # 判断端口是否占用
#   if lsof -i :$port3; then
    # 判断端口是否占用，如占用重新输入
#     read -p "端口 $port3 已经被使用，请录入新的端口: " port3
#     port_number3=$port3
#   else
#     port_number3=8443
#   fi
# fi
cd $folder_name
# sudo docker run \
# --sig-proxy=false \
# --name nextcloud-aio-mastercontainer \
  read -p "使用postgresql数据库（1），mysql（2）：   " sql
  # 判断端口是否占用
  if [ "$sql" = "1" ]; then
    docker pull docker.umami.dev/umami-software/umami:postgresql-latest
  elif [ "$sql" = "2" ]; then
    docker pull docker.umami.dev/umami-software/umami:mysql-latest
  fi
cat > docker-compose.yml << EOF
---
version: '3'
services:
  umami:
    image: ghcr.io/umami-software/umami:postgresql-latest
    ports:
      - "$port_number1:3000"
    environment:
      DATABASE_URL: postgresql://umami:umami@db:5432/umami # 这里的数据库和密码要和下方你修改的相同
      DATABASE_TYPE: postgresql
      HASH_SALT: replace-me-with-a-random-string
    depends_on:
      - db
    restart: always
  db:
    image: postgres:12-alpine
    environment:
      POSTGRES_DB: umami
      POSTGRES_USER: umami # 数据库用户
      POSTGRES_PASSWORD: umami  # 数据库密码
    volumes:
      - ./sql/schema.postgresql.sql:/docker-entrypoint-initdb.d/schema.postgresql.sql:ro
      - ./umami-db-data:/var/lib/postgresql/data
    restart: always
EOF
ip1=$(curl ifconfig.me)
if [ $? = '0' ]; then
  echo "$folder_name 安装成功✅✅✅！  端口:$port_number1"
  echo "web地址：http://$ip1:$port_number1"
  echo "username：admin"
  echo "password：umami"
elif [ $? != '0' ]; then
  echo "安装失败，yml文件默认postgres数据库，请检查检查！"
  exit 1
fi
