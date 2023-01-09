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
MY=${release}
myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
yellow "${logo1}"
red "########################################"
    blue -e "人            性"
    blue -e "  之        本"
    blue -e "    初    善"
    green -e "     王8蛋"
red "美好的人生从这里开始。。。"
yellow "升级你的系统？（1），yes。you do！"
blue "部署基础环境？（2），yes。you can！"
green "完成应用服务？（3），now。let‘s go！"
read -p "所以请选择你的选择。。。" change
if [[ ${change} = "1" ]]; then

if [[ ${change} = "2" ]]; then

if [[ ${change} = "3" ]]; then

fi
# 系统升级
blue "工欲善其事，必先利其器！"
green "从优化系统环境开始（1），当然，你可以选择其他的更多选。。。。。。。"
read -p "所以请选择你的选择，确认升级（1)。。。" reME
if [[ ${reME} = "1" ]]; then
    wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/shengji.sh && chmod +x shengji.sh  && bash shengji.sh
    green "系统更新。。。完成✅✅✅！"
fi

# 设置alias
green "天下武功，唯快不破。。。想要加快操作的速度（1），当然，你可以选择其他的更多选择。。。。。。。"
read -p "所以请选择你的选择，确认使用alias（1)。。。" realias
if [[ ${realias} = "1" ]]; then
    mv ~/.bashrc ~/.bashrc.back
    cp my.bashrc ~/.bashrc
    source ~/.bashrc
    green "linux命令alias化。。。完成✅✅✅！"
fi

#设置时区
green "切莫在数着他国星辰，渡着自己光阴。。。较正时区（1），当然，你可以选择其他的更多选择。。。。。。。"
read -p "所以请选择你的选择，修改为上海时区（1)。。。" retime
if [[ ${retime} = "1" ]]; then
    sudo timedatectl set-timezone Asia/Shanghai #改成上海
    green "更改时区为上海。。。完成✅✅✅！"
fi

#更改ssh端口
green "不怕贼偷，就怕贼惦记！从源头死了他的心（1），当然，你可以选择其他的更多选择。。。。。。。"
read -p "所以请选择你的选择，更改SSH端口（1)。。。" retime
if [[ ${retime} = "1" ]]; then
    wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/ssh22.sh && chmod +x ssh22.sh  && bash ssh22.sh
    green "更改SSH端口。。。完成✅✅✅！"
fi

#更改ssh端口
green "分身？遁形？是否还记得你心里的那个我是哪个我？（1），当然，你可以选择其他的更多选择。。。。。。。"
read -p "所以请选择你的选择，增加新的root用户（1)。。。" retime
if [[ ${retime} = "1" ]]; then
    wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/addUSER.sh && chmod +x addUSER.sh  && bash addUSER.sh
    green "增加root用户。。。完成✅✅✅！"
fi

elif [[ ${reME} = "0" ]]; then

fi
blue -e "请选择要安装的面板："
yellow "1. 宝塔面板"
yellow "2. AMH面板"
yellow "3. DOCKER"
yellow "4. webmin面板"
read -e -p "(输入为空则取消):" inMY
if [[ ${inMY} == "1" ]]; then
    echo -e "宝塔面板>>>要执行的操作："
    echo "1. 官方安装"
    echo "2. 开心安装"
    echo "3. 全新安装"
    echo "4. 升级代码"
    echo "5. 还原到官方最新版"
    echo "6. 卸载宝塔"
    read -e -p "(输入为空则取消):" inBT
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
elif [[ ${inMY} == "2" ]]; then
    # amh面板
    wget http://dl.amh.sh/amh.sh && bash amh.sh
    if [ $? = '0' ]; then
        green "amh安装完成✅✅✅！"
    else
        red "安装失败，人工检查！"
    fi
elif [[ ${inMY} == "3" ]]; then
    # Docker
    source docker.sh
    if [ $? = '0' ]; then
        green "Docker安装完成✅✅✅！"
    else
        red "安装失败，人工检查！"
    fi
elif [[ ${inMY} == "4" ]]; then
    if [[ ${MY} == "centos" ]]; then
        (echo "[Webmin]
        name=Webmin Distribution Neutral
        baseurl=http://download.webmin.com/download/yum
        enabled=1
        gpgcheck=1
        gpgkey=http://www.webmin.com/jcameron-key.asc" >/etc/yum.repos.d/webmin.repo;
        yum -y install webmin)
    else
        wget -qO - http://www.webmin.com/jcameron-key.asc | sudo apt-key add -
        sudo sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
        sudo apt update
        sudo apt install webmin
    fi
    if [ $? = '0' ]; then
        green "Webmin安装完成✅✅✅！"
    else
        red "安装失败，人工检查！"
    fi
fi
