#!/bin/bash
mkdir dashy
cd dashy
mkdir icons
cd icons
git clone https://github.com/walkxcode/dashboard-icons.git  # 下载icons，新版的好像系统自带，咕咕没有尝试，就先用这个了。
cd ..
mkdir public
cd public
cat > conf.yml << EOF
# Page meta info, like heading, footer text and nav links
pageInfo:
  title: Dashy
  description: Welcome to your new dashboard!
  navLinks:
  - title: GitHub
    path: https://github.com/Lissy93/dashy
  - title: Documentation
    path: https://dashy.to/docs

# Optional app settings and configuration
appConfig:
  theme: colorful
  layout: auto
  iconSize: medium
  language: en
  auth:
    users:
      - user: goodway    # 改成自己的用户名
        hash: 0aa5e346d008d2ca8673dbdff13c10b49574503bf2a72da79f1e824a48333b95  # cha256 哈希加密，地址用这个： https://emn178.github.io/online-tools/sha256.html
        type: admin
# Main content - An array of sections, each containing an array of items
sections:
- name: Getting Started
  icon: fas fa-rocket
  items:
  - title: Dashy Live
    description: Development a project management links for Dashy
    icon: https://i.ibb.co/qWWpD0v/astro-dab-128.png
    url: https://live.dashy.to/
    target: newtab
  - title: GitHub
    description: Source Code, Issues and Pull Requests
    url: https://github.com/lissy93/dashy
    icon: favicon
  - title: Docs
    description: Configuring & Usage Documentation
    provider: Dashy.to
    icon: far fa-book
    url: https://dashy.to/docs
  - title: Showcase
    description: See how others are using Dashy
    url: https://github.com/Lissy93/dashy/blob/master/docs/showcase.md
    icon: far fa-grin-hearts
  - title: Config Guide
    description: See full list of configuration options
    url: https://github.com/Lissy93/dashy/blob/master/docs/configuring.md
    icon: fas fa-wrench
  - title: Support
    description: Get help with Dashy, raise a bug, or get in contact
    url: https://github.com/Lissy93/dashy/blob/master/.github/SUPPORT.md
    icon: far fa-hands-helping
EOF
cd ..
cat > docker-compose.yml << EOF
version: '3.3'
services:
    dashy:
        ports:
            - '8395:80'
        volumes:
            - '/docker/dashy/public/conf.yml:/app/public/conf.yml'
            - '/docker/dashy/icons:/app/public/item-icons/icons'
        container_name: dashy
        restart: unless-stopped
        image: 'lissy93/dashy:latest'
EOF
lsof -i:83
docker-compose up -d
echo "端口83，不正确时检查conf.yml是否在public文件夹内"
