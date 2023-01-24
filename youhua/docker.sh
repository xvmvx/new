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
yellow "${logo1}"
green "一些常用的，比如：笔记（1），网盘（2）now。let‘s go！"
green "一些有用的，比如：面板（3），工具（4）now。let‘s go！"
green "一些要用的，比如：图床（5），blog（6）now。let‘s go！"
green "一些想用的，比如：？？（7），？？（8）now。let‘s go！"
read -p "所以请选择你的选择。。。" change
if [[ ${change} = "1" ]]; then
  green "Memos是个不错的选择，碎片化知识卡片管理工具，输入“1”，开始安装"
  green "joplin号称OneNote、印象笔记的替代品，输入“2”，开始安装"
  read -p "所以请选择你的选择。。。" change1
  if [[ ${change1} = "1" ]]; then
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/memos.sh -O -)"
  elif [[ ${change1} = "2" ]]; then
    sh -c "$(wget https://raw.githubusercontent.com/xvmvx/new/main/youhua/joplin.sh -O -)"
  fi
fi
