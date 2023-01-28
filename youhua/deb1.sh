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
yellow "${logo1}"
red "########################################"
    blue  "人            性"
    blue  "  之        本"
    blue  "    初    善"
    green  "     王8蛋"
red "美好的人生从这里开始。。。"
yellow "现在开始升级你的系统，这是bixu的！"
sudo
if [ $? != 0 ]; then
  yellow "需要sudo，如不可运行，su root 和 apt install sudo，这是bixu的！"
  yellow "安装完成后执行 ./deb1.sh"
fi
sudo apt update -y   && sudo apt upgrade -y# 升级packages
apt install wget curl  vim git -y  # Debian系统比较干净，安装常用的软件
wget https://raw.githubusercontent.com/xvmvx/new/main/my.bashrc
mv ~/.bashrc ~/.bashrc.back
mv my.bashrc ~/.bashrc 
sudo source ~/.bashrc 
blue "SWAP虚拟内存，是否需要添加？y(yes)=you can！n(no)=you run！"
read -p "所以请选择你的选择。。。" change
if [[ ${change} = "y" ]]; then
    wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/youhua/swap.sh && chmod +x swap.sh  && bash swap.sh
fi
blue "SWAP虚拟内存已完成，此时重启你的机器是明知的？y(yes)=you can！n(no)=you run！"
read -p "所以请选择你的选择。。。" change2
if [[ ${change2} = "y" ]]; then
    wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/new.sh  /root/new.sh && chmod +x new.sh 
    cp /etc/rc.d/rc.local /etc/rc.d/rc.local.back
    echo "/root/new.sh" >> /etc/rc.d/rc.local
    reboot
fi
