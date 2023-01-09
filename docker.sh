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
red "############  Docker  #################"
yellow " Docker  基本安装"
yellow " Docker- compose 安装"
yellow " Docker IP6开通"
yellow " Docker 更换国内源"
yellow " Fast OS Docker面板"
yellow " NPM 安装"
yellow " Portainer 安装"
red "安装Docker(1),Docker- compose(2),设置(3),NPM（4),Portainer（5）"
read -p "："  ddd
if [[ "$ddd" = "1" ]]; then
    yellow "安装Docker："
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update 
    sudo apt-get install  ca-certificates  curl  gnupg  lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
     sudo apt-get update
     sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
     if [ $? = '0' ]; then
        green "Docker...安装完成✅✅✅！"
     else
        red "安装失败，可输入数字尝试一键安装！"
        echo -n "输入要使用的安装命令：      > "
        read character
        case $character in
            1 ) 
                source docker1.sh
            ;;
            2 ) 
                curl -fsSL https://get.docker.com | bash -s docker
            ;;
            3 ) 
                source docker2.sh
            ;;
            * ) echo 输入不符合要求
            esac          
        fi
# docker-dompose
elif [[ "$ddd" = "2" ]]; then
    sudo apt install docker-compose  
    if [ $? = '0' ]; then
         green "【docker-compose】...安装完成✅✅✅！"
    else
        red "安装失败，可输入数字尝试一键安装！"
        echo -n "输入要使用的安装命令：      > "
        read character
        case $character in
            1 ) 
                bash <(curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/DockerInstallation.sh)
            ;;
            2 ) 
                curl -L https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-linux-`uname -m` > ./docker-compose
            ;;
            3 ) 
                source docker1.sh
            ;;
            * ) echo 输入不符合要求
            esac          
        fi

# docker优化
elif [[ "$ddd" = "3" ]]; then
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
        green "优化完成✅✅✅！"
    elif [ $? != '0' ]; then
        red "优化失败，人工检查！"
        exit 1
    fi
# npm
elif [[ "$ddd" = "4" ]]; then
    wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/do/docker_yuan.sh && chmod +x docker_yuan.sh && bash docker_yuan.sh
     if [ $? = '0' ]; then
        green "已完成国内源更换✅✅✅！"
    elif [ $? != '0' ]; then
        red "更换失败，人工检查！"
        exit 1
    fi
elif [[ "$ddd" = "5" ]]; then
    wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/do/fastos.sh && chmod +x fastos.sh  && bash fastos.sh
elif [[ "$ddd" = "6" ]]; then
    wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh && chmod +x portainer.sh  && bash portainer.sh
fi

