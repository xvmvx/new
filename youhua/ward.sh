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
green "Ward 是一个使用 Java 开发的简单而简约的服务器监控工具。"
green "Ward 支持自适应设计系统"
green "它还支持深色主题"
green "它只显示服务器的主要信息。"
green "Ward 在所有流行的操作系统上运行良好，因为它使用 OSHI。"
yellow "相关地址"
green "项目地址：https://github.com/B-Software/Ward"
green "那我们就开始安装吧，now。let‘s go！"
sudo -i
yellow "注意信息"
mkdir -p /docker/ward
CONF="/docker/ward"
if [[ -e ${CONF} ]]; then
	green "默认安装位置：/docker/ward"
  cd /docker/ward
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
