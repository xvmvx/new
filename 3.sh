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
if [[ -f /etc/redhat-release ]]; then
  release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
  release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
  release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
  release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
  release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
  release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
  release="centos"
fi
wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/MY.sh && chmod +x MY.sh  && bash MY.sh
myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
clear
yellow "${logo1}"
red "########################################"
blue   "docker 容器的相关操作及安装汇总"
green "docker安装："
yellow "docker官方安装               （1）"
yellow "docker compose官方安装       （2）"
green "docker集成安装："
yellow "docker集成安装包              （3）"
green "docker一键安装："
yellow "docker一键安装包              （4）"
yellow "docker一键安装包              （5）"
blue   "拭目以待结果，lets go"
read -e -p "(输入为空则取消):" inMY
if [[ "$inMY" = "1" ]]; then
    yellow "安装Docker官方："
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update 
    sudo apt-get install  ca-certificates  curl  gnupg  lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，是否尝试一键安装（Y)！"
       read character
       if [ "$character" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker1.sh -O -)"
       fi
    fi
elif [[ "$inMY" = "2" ]]; then
    yellow "安装Docker compose官方："
    curl -L https://get.daocloud.io/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，是否尝试一键安装（Y)！"
       read character
       if [ "$character" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker1.sh -O -)"
       fi
    fi
elif [[ "$inMY" = "3" ]]; then
    yellow "安装Docker集成安装包："
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker1.sh -O -)"
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，自己检查检查"
    fi
elif [[ "$inMY" = "4" ]]; then
  yellow "安装Docker一键安装包："
  sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker2.sh -O -)"
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，自己检查检查"
    fi
elif [[ "$inMY" = "5" ]]; then
  yellow "安装Docker一键安装包的另一版本："
  curl -fsSL https://get.docker.com | bash -s docker
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，自己检查检查"
    fi
elif [[ "$inMY" = "6" ]]; then
  yellow "安装Docker一键安装包的又一版本："
  sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker1.sh -O -)"
    if [ $? = '0' ]; then
       green "Docker...安装完成✅✅✅！"
       yellow "强烈建议对Docker进行优化，听我的，按y"
       read character1
       if [ "$character1" = "y" ]: then
           sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh -O -)"
       fi
    else
       red "安装失败，自己检查检查"
    fi
fi
