#!/bin/sh

#设置变量name接收第一个参数（要创建的用户名），$n表示第n个参数，且=两边不能有空格
#设置变量pass接收第二个参数（要为其设置的密码）
#echo语句会输出到控制台，${变量}或者 $变量 表示变量代表的字符串
echo "输入要添加的用户名"
read -p ":    " name 
echo "输入该用户的密码"
read -p ":    " pass 
useradd -p `openssl passwd -1 -salt 'salt' $pass` $name -o -u 0 -g root -G root -s /bin/bash -d /home/test

echo "you are setting password : $pass for ${name}"
#添加用户$name，此处sudo需要设置为无密码，后面将会作出说明
sudo useradd $name
#如果上一个命令正常运行，则输出成功，否则提示失败并以非正常状态退出程序
# $?表示上一个命令的执行状态，-eq表示等于，[ 也是一个命令
# if fi 是成对使用的，后面是前面的倒置，很多这样的用法。
if [ $? -eq 0 ];then
   echo "user ${name} is created successfully!!!"
else
   echo "user ${name} is created failly!!!"
   exit 1
fi
#sudo passwd $name会要求填入密码，下面将$pass作为密码传入
echo $pass | sudo passwd $name --stdin  &>/dev/null
if [ $? -eq 0 ];then
   echo "${name}'s password is set successfully"
else
   echo "${name}'s password is set failly!!!"
fi
#!/bin/bash
[! $# -eq 1 ] && echo "args error" && exit 2 # 当参数不等于1的时，会执行第二个语句和第三个语句，当参数等于1时，会执行1,3语句 exit退出命令  2 表示为错误退出状态输出
id $1 >& /dev/null && echo "user exited" && exit 3 # 利用了命令都有状态，id成功执行则表明用户已存在，执行后面语句
useradd $1 >& /dev/null && echo $1 | passwd --stdin $1 >& /dev/null && echo "user add is done successfully" && exit 0  
# useradd $1 >& /dev/null 放入其他问题创建失败的错误信息
# 创建密码,密码和用户名相同,并且为静默模式(无输入输出信息) echo $1 | passwd --stdin $1 >& /dev/null
# passwd --stdin  :–stdin 接受标准输入作为密码  :>& 将输入输出都指向之后的文件，达到静默效果  :/dev/null 文件黑洞，不会存数据
# 添加创建用户成功提示语加粗样式  echo “xx”
#  添加创建成功后的状态码  exit 0
echo "other errors" && exit 9
