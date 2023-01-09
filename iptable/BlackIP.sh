#!/bin/bash
#脚本计划任务运行更新

#输出其他系统使用的文件
webfolder=
rosname="BlacklistData"
opname="OpenClash"
#IPSet集使用的名称
IPSetlist="Rblacklist"

time=$(date "+%H:%M:%S")
date=$(date "+%Y-%m-%d")
err=0
count=0
cache="/tmp/blacklist.cache"
iplist="/tmp/BlackCIDR"

#获取IP列表
echo "Get Blacklist:"
#中国科技大学网络威胁中心
count=$(($count+1))
echo -n "blackip.ustc.edu.cn"
curl -s --retry 5 --connect-timeout 3 http://blackip.ustc.edu.cn/list.php?txt |sed -e 's/\r//' -e '/^#.*/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}' >$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#CINS网络威胁中心
count=$(($count+1))
echo -n "cinsarmy.com"
curl -s --retry 5 --connect-timeout 3 https://cinsarmy.com/list/ci-badguys.txt |sed -e 's/\r//' -e '/^#.*/d' -e '/\.0$/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#abuse.ch网络威胁中心
count=$(($count+1))
echo -n "feodotracker.abuse.ch"
curl -s --retry 5 --connect-timeout 3 https://feodotracker.abuse.ch/downloads/ipblocklist_recommended.txt |sed -e 's/\r//' -e '/^#.*/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#abuse.ch虚假SSL证书
count=$(($count+1))
echo -n "sslbl.abuse.ch"
curl -s --retry 5 --connect-timeout 3 https://sslbl.abuse.ch/blacklist/sslipblacklist.txt |sed -e 's/\r//' -e '/^#.*/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#emergingthreats网络威胁中心
count=$(($count+1))
echo -n "rules.emergingthreats.net"
curl -s --retry 5 --connect-timeout 3 https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt |sed -e 's/\r//' -e '/^#.*/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#BlockList网络威胁中心（大数据）
count=$(($count+1))
echo -n "lists.blocklist.de"
curl -s --retry 5 --connect-timeout 3 https://lists.blocklist.de/lists/all.txt |sed -e 's/\r//' -e '/^#.*/d' -e '/\.0$/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#azorult-tracker恶意软件
count=$(($count+1))
echo -n "azorult-tracker.net"
curl -s --retry 5 --connect-timeout 3 https://azorult-tracker.net/api/list/ip?format=plain |sed -e 's/\r//' -e '/^#.*/d' -e '/\.0$/d' |grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' |sed -e 's/$/\/32/g' >>$cache
if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
#输出状态
echo -e 'Date:'$date' Time:'$time'| Succeed:'$count' Failed:'$err

#若所有列表都获取失败则不执行
if [ $err -lt $count ]; then
    #去重
    sort -u $cache > $iplist
    #输出文件 ebfolder变量为空不生成
    if [ "$webfolder" != "" ]; then
        echo "Generate:"
        #Out RouterOS File
        echo -n "Generate RouterOS Import File"
        cat $iplist |sed -e '/\.0\/32$/d' |sed -e 's/^/add address=/g' -e 's/$/ list='$rosname'/g'|sed -e $'1i\\\n/ip firewall address-list' -e $'1i\\\nremove [/ip firewall address-list find list='$rosname']' |sed '$a \/' |sed '$a /file remove '$rosname'.rsc'>$webfolder/$rosname
        if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
        #Out OpenClash File
        echo -n "Generate OpenClash Import File"
        cat $iplist |sed -e '/\.0\/32$/d' |sed -e 's/^/  - /g' |sed -e $'1i\\\npayload:'>$webfolder/$opname
        if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
    fi
    #更新 ipset 数据 (debian)
    if [ -f "/sbin/ipset" ] && [ ! -z "`egrep -i "debian" /etc/issue`" ];then
        echo "Set IPSet:"
        #判断并创建集合
        /sbin/ipset list $IPSetlist >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -n "Establish IPSet list"$IPSetlist
            /sbin/ipset create $IPSetlist hash:net maxelem 4294967295
            if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
        fi
        #清空集合内容
        echo -n "Flush IPSet "$IPSetlist" list"
        /sbin/ipset flush $IPSetlist >/dev/null 2>&1
        if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
        #将数据循环导入集合
        echo -n "Import "$IPSetlist" To IPSet"
        while read ip; do
            ipset add $IPSetlist $ip >/dev/null 2>&1
        done < $iplist
        if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
    fi
else
    #所有列表都读取失败
    echo -e " >> All List Get Failed! "
fi

#防火墙规则导入（由传参控制 $1=iptables ）
#由iptables.sh脚本调用，既开机才调用
if [ "$1" == "iptables" ]; then
    echo -n "Set IPSet iptables rule"
    #读出现防火墙数据判断是否重复添加规则
    IPTABLES=$(iptables-save)
    if ! echo $IPTABLES|grep -q "\-A\ INPUT\ \-m\ set\ \-\-match\-set\ $IPSetlist\ src\ \-\j\ DROP"; then
        #iptables -A INPUT -m set --match-set $IPSetlist src -j ULOG --ulog-prefix "Blocked input $IPSetlist"
        #iptables -A FORWARD -m set --match-set $IPSetlist src -j ULOG --ulog-prefix "Blocked fwd $IPSetlist"
        #iptables -A FORWARD -m set --match-set $IPSetlist dst -j ULOG --ulog-prefix "Blocked fwd $IPSetlist"
        #iptables -A OUTPUT -m set --match-set $IPSetlist dst -j ULOG --ulog-prefix "Blocked out $IPSetlist"
        iptables -I INPUT -m set --match-set $IPSetlist src -j DROP
        iptables -I FORWARD -m set --match-set $IPSetlist src -j DROP
        iptables -I FORWARD -m set --match-set $IPSetlist dst -j REJECT
        iptables -I OUTPUT -m set --match-set $IPSetlist dst -j REJECT
        if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
        #更新防火墙规则时，若Docker已在运行则需要重启Docker（安装了Docker删除下面的“#”）
        #if [ "$(/bin/systemctl is-active docker)" = "active" ];then
        #    echo -n $0": Restart Docker Service"
        #    /bin/systemctl restart docker
        #    if [ $? -ne 0 ]; then echo -e " >> Failed ";err=$(($err+1)); else echo -e " >> Succeed ";fi
        #fi
    else
        echo -e " >> Existence "
    fi
fi
