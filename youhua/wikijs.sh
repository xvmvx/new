#!/bin/bash
echo "ubuntu 系统安装，其他未尝试"
echo "正在获取最新更新并自动安装所有更新"
sudo apt -qqy update
sudo DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade
echo "开始安装依赖项安装Docker"
sudo apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install ca-certificates curl gnupg lsb-release
echo "开始安装注册Docker包注册表"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "刷新包更新并安装Docker"
sudo apt -qqy update
sudo apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install docker-ce docker-ce-cli containerd.io docker-compose-plugin
echo "创建Wiki.js安装目录"
mkdir -p /docker/wiki
echo "生成数据库机密"
openssl rand -base64 32 > /etc/wiki/.db-secret
echo "创建内部docker网络"
docker network create wikinet
echo "为PostgreSQL创建数据卷"
docker volume create pgdata
echo "创建容器1.postgres 将使用5432端口 2.wiki 使用18000和18443端口 3.wiki升级 "
docker create --name=db -e POSTGRES_DB=wiki -e POSTGRES_USER=wiki -e POSTGRES_PASSWORD_FILE=/etc/wiki/.db-secret -v /etc/wiki/.db-secret:/etc/wiki/.db-secret:ro -v pgdata:/var/lib/postgresql/data --restart=unless-stopped -h db --network=wikinet postgres:11
docker create --name=wiki -e DB_TYPE=postgres -e DB_HOST=db -e DB_PORT=5432 -e DB_PASS_FILE=/etc/wiki/.db-secret -v /etc/wiki/.db-secret:/etc/wiki/.db-secret:ro -e DB_USER=wiki -e DB_NAME=wiki -e UPGRADE_COMPANION=1 --restart=unless-stopped -h wiki --network=wikinet -p 18000:3000 -p 18443:3443 ghcr.io/requarks/wiki:2
docker create --name=wiki-update-companion -v /var/run/docker.sock:/var/run/docker.sock:ro --restart=unless-stopped -h wiki-update-companion --network=wikinet ghcr.io/requarks/wiki-update-companion:latest
echo "启动容器"
docker start db
docker start wiki
docker start wiki-update-companion
echo "在浏览器上，导航到您的服务器IP/域名（例如http://your-server-ip/）"
echo "自动HTTPS与Let's Encrypt
1.在域注册器上创建一个A记录，将域/子域（例如wiki.example.com）指向服务器公共IP。
2.确保您能够在HTTP上使用该域/子域加载维基（例如http://wiki.example.com）。
3.通过SSH连接到您的服务器。
4.通过运行以下命令停止并删除现有的维基容器（不会丢失数据）："
docker stop wiki
docker rm wiki
echo "通过将wiki.example.com和admin@example.com值替换为您自己的域/子域和维基管理员的电子邮件地址来运行以下命令："
docker create --name=wiki -e LETSENCRYPT_DOMAIN=wiki.example.com -e LETSENCRYPT_EMAIL=admin@example.com -e SSL_ACTIVE=1 -e DB_TYPE=postgres -e DB_HOST=db -e DB_PORT=5432 -e DB_PASS_FILE=/etc/wiki/.db-secret -v /etc/wiki/.db-secret:/etc/wiki/.db-secret:ro -e DB_USER=wiki -e DB_NAME=wiki -e UPGRADE_COMPANION=1 --restart=unless-stopped -h wiki --network=wikinet -p 18000:3000 -p 18443:3443 ghcr.io/requarks/wiki:2
echo "通过运行命令启动容器："
docker logs wiki
docker start wiki
echo "等待容器启动，让我们加密配置过程完成。您可以通过运行以下命令来选择查看容器日志："
docker logs wiki
echo "一旦您在日志中看到以下行，该过程将完成：
(LETSENCRYPT) New certifiate received successfully: [ COMPLETED ]
HTTPS Server on port: [ 3443 ]
HTTPS Server: [ RUNNING ]
使用HTTPS（例如https://wiki.example.com）在网页浏览器中加载您的维基。您的维基现在正在使用免费的Let's Encrypt证书接受HTTPS请求！
自动HTTP到HTTPS重定向
默认情况下，对HTTP端口的请求不会重定向到HTTPS。您可以使用以下说明启用此选项：
通过单击页面右上角的头像导航到管理区域。
从左侧导航菜单中，单击SSL。
在将Redirect HTTP requests to HTTPS部分旁边，单击打开以启用HTTP到HTTPS重定向。
对HTTP端口的任何请求现在都会自动重定向到HTTPS！
您可以随时从管理区域>SSL续订证书。
如果您的证书已过期，并且您无法加载维基UI进行续订，只需重新启动容器即可：
docker restart wiki"
