#!/bin/bash
wget -N --no-check-certificate  https://raw.githubusercontent.com/xvmvx/new/main/MY.sh && chmod +x MY.sh  && bash MY.sh
if [[ ${MY} == "debian" ]]; then
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install git wget vim lsof unzip
elif [[ ${MY} == "ubuntu" ]]; then
  sudo apt-get update && sudo apt-get upgrade
  sudo apt-get install git wget vim lsof unzip
elif [[ ${MY} == "centos" ]]; then
  sudo yum update && sudo yum upgrade
  yum install wget git vim
fi
