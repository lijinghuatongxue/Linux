## 环境需求

开启iptables服务


## 脚本内容
'''
#!/bin/bash
STEP=2 #间隔的秒数，不能大于60 ，请仔细看这里定义的作用
Port="80"  
#web 服务器端口默认80
https="443"
#https的话
con="200"
#http连接最高数量
for (( i = 0; i < 60; i=(i+STEP) )); do
        i=$((i++))
        WEBPORT=$Port
        CONNECT=`netstat -ntu | grep :$WEBPORT|wc -l`
        echo $WEBPORT
        echo $CONNECT
        IP=`netstat -ntu | grep :$WEBPORT | awk '{print $5}' | cut -d: -f1 | awk '{++ip[$1]} END {for(i in ip) print ip[i],"\t",i}' | sort -nr |awk '{print $2}'|head -1`
        if [ $CONNECT -gt $con  ];then
        echo 999
        echo `date +%y-%m-%d-%H:%M:%S`  $IP CONNECT=$CONNECT >> /tmp/deny.ip
                for  (( i = 0; i < 60; i=(i+STEP) )); do
                        i=$((i++))
                        /usr/sbin/iptables -L -n |grep DROP |grep $IP
                                if [ $? -eq 0 ];then
                                        break
                                fi
                        /usr/sbin/iptables -I INPUT -p tcp -s $IP  --dport $WEBPORT -i eth0 -j DROP

                done
        fi
        sleep $STEP
done  
for (( i = 0; i < 60; i=(i+STEP) )); do
        i=$((i++))
        WEBPORT2=$https
        CONNECT2=`netstat -ntu | grep :$WEBPORT|wc -l`
        echo $WEBPORT2
        echo $CONNECT2
        IP=`netstat -ntu | grep :$WEBPORT2 | awk '{print $5}' | cut -d: -f1 | awk '{++ip[$1]} END {for(i in ip) print ip[i],"\t",i}' | sort -nr |awk '{print $2}'|head -1`
        if [ $CONNECT2 -gt $con  ];then
        echo 999
        echo `date +%y-%m-%d-%H:%M:%S`  $IP CONNECT=$CONNECT2 >> /tmp/deny.ip
        #作为日志存在该文件里面
                for  (( i = 0; i < 60; i=(i+STEP) )); do
                        i=$((i++))
                        /usr/sbin/iptables -L -n |grep DROP |grep $IP
                                if [ $? -eq 0 ];then
                                        break
                                fi
                        /usr/sbin/iptables -I INPUT -p tcp -s $IP  --dport $WEBPORT2 -i eth0 -j DROP

                done
        fi
        sleep $STEP
done

  
exit 0 


'''

## 定时任务 

crontab -e
#必须是一分钟执行一次该脚本
*/1 * * * * sh /server/scripts/safe.sh > /dev/null 2>&1 &
#多久清空iptables，自己定时间
*/10 * * * *   /usr/sbin/iptables -F > /dev/null 2>&1 &



