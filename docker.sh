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
blue   "docker 容器的相关优化及面板汇总"
green "docker优化："
yellow "docker开通IP6               （1）"
yellow "docker更换国内源             （2）"
green "docker面板安装："
yellow "Fast OS Docker面板          （3）"
yellow "Portainer面板               （4）"
blue   "拭目以待结果，lets go"
read -e -p "(输入为空则取消):" inMY
if [[ "$inMY" = "1" ]]; then
    yellow "docker开通IP6 ："
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "20m",
        "max-file": "3"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF
    sudo systemctl restart docker
    sudo systemctl enable docker
    if [ $? = '0' ]; then
        green "IP6开通优化完成✅✅✅！"
    elif [ $? != '0' ]; then
        red "优化失败，人工检查！"
        exit 1
    fi
# npm
elif [[ "$inMY" = "2" ]]; then
    yellow "docker更换国内源 ："
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/docker_yuan.sh -O -)"
    # wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/do/docker_yuan.sh && chmod +x docker_yuan.sh && bash docker_yuan.sh
    if [ $? = '0' ]; then
        green "更换国内源已完成✅✅✅！"
    elif [ $? != '0' ]; then
        red "更换失败，人工检查！"
        exit 1
    fi
elif [[ "$inMY" = "3" ]]; then
    yellow "Fast OS Docker面板 ："
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/fastos.sh -O -)"
    if [ $? = '0' ]; then
        green "Fast OS Docker面板 安装完成✅✅✅！"
    elif [ $? != '0' ]; then
        red "安装失败，人工检查！"
        exit 1
    fi
elif [[ "$inMY" = "4" ]]; then
    yellow "Portainer面板 ："
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
    if [ $? = '0' ]; then
        green "Portainer面板 安装完成✅✅✅！"
    elif [ $? != '0' ]; then
        red "安装失败，人工检查！"
        exit 1
    fi
fi
