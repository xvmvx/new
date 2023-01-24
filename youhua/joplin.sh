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
green "Joplin是一个免费、开源的笔记和待办事项的软件"
green "支持搜索，笔记格式是Markdown"
green "支持网页剪裁，可以从你的浏览器中保存网页和截图，也可用于火狐和Chrome"
green "可以使用端对端加密与各种云服务安全地同步，包括Nextcloud、Dropbox、OneDrive和Joplin Cloud"
green "允许你与任何Joplin客户端进行同步，就像你与Dropbox、OneDrive等进行同步一样"
yellow "相关地址"
green "GitHub原项目地址（感谢作者的付出）：https://github.com/laurent22/joplin（30.6k star）"
green "Docker镜像地址：https://hub.docker.com/r/joplin/server"
green "官网地址：joplinapp.org"
green "那我们就开始安装吧，now。let‘s go！"
sudo -i
yellow "注意信息"
mkdir -p /docker/joplin
CONF="/docker/joplin"
if [[ -e ${CONF} ]]; then
	green "默认安装位置：/docker/joplin"
  cd /docker/joplin
else
	read -p "安装位置 $CONF 不正确，请手动录入新的地址: " CONF
fi
  green "使用域名：https://jo.95118.works  做好解析"
  green "使用数据库：postgres:13  自行检查判断是否重复"
  green "数据库密码：Guwei888  自行检查判断是否修改"
  green "数据库用户名：goodway  自行检查判断是否修改"
  green "数据库名称：joplin  自行检查判断是否修改"
  green "数据库端口：5432  自行检查判断是否修改"
  
# 判断端口是否占用
port=22300
lsof -i:22300
green "默认使用端口：22300"
read -p "如需更改请输入新的端口：" port
  cat > /docker/joplin/docker-compose.yml <<EOF
# 这是一个示例docker-compose文件，可用于运行Joplin Server和PostgreSQL服务器。
#
# 更新下面这一节中的以下字段：
#
# POSTGRES_USER
# POSTGRES_PASSWORD
# APP_BASE_URL
#
# APP_BASE_URL：这是服务将在其中运行的基本公共URL。
#    -如果需要通过互联网访问Joplin服务器，请按如下方式配置APP_BASE_URL：https://example.com/joplin.。
#    -如果Joplin服务器不需要通过互联网访问，请将APP_BASE_URL设置为您的服务器的主机名。
#    例如：http://[hostname]：22300  基本URL可以包括端口。
# APP_PORT：Docker容器监听的本地端口。
#    -这通常会通过反向代理映射到端口到443(TLS)。
#    -如果Joplin服务器不需要可以通过互联网访问，则可以将端口映射到22300。

version: '3'

services:
    db:
        image: postgres:13
        volumes:
            - ./data/postgres:/var/lib/postgresql/data
        ports:
            - "5432:5432"  # 左边的端口可以更换，右边不要动！
        restart: unless-stopped
        environment:
            - POSTGRES_PASSWORD=Guwei888 # 改成你自己的密码
            - POSTGRES_USER=goodway  # 改成你自己的用户名
            - POSTGRES_DB=joplin
    app:
        image: joplin/server:latest
        depends_on:
            - db
        ports:
            - "22300:22300" # 左边的端口可以更换，右边不要动！
        restart: unless-stopped
        environment:
            - APP_PORT=22300
            - APP_BASE_URL=https://jo.95118.works # 改成反代的域名
            - DB_CLIENT=pg
            - POSTGRES_PASSWORD=Guwei888 # 与上面的密码对应！
            - POSTGRES_DATABASE=joplin
            - POSTGRES_USER=goodway  # 与上面的用户名对应！
            - POSTGRES_PORT=5432 # 与上面右边的对应！
            - POSTGRES_HOST=db
}
EOF
docker-compose up -d 
if [[ $? -eq 0 ]]; then
  green "确定域名已解析成功"
  yellow "npm添加反向代理"
  green "不选任何，填解析好的域名，IP和端口22300"
  ip addr show docker0
  green "参考上面IP，SSL选Force一个，成功后选Force"
  green "默认账号：admin@localhost"
  green "默认密码：admin"
fi
green "https://blog.laoda.de/archives/docker-compose-install-joplin-server"
