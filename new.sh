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

myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
yellow "${logo1}"
red "########################################"
    blue  "人            性"
    blue  "  之        本"
    blue  "    初    善"
    green  "     王8蛋"
red "美好的人生从这里开始。。。"
yellow "升级你的系统？（1），yes。you do！"
blue "部署基础环境？（2），yes。you can！"
green "完成应用服务？（3），now。let‘s go！"
wget https://raw.githubusercontent.com/xvmvx/new/main/my.bashrc
mv ~/.bashrc ~/.bashrc.back
mv my.bashrc ~/.bashrc 
sudo source ~/.bashrc 
read -p "所以请选择你的选择。。。" change
if [[ ${change} = "1" ]]; then
    wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/1.sh && chmod +x 1.sh  && bash 1.sh
elif [[ ${change} = "2" ]]; then
     wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/2.sh && chmod +x 2.sh  && bash 2.sh
elif [[ ${change} = "3" ]]; then
     wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/3.sh && chmod +x 3.sh  && bash 3.sh
fi
