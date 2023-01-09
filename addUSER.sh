#!/bin/sh
echo "输入要添加的用户名"
read -p ":    " name 
echo "输入该用户的密码"
read -p ":    " pass 
useradd -p `openssl passwd -1 -salt 'salt' $pass` $name -o -u 0 -g root -G root -s /bin/bash -d /home/test
if [ $? = '0' ]; then
   green "增加root用户。。。完成✅✅✅！"
else
   red "添加用户未成功！"
   red "手动添加请使用  adduser 添加的用户名"
   yellow " 修改 /etc/sudoers 文件，在root ALL=(ALL) ALL下面添加一行，如下所示："
   red "用户名 ALL=(ALL) ALL "
   yellow " 然后修改用户，使其属于root组（wheel），命令如下："
   red "usermod -g root 用户名"
fi
