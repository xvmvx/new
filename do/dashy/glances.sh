#!/bin/bash
apt install python3 python3-pip -y 
pip3 install bottle 
pip3 install glances 
glances
glances -w
cat > /etc/systemd/system/glances.service << EOF   # 名字就叫 glances.service
[Unit]
Description = Glances in Web Server Mode
After = network.target

[Service]
ExecStart = /usr/local/bin/glances  -w  -t  5

[Install]
WantedBy = multi-user.target
EOF
systemctl enable glances.service  # 开机自动启动glances
systemctl start glances.service  # 启动glances
systemctl status glances.service  # 查看glances状态
systemctl restart glances.service  # 重启glances
