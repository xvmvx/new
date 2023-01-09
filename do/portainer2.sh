 && bash docker_yuan.sh
     if [ $? = '0' ]; then
        green "已完成国内源更换✅✅✅！"
    elif [ $? != '0' ]; then
        red "更换失败，人工检查！"
        exit 1
    fi
yellow  "npm是nginx反向代理设置的一个友好web操作界面，需要通过docker-compose安装。"
read "输入npm安装位置：           " npmFile
npmFile=$npmFile
read "输入npm的web端口：           " npmPort
npmPort=$npmPort
mkdir /docker
cd /
cd /docker
if [ -d "/docker/${npmFile}" ]; then
    rm -rf /docker/${npmFile}
    mkdir /docker/${npmFile}
else
    mkdir /docker/${npmFile}
fi
cd /docker/${npmFile}
cat > docker-compose.yml <<EOF
version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF
lsof -i:81 && lsof -i:80 && lsof -i:443
if [ $? = '0' ]; then
    docker-compose up -d
    if [ $? = '0' ]; then
        green "${npmFile} 安装成功✅✅✅！  端口:${npmPort}"
        yello "其他注意事项⚠️⚠️⚠️： admin@example.com：changeme"
    else
        red "自动安装失败，请移动到对应文件夹，手动运行：     "
        green "docker-compose up -d "
        blue "进行安装，安装成功后帐号信息：admin@example.com：changeme"
   fi
fi
# portainer
elif [[ "$ddd" = "5" ]]; then
yellow  "portainer是docker的一个非常友好web操作界面"
read "输入portainer安装位置：           " pFile
pFile=$pFile
read "输入portainer的web端口：           " pPort
pFile=$pFile
mkdir /docker
cd /
cd /docker
if [ -d "/docker/${pFile}" ]; then
    rm -rf /docker/${pFile}
    mkdir /docker/${pFile}
else
    mkdir /docker/${pFile}
fi
cd /docker/${pFile}
lsof -i:81
if [ $? = '0' ]; then
    docker run -d --restart=always --name="portainer" -p 82:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data 6053537/portainer-ce
    if [ $? = '0' ]; then
        green "portainer 安装成功✅✅✅！  端口:${pPort}"
    else
        red "安装失败，可输入数字尝试一键安装！"
        echo -n "输入要使用的安装命令：      > "
        read chara
        case $chara in
            1 ) 
                sh -c "$(curl -kfsSl https://gitee.com/expin/public/raw/master/onex86.sh)"
                ;;
            2 ) 
                docker run -d --restart=always --name portainer -p 82:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/data:/data -v /docker/portainer/public:/public portainer/portainer:latest
            ;;
            3 ) 
                docker run -d -p 82:8000 -p 82:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/data:/data portainer/portainer-ce:latest
            ;;
            4 )
                            cat > docker-compose.yml <<EOF
version: "3"
services:
  portainer:
      image: portainer/portainer
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - ~/portainer/data:/data
      ports:
        - 82:9000 
      container_name: portainer
volumes:
    data: 
EOF
                red "自动安装失败，请移动到对应文件夹，手动运行：     "
                green "docker-compose up -d "
                blue "进行安装，安装成功后帐号信息：admin@example.com：changeme"
            ;;
            * ) echo 输入不符合要求
            esac          
        fi
    fi
fi
