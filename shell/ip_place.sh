#!/bin/bash
#先使用命令将ip导出
awk '{print $1}'  $2/./* |sort | uniq -c  > ./所有ip.txt
clean
echo "ip已经导出到./所有ip.txt"
sleep 3
for i in `cat ./所有ip.txt` ; do
    curl https://ip.cn/index.php?ip=$i
    sleep 2
    #睡一会，不然会被封ip
done

