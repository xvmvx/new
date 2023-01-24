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
green "YOURLS是基于PHP的，一个可以让你在自己的服务器上运行的URL缩短服务。"
green "利用它，我们可以完全控制自己的数据，"
green "其中包括详细的统计、分析、还可以安装一些插件"
yellow "相关地址"

green "那我们就开始安装吧，now。let‘s go！"
yellow "注意信息"
mkdir -p /docker/yourls
CONF="/docker/yourls"
if [[ -e ${CONF} ]]; then
	green "默认安装位置：/docker/yourls"
  cd /docker/yourls
else
	read -p "安装位置 $CONF 不正确，请手动录入新的地址: " CONF
fi
  green "使用域名：https://jo.95118.works  做好解析"
  green "使用数据库： mysql:5.7.22     自行检查判断是否重复"
  green "数据库密码：Guwei888  自行检查判断是否修改"
  green "数据库用户名：goodway  自行检查判断是否修改"
  green "数据库名称：yourls  自行检查判断是否修改"
  green "数据库端口：   自行检查判断是否修改"
  
# 判断端口是否占用
port=8200
lsof -i:8200
green "默认使用端口：8200"
read -p "如需更改请输入新的端口：" port
  cat > /docker/yourls/docker-compose.yml <<EOF
version: "3.5"
services:

  mysql:
    image: mysql:5.7.22              # 如果遇到不正确的数据库配置，或无法连接到数据库PDOException: SQLSTATE[HY000] [1045] 用户'yourls'@'yourls_service.yourls_default'的访问被拒绝（使用密码：是）   可以把5.7.22 改为 5.7
    environment:
      - MYSQL_ROOT_PASSWORD=Guwei888
      - MYSQL_DATABASE=yourls
      - MYSQL_USER=goodway
      - MYSQL_PASSWORD=Guwei888
    volumes:
      - ./mysql/db/:/var/lib/mysql
      - ./mysql/conf/:/etc/mysql/conf.d
    restart: always
    container_name: mysql
  
  yourls:
    image: yourls
    restart: always
    ports:
      - "8200:80"
    environment:
      YOURLS_DB_HOST: mysql
      YOURLS_DB_USER: goodway
      YOURLS_DB_PASS: Guwei888
      YOURLS_DB_NAME: yourls
      YOURLS_USER: admin      # 自己起一个名字
      YOURLS_PASS: admin      # 自己换一个登陆密码
      YOURLS_SITE: https://95118.works  # 换成你自己的域名
      YOURLS_HOURS_OFFSET: 8
    volumes:
      - ./yourls_data/:/var/www/html   
    container_name: yourls_service
    links:
      - mysql:mysql
EOF
docker-compose up -d 
wget https://github.com/ZvonimirSun/YOURLS-zh_CN/archive/refs/tags/v1.7.3.zip
apt install zip -y
unzip v1.7.3.zip docker/yourls/yourls_data/user/languages
chown -R www-data:www-data zh_CN.mo  # 修改文件拥有者和组
chown -R www-data:www-data zh_CN.po  # 修改文件拥有者和组
green "修改第56和68行 61行改成true docker/yourls/yourls_data/user/config.php"
green "然后重启 docker-compose restart"
green "访问地址：http:服务ip:8200"
if [[ $? -eq 0 ]]; then
  green "确定域名已解析成功"
  yellow "npm添加反向代理"
  green "要选择Block和Websock，填解析好的域名，IP和端口22300"
  ip addr show docker0
  green "参考上面IP，SSL选Force一个，成功后选Force"

  green "http:服务ip:8200默认账号：admin@localhost"
  green "默认密码：admin"
fi
green "https://blog.laoda.de/archives/docker-compose-install-yourls"
