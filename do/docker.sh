#!/bin/bash
echo "即将安装【Fast OS Docker】--DOCKER容器可视化管理系统"
echo "    通过可视化界面轻松构建您的docker环境，方便您docker环境的管理，远离命令式操作。大大提高您的工作效率，减少不必要的操作。"

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
read -p "输入需要映射的http端口：   " port_number1

# 判断端口是否占用
if lsof -i :$port_number1; then
  # 判断端口是否占用，如占用重新输入
  read -p "端口 $port_number1 已经被使用，请录入新的端口: " port_number1
fi

read -p "输入需要映射的https端口：   " port_number2

# 判断端口是否占用
if lsof -i :$port_number2; then
  # 判断端口是否占用，如占用重新输入
  read -p "端口 $port_number2 已经被使用，请录入新的端口: " port_number2
fi

cd $folder_name
docker run --restart always --name fast_go_docker -p $port_number1:8081 -p $port_number2:8082 -e TZ="Asia/Shanghai" -d -v /var/run/docker.sock:/var/run/docker.sock -v /etc/docker/:/etc/docker/ wangbinxingkong/fast:latest


# 编写docker-compose文件
echo "version: '3'" >> $folder_name/docker-compose.yml
echo "services:" >> $folder_name/docker-compose.yml
echo "  web:" >> $folder_name/docker-compose.yml
echo "    build: ." >> $folder_name/docker-compose.yml
echo "    ports:" >> $folder_name/docker-compose.yml
echo "      - $port_number:80" >> $folder_name/docker-compose.yml

# 进入文件夹并开始执行
cd $folder_name
docker-compose up -d

docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /root/public:/public portainer/portainer-ce





  lsof -i:$port
  if [ $? = '0' ]; then
    echo "该端口可以使用，正在安装" 
  else
    echo "该端口不可使用，请更换其他端口" 
  fi
  exit 1
fi
    if [ "$port" = '0' ]; then
      echo "npm 安装成功✅✅✅！  端口:81"
echo "you are setting username : ${name}"
lsof -i:81 && docker-compose up -d
docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /root/public:/public portainer/portainer-ce
