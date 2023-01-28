#!/bin/bash
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}


logo="$(tput setaf 6)
   ____                 ___        __
  / ___| ___   ___   __| \ \      / /_ _ _   _ 
 | |  _ / _ \ / _ \ / _` |\ \ /\ / / _` | | | |
 | |_| | (_) | (_) | (_| | \ V  V / (_| | |_| |
  \____|\___/ \___/ \__,_|  \_/\_/ \__,_|\__, |
                                         |___/ 
$(tput sgr0)"

logo1="$(tput setaf 6)
    ▄▄▄▄                             ▄▄ ▄▄      ▄▄                    
  ██▀▀▀▀█                            ██ ██      ██                    
 ██         ▄████▄    ▄████▄    ▄███▄██ ▀█▄ ██ ▄█▀  ▄█████▄  ▀██  ███ 
 ██  ▄▄▄▄  ██▀  ▀██  ██▀  ▀██  ██▀  ▀██  ██ ██ ██   ▀ ▄▄▄██   ██▄ ██  
 ██  ▀▀██  ██    ██  ██    ██  ██    ██  ███▀▀███  ▄██▀▀▀██    ████▀  
  ██▄▄▄██  ▀██▄▄██▀  ▀██▄▄██▀  ▀██▄▄███  ███  ███  ██▄▄▄███     ███   
    ▀▀▀▀     ▀▀▀▀      ▀▀▀▀      ▀▀▀ ▀▀  ▀▀▀  ▀▀▀   ▀▀▀▀ ▀▀     ██    
                                                              ███     
$(tput sgr0)"
clear
yellow "${logo1}"
red "#############   示例  ##################"
blue "1)     入门"
blue "2）     书签"
blue "3）家庭实验室"
blue "4）  展示功能"
blue "5）CFT 工具箱"
blue "6）  潇洒现场"
blue "7）加密货币小部件"
blue "8）系统资源监控"
blue "9）首页"
blue "0）   "
read -p "所以请选择你的选择，。。。" reME
if [[ ${reME} = "1" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf1.yml
docker run -d \ 
  -p 8081:80 \
  -v /docker/dashy/conf1.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "2" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf2.yml
docker run -d \
  -p 8082:80 \
  -v /docker/dashy/conf2.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "3" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf3.yml
docker run -d \
  -p 8083:80 \
  -v /docker/dashy/conf3.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "4" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf4.yml
docker run -d \
  -p 8084:80 \
  -v /docker/dashy/conf4.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "5" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf5.yml
docker run -d \
  -p 8085:80 \
  -v /docker/dashy/conf5.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "6" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf6.yml
docker run -d \
  -p 8086:80 \
  -v /docker/dashy/conf6.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "7" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf7.yml
docker run -d \
  -p 8087:80 \
  -v /docker/dashy/conf7.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "8" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf8.yml
docker run -d \
  -p 8088:80 \
  -v /docker/dashy/conf8.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
elif [[ ${reME} = "9" ]]; then
wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf9.yml
docker run -d \
  -p 8089:80 \
  -v /docker/dashy/conf9.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
  elif [[ ${reME} = "0" ]]; then
  wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/dashy/conf0.yml
docker run -d \
  -p 8080:80 \
  -v /docker/dashy/conf0.yml:/app/public/conf.yml \
  --name my-dashboard \
  --restart=always \
  lissy93/dashy:latest
fi
