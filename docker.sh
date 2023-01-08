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
yellow " Docker 设置"
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
yellow  "npm是nginx反向代理设置的一个友好web操作界面，需要通过docker-compose安装。"
read "输入npm安装位置：           " npmFile
read "输入npm的web端口：           " npmPort
mkdir /docker
cd /
cd /docker
if [ -d "/docker/${npmFile}" ]; then
    rm -rf /docker/${npmFile}
    mkdir /docker/${npmFile}
else
    mkdir /docker/${npmFile}
fi
cd /docker/${npmFile}
cat > docker-compose.yml <<EOF
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF
lsof -i:81 && lsof -i:80 && lsof -i:443
if [ $? = '0' ]; then
    docker-compose up -d
    if [ $? = '0' ]; then
        green "${npmFile} 安装成功✅✅✅！  端口:${npmPort}"
        yello "其他注意事项⚠️⚠️⚠️： admin@example.com：changeme"
    else
        red "自动安装失败，请移动到对应文件夹，手动运行：     "
        green "docker-compose up -d "
        blue "进行安装，安装成功后帐号信息：admin@example.com：changeme"
   fi
fi
# portainer
elif [[ "$ddd" = "5" ]]; then
yellow  "portainer是docker的一个非常友好web操作界面"
read "输入portainer安装位置：           " pFile
read "输入portainer的web端口：           " pPort
mkdir /docker
cd /
cd /docker
if [ -d "/docker/${pFile}" ]; then
    rm -rf /docker/${pFile}
    mkdir /docker/${pFile}
else
    mkdir /docker/${pFile}
fi
cd /docker/${pFile}
lsof -i:81
if [ $? = '0' ]; then
    docker run -d --restart=always --name="portainer" -p 82:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce
    if [ $? = '0' ]; then
        green "portainer 安装成功✅✅✅！  端口:${pPort}"
    else
        red "安装失败，可输入数字尝试一键安装！"
        echo -n "输入要使用的安装命令：      > "
        read chara
        case $chara in
            1 ) 
                sh -c "$(curl -kfsSl https://gitee.com/expin/public/raw/master/onex86.sh)"
                ;;
            2 ) 
                docker run -d --restart=always --name portainer -p 82:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/data:/data -v /docker/portainer/public:/public portainer/portainer:latest
            ;;
            3 ) 
                docker run -d -p 82:8000 -p 82:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/data:/data portainer/portainer-ce:latest
            ;;
            4 )
                            cat > docker-compose.yml <<EOF
version: "3"
services:
  portainer:
      image: portainer/portainer
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - ~/portainer/data:/data
      ports:
        - 82:9000 
      container_name: portainer
volumes:
    data: 
EOF
                red "自动安装失败，请移动到对应文件夹，手动运行：     "
                green "docker-compose up -d "
                blue "进行安装，安装成功后帐号信息：admin@example.com：changeme"
            ;;
            * ) echo 输入不符合要求
            esac          
        fi
    fi
fi
