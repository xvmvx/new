#!/bin/bash
echo "国内服务器选择1，国外2,都不行试试下面"
echo "docker pull hub-mirror.c.163.com/6053537/portainer-ce"
echo "docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce"
read -p " :" change
if [ $change = "1" ]; then
  docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock hub-mirror.c.163.com/6053537/portainer-ce
elif [ $change = "2" ]; then
  docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock 6053537/portainer-ce
fi
