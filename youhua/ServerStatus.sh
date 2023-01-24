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
green "是基于cppla版本ServerStatus"
green "增加功能：更方便的节点管理, 支持增删改查"
green "上下线通知（Telegram）"
green "Agent机器安装脚本改为systemd， 支持开机自启。"
yellow "相关地址"
green "项目地址：https://github.com/lidalao/ServerStatus"
green "那我们就开始安装吧，now。let‘s go！"
sudo -i
yellow "注意信息"
mkdir -p /docker/ServerStatus
CONF="/docker/ServerStatus"
if [[ -e ${CONF} ]]; then
	green "默认安装位置：/docker/ServerStatus"
  cd /docker/ServerStatus
else
	read -p "安装位置 $CONF 不正确，请手动录入新的地址: " CONF
fi
  green "使用域名：https://wa.95118.works  做好解析"
  green "自定义端口号：40000  自行检查判断是否修改"

# 判断端口是否占用
port=4000
lsof -i:4000
green "默认使用端口：4000"
read -p "如需更改请输入新的端口：" port
  docker run -d --name ward -p 4000:4000 \
-p 40000:40000 \
--privileged=true \
--restart always \
ward:latest
if [[ $? -eq 0 ]]; then
  green "确定域名已解析成功"
  yellow "npm添加反向代理"
  green "BLOCK选择，填解析好的域名，IP和端口4000"
  ip addr show docker0
  green "参考上面IP，SSL选Force一个，成功后选Force和HTTP/2"
  green "http://IP:4000/  账号密码：suibian"
  green ""
fi
green "https://blog.laoda.de/archives/ward-serverstatus-install"
