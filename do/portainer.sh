#!/bin/bash
echo "即将安装【Portainer-ce】--DOCKER容器可视化管理系统"
echo "默认安装在 docker/portainer文件夹"
echo "默认使用1800 1900端口"

# 判断是否安装docker
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do_test.sh -O -)"

echo "默认安装在 docker/portainer文件夹"
echo "默认使用1800 1900端口"
cd / 
cd docker
if [ $? = '0' ]; then
  rm -rf portainer
else
  cd /
  mkdir docker
  cd docker
fi
mkdir portainer
cd portainer
echo "默认安装在 docker/portainer文件夹"
pwd
read -p "打印位置是否正确？正确请按y " folder_name
if [ "$folder_name" != "y" ]; then
  red "那退出本程序，手动进入到docker/portainer再进行后续操作"
  exit
fi
# 录入需要保存的文件夹
read -p "输入要保存的位置: " folder_name

# 判断文件是否存在
if [ ! -d "$folder_name" ]; then
  mkdir $folder_name
fi

# 判断端口是否占用
if lsof -i:1800 ; then
  # 判断端口是否占用，如占用重新输入
  read -p "端口 $port_number1 已经被使用，请录入新的端口: " port_number1
else
  port_number1 = 1800
fi

# 判断端口是否占用
if lsof -i:1900 ; then
  # 判断端口是否占用，如占用重新输入
  read -p "端口 $port_number2 已经被使用，请录入新的端口: " port_number2
else
  port_number2 = 1900
fi
docker run -d -p $port_number1:8000 -p $port_number1:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /dockers/portainer/data:/data portainer/portainer-ce
if [ $? = '0' ]; then
  echo "fastos 安装成功✅✅✅！  端口:$port_number1"
  echo "web地址：http://$ip1:$port_number1"
elif [ $? != '0' ]; then
  echo "安装失败，人工检查！"
  exit 1
fi
