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

CONF="/etc/rc.d/rc.local.back"
if [[ -e ${CONF} ]]; then
  rm -rf /etc/rc.d/rc.local
  mv /etc/rc.d/rc.local.back  /etc/rc.d/rc.local
fi
green "安装必要的基础环境是非常有用的，now。let‘s go！"
read -p "所以请选择你的选择。Y(听我的),N(你偏不)。。" change
if [[ ${change} = "y" ]]; then
  green "Docker是个不错的选择，输入“1”，开始安装"
  green "当然，宝塔也是非常的优秀，“2”是宝塔，"
  read -p "代理反射代理，映射穿透交给npm “3” 吧，也可以退出" change1
  if [[ ${change1} = "1" ]]; then
    green "傻逼中国真的傻逼，下载国际的应用会很慢"
    read -p "所以“1”是国内服务器，“2”是国际的 " change2
    if [[ ${change2} = "1" ]]; then
      curl -sSL https://get.daocloud.io/docker | sh
      docker -v  #查看 docker 版本
      systemctl enable docker  # 设置开机自动启动
      curl -L https://get.daocloud.io/docker/compose/releases/download/v2.1.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose
      docker-compose --version  #查看 docker-compose 版本
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
    systemctl restart docker
    elif [[ ${change2} = "2" ]]; then
      wget -qO- get.docker.com | bash
      docker -v  #查看 docker 版本
      systemctl enable docker  # 设置开机自动启动
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      docker-compose --version  #查看 docker-compose 版本
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
systemctl restart docker
    fi
  elif [[ ${change1} = "2" ]]; then
     wget -N --no-check-certificate https://raw.githubusercontent.com/xvmvx/new/main/3.sh && chmod +x 3.sh  && bash 3.sh
  elif [[ ${change1} = "3" ]]; then
    sudo -i
    mkdir -p docker/npm
    cd docker/npm
    cat > docker/npm/docker-compose.yml <<EOF
{
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '1080:80'  # 冒号左边可以改成自己服务器未被占用的端口
      - '1081:81'  # 冒号左边可以改成自己服务器未被占用的端口
      - '10443:443' # 冒号左边可以改成自己服务器未被占用的端口
    volumes:
      - ./data:/data # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 data 文件夹中
      - ./letsencrypt:/etc/letsencrypt  # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 letsencrypt 文件夹中
}
EOF
    lsof -i:1081  #查看 81 端口是否被占用，如果被占用，重新自定义一个端口
    if [ $? != '0' ]; then
      apt install lsof  #安装 lsof
      lsof -i:1081
      if [ $? != '0' ]; then
         echo "要使用1081端"
      fi
    fi
    docker-compose up -d 
    IP = curl ip.sb
    if [ $? != '0' ]; then
      echo "地址: http://$IP:1081"
      echo "用户名： admin@example.com"
      echo "密码: changeme"
    fi
  fi
fi
