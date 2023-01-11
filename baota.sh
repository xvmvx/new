#!/bin/bash
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
clear
MY=$release
wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/MY.sh && chmod +x MY.sh  && bash MY.sh
myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
yellow "${logo1}"
red "########################################"
red  "宝塔面板>>>要执行的操作："
yellow "1. 官方安装"
yellow "2. 开心安装"
yellow "3. 全新安装"
yellow "4. 升级代码"
yellow "5. 还原到官方最新版"
yellow "6. 卸载宝塔"
read  -p "(输入为空则取消):" inBT
if [[ ${inBT} == "1" ]]; then
  if [[ ${MY} == "debian" ]]; then
    # Debian全新安装命令：
    wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh 12f2c1d72
  elif [[ ${MY} == "ubuntu" ]]; then
    # ubuntu/Deepin全新安装命令：
            wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh 12f2c1d72
        elif [[ ${MY} == "centos" ]]; then
            # Centos全新安装命令：根据系统执行框内命令开始安装（大约2分钟完成面板安装）升级后可能需要重启面板
            yum install -y wget && wget -O install.sh https://download.bt.cn/install/install_6.0.sh && sh install.sh 12f2c1d72
        else
            # Fedora全新安装命令：
            curl -sSO https://download.bt.cn/install/install_panel.sh && bash install_panel.sh 12f2c1d72
        fi
elif [[ ${inBT} == "2" ]]; then
        wget -O install.sh http://f.cccyun.cc/bt/install_6.0.sh && bash install.sh
        sed -i "s|bind_user == 'True'|bind_user == 'XXXX'|" /www/server/panel/BTPanel/static/js/index.js
        rm -f /www/server/panel/data/bind.pl
        curl -sSO https://raw.githubusercontent.com/ztkink/bthappy/main/one_key_happy.sh && bash one_key_happy.sh
        wget -O optimize.sh http://f.cccyun.cc/bt/optimize.sh && bash optimize.sh
elif [[ ${inBT} == "3" ]]; then
        if [[ ${MY} == "debian" ]]; then
            # Debian全新安装命令：
            wget -O install.sh http://v7.hostcli.com/install/install-ubuntu_6.0.sh && bash install.sh
        elif [[ ${MY} == "ubuntu" ]]; then
            # ubuntu/Deepin全新安装命令：
            wget -O install.sh http://v7.hostcli.com/install/install-ubuntu_6.0.sh && sudo bash install.sh
        elif [[ ${MY} == "centos" ]]; then
            # Centos全新安装命令：根据系统执行框内命令开始安装（大约2分钟完成面板安装）升级后可能需要重启面板
            yum install -y wget && wget -O install.sh http://v7.hostcli.com/install/install_6.0.sh && sh install.sh
        else
            # Fedora全新安装命令：
            wget -O install.sh http://v7.hostcli.com/install/install_6.0.sh && bash install.sh
        fi
elif [[ ${inBT} == "4" ]]; then
        # 升级代码/修复面板：已经安装官方面板，执行下列命令升级到7.6.0纯净版：
        curl http://v7.hostcli.com/install/update6.sh|bash
        # 其他非官方版本含开心版、快乐版、纯净版等 7.4.5至7.6.0版本之间所有版本均可，执行下列命令升级到7.6.0纯净版：
        curl http://v7.hostcli.com/install/update6.sh|bash
elif [[ ${inBT} == "5" ]]; then
        # 任意非官方版本还原到官方最新版：
        curl http://download.bt.cn/install/update6.sh|bash
elif [[ ${inBT} == "6" ]]; then
        wget http://download.bt.cn/install/bt-uninstall.sh
        sh bt-uninstall.sh
fi
    if [ $? = '0' ]; then
        green "宝塔安装完成✅✅✅！"
    else
        red "安装失败，人工检查！"
    fi
