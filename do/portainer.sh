#!/bin/bash
echo "即将安装【Portainer-ce】--DOCKER容器可视化管理系统"
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

# 判断端口是否占用
if lsof -i:1800 ; then
  # 判断端口是否占用，如占用重新输入
  red "端口被占用，退出本程序，手动进行后续操作"
fi

# 判断端口是否占用
if lsof -i:1900 ; then
  # 判断端口是否占用，如占用重新输入
  red "端口被占用，退出本程序，手动进行后续操作"
fi
docker run -d -p 1800:8000 -p 1900:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /dockers/portainer/data:/data portainer/portainer-ce
if [ $? = '0' ]; then
  echo "fastos 安装成功✅✅✅！  端口:$port_number1"
  echo "web地址：http://$ip1:$port_number1"
elif [ $? != '0' ]; then
  echo "安装失败，人工检查！命令如下，自行酌情修改并运行"
   echo "docker run -d -p 1800:8000 -p 1900:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /dockers/portainer/data:/data portainer/portainer-ce"
  exit 1
fi
