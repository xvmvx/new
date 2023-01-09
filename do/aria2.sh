#!/bin/basn
sudo apt install wget curl ca-certificates
wget -N git.io/aria2.sh && chmod +x aria2.sh
curl https://rclone.org/install.sh | sudo bash
echo "alias a2start='/etc/init.d/aria2 start | service aria2 start'">>> ~/.bashrc
echo "alias a2stop='/etc/init.d/aria2 stop | service aria2 stop'">>> ~/.bashrc
echo "alias a2restart='/etc/init.d/aria2 restart | service aria2 restart'">>> ~/.bashrc
echo "alias a2status='/etc/init.d/aria2 status | service aria2 status'">>> ~/.bashrc
echo "alias a2set='vim /root/.aria2c/aria2.conf'">>> ~/.bashrc
source ~/.bashrc
echo "配置文件有中文注释，若语言设置有问题会导致中文乱码 使用a2set进行配置"
echo "默认下载目录：/root/downloads  RPC 密钥：随机生成，可使用选项7. 修改 配置文件自定义"
