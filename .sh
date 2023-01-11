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

myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
yellow "${logo1}"
## [new](https://github.com/xvmvx/new)是新安装系统的维护
red "准备好了吗？"
blue "          0)系列------基础类"
green "比如更改端口/时区/端口的小脚本等等"
blue "          1)系列------web类"
green "比如监视/图形化服务器的各类面板等"
blue "          2)系列------网盘类"
green "比如离线下载ari2/nextcloud云等"
blue "          3)系列------目录类"
green "比如图床在线笔记远程桌面等"
yellow "输入对应数字浏览相关细节，返回 00 "
read -p ":   " inCHANGE
if [ ${#inCHANGE} = "1" ]; then
    case "$inCHANGE" in
        0)
            green "01   更改端口的小脚本"
            green "02   alias缩短命令使用"
            green "03   宝塔面板的相关操作"
            green "04   nginx反向代理管理"
            green "05   Docker相关的操作"
            green "06   Fast OS面板的安装"
            green "07   Docker可视面板安装"
        ;;
        1)
            green "11   dashy面板"
            green "12   Hexo 面板"
            green "13   Ward面板"
            green "14   ServerStatus面板"
            green "15   Uptime Kuma面板"
            green "16   Guacamole远程RAC&SSH"
            green "17   VPN & noVPN"
            green "18   cryptgeon"
            green "19   FRP+NPM+VP"
        ;;
        2)
            green "21   aria2"
            green "22   nextcloud"
            green "23   Cloudreve"
            green "24   FileRun"
            green "25   Wiki.js"
            green "26   Trilium"
            green "27   Joplin"
            green "28   为知笔记"
            green "29   Rocket"
        ;;
        3)
            green "31   楼兰图床"
            green "32   AllTube"
            green "33   Fireshare"
            green "34   platform"
            green "35   searxng"
            green "36   Pingvin"
            green "37   Syncthing"
            green "38   ZFile"
            green "39   Memos"
        ;;
        *)
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
elif [ ${#inCHANGE}  = "2" ]; then
    a$inCHANGE
elif [ ${#inCHANGE}  = "0" ]; then
    red "请输入正确数字 !"
fi
#01 更改端口的小脚本
function a01(){
# wget -O "/root/unixbench.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/unixbench.sh" --no-check-certificate -T 30 -t 5 -d
# curl -o- -L https://raw.githubusercontent.com/xvmvx/new/main/ssh22.sh | bash -s -- --version 0.16.1
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/ssh22.sh -O -)"
}
#02   alias缩短命令使用
function a02(){
wget https://raw.githubusercontent.com/xvmvx/new/main/my.bashrc
mv /my.bashrc ~/.bashrc
source ~/.bashrc
}
#03   宝塔面板的相关操作
function a03(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/baota.sh -O -)"
}
#04   nginx反向代理管理
function a04(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/npm.sh -O -)"
}
#05   Docker相关的操作
function a05(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/docker.sh-O -)"
}
#06   Fast OS面板的安装
function a06(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/fastos.sh -O -)"
}
#07   Docker可视面板安装"
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#11   dashy面板
function a11(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/dashy/dashy.sh -O -)"
}
#12   Hexo 面板  ???????????
function a12(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#13   Ward面板
function a13(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/ward.sh -O -)"
}
#14   ServerStatus面板
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#15   Uptime Kuma面板
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#16   Guacamole远程RAC&SSH
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#17   VPN & noVPN
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#18   cryptgeon
function a07(){
sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh -O -)"
}
#19   FRP+NPM+VP"
blue "我们有 （2)系列------网盘类"

blue "我们有 （3)系列------目录类"


* [ssh-22](https://github.com/xvmvx/new/ssh22.sh)            ----------更改端口的小脚本
* [bashrc](https://github.com/xvmvx/new/my.bashrc)             ----------alias缩短命令使用
* [Nginxp](http://165.22.62.26:81)                 ----------反向代理神器_________________[安装]()  [详见](https://blog.laoda.de/archives/nginxproxymanager)
* [docker](https://github.com/xvmvx/new/docker.sh)----------是为了docker的安装；还有一个 [备用docker安装](https://github.com/xvmvx/new/docker1.sh)一键安装的一个脚本 
* [Fast_OS_docker](http://165.22.62.26:85)可视化面板----------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/fastos.sh) [官网](https://www.dockernb.com/)
* [Portainer-ce社区版](http://165.22.62.26:81)----------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/portainer.sh) [官网](https://www.portainer.io/)
## web面板blog
### 监控类
* [dashy面板](http://165.22.62.26:83/)是一个监控服务状态的面板工具。--------------[安装](https://raw.githubusercontent.com/xvmvx/new/main/dashy.sh)反代时注意端口选择Block一项,激活需要重启，[详见](https://blog.laoda.de/archives/docker-compose-install-dashy)
* [Umami面板](http://165.22.62.26:3000/)网站流量监控面板--------------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/umami.sh)[详见](https://blog.laoda.de/archives/umami)
* [Ward面板] 服务器监控面板--------------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/ward.sh)[详见](https://blog.laoda.de/archives/ward-serverstatus-install)
* [ServerStatus面板]()服务器监控面板--------------[安装]( )[详见](https://blog.laoda.de/archives/ward-serverstatus-install)
* [Uptime Kuma面板]()网站监控--------------[安装]( )[详见](https://blog.laoda.de/archives/uptimekuma-install)
### blog
* [Hexo 面板](http://165.22.62.26:999/)blog在线管理--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-hexo-admin-and-twikoo)

### 远程类
* [Guacamole](https://blog.laoda.de/archives/docker-install-guacamole)远程桌面网关服务
* [noVPN](http://165.22.62.26:63/)Ubuntu的桌面系统--------------[安装]( )[详见](https://blog.laoda.de/archives/install-ubuntu-desktop)
### 网络类
* [cryptgeon](https://blog.laoda.de/archives/docker-compose-install-cryptgeon) 内网穿透--
* [FRP+NPM+VPS](https://blog.laoda.de/archives/frp-with-nginx-proxy-manager) 内网穿透--
### 网盘类
* [aria2]离线下载神器-----------------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/aria2.sh)[详见](https://github.com/P3TERX/aria2.sh)
* [nextcloud](http://165.22.62.26:82/)--------------[安装](https://raw.githubusercontent.com/xvmvx/new/main/do/nextcloud.sh)[详见](https://github.com/nextcloud/all-in-one#nextcloud-all-in-one)
* [AList](https://blog.laoda.de/archives/docker-install-alist)网盘直链程序——
* [Cloudreve]()--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-lighthouse-cloudreve)
* [FileRun](http://165.22.62.26:74/)--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-filerun)
### 笔记类
* [Wiki.js](http://165.22.62.26:72)Wiki软件--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-wikijs)
* [Trilium](http://165.22.62.26:73/)个人知识库--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-trilium)
* [为知笔记](http://165.22.62.26:8123/)--------------[安装]( )[详见]()
* [Joplin]()同步笔记软件--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-joplin-server)
### 通讯类
* [Rocket.chat](https://blog.laoda.de/archives/docker-compose-install-rocketchat) IM聊天系统——
### 媒体类
* [楼兰图床](https://blog.laoda.de/archives/docker-compose-install-lskypro)
* [AllTube](https://blog.laoda.de/archives/docker-compose-install-alltube)视频下载服务——
* [Fireshare](https://blog.laoda.de/archives/docker-compose-install-fireshare)#视频分享网站——
### 搜索类
* [platform](http://165.22.62.26:1228/)--------------[安装]( )[详见]()
* [searxng](http://165.22.62.26:1008/)专注于搜索的--------------[安装]( )[详见]( )
* [Pingvin Share](http://165.22.62.26:1228/)--------------[安装]( )[详见]( )

### 目录类
* [Syncthing]()开源同步工具--------------[安装]( )[详见](https://blog.laoda.de/archives/docker-compose-install-syncthing)
* [ZFile](https://blog.laoda.de/archives/docker-compose-install-zfile)在线文件目录的程序--
* [Memos](https://blog.laoda.de/archives/docker-install-memos)碎片化知识卡片管理工具——
