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
clear
MY=${release}
myIP1=$(curl ip.sb)
myIP2=$(ip route get 1 | awk '{print $7;exit}')
yellow "${logo1}"
red "########################################"
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
