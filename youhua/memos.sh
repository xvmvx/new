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
yellow "特点如下"
green "📅 方便记录每日 / 周计划"
green "💡 方便记录一些奇思妙想"
green "📕 可以随手写写读后感"
green "🏗️ 有时候可以代替在微信上经常使用的“文件传输助手”、手机的备忘录"
green "📒 可以打造一个属于自己的轻量化“卡片”笔记簿 "
yellow "相关地址"
green "官方Demo：https://demo.usememos.com/"
green "GitHub地址：https://github.com/usememos/memos (543 Star)"
green "那我们就开始安装吧，now。let‘s go！"
sudo -i
yellow "注意信息"
mkdir -p /docker/memos
CONF="/docker/memos"
if [[ -e ${CONF} ]]; then
	green "默认安装位置：/docker/memos"
  cd /docker/memos
else
	read -p "安装位置 $CONF 不正确，请手动录入新的地址: " CONF
fi

# 判断端口是否占用
port=5230
lsof -i:5230
green "默认使用端口：5230"
read -p "如需更改请输入新的端口：" port

read -p "可以使用docker(1)和docker-compose (2) 两种方式安装。。。" change
if [[ ${change} = "1" ]]; then
  docker run -d --name memos -p 5230:5230 -v /docker/memos/.memos/:/var/opt/memos neosmemo/memos:latest
elif [[ ${change} = "2" ]]; then
  cat > /docker/memos/docker-compose.yml <<EOF
version: "3"
services:
  memos:
    image: neosmemo/memos:latest
    container_name: memeos
    hostname: memeos
    ports:
      - "5230:5230"
    volumes:
      - /docker/memos/.memos/:/var/opt/memos
    restart: always
}
EOF
fi
