## 直接运行docker run

    docker run -d -p 8080:8080 -p 1521:1521 -v /data/db/:/u01/app/oracle sath89/oracle-12c
    
    Docker ps

默认密码账号 system / oracle 或者 sys / oracle

## 进入容器

```
[root@Docker ~]# docker exec -it 3ceb1ae8637e /bin/bash 
root@3ceb1ae8637e:/# 
root@3ceb1ae8637e:/# ss -nlpt
State      Recv-Q Send-Q        Local Address:Port          Peer Address:Port 
LISTEN     0      128                       *:42983                    *:*     
LISTEN     0      128                       *:8080                     *:*     
LISTEN     0      128                       *:1521                     *:*     
```



## 接下来登陆数据库

```
# sqlplus system/oracle@//localhost:1521/xe

SQL*Plus: Release 12.1.0.2.0 Production on Fri May 18 09:27:11 2018

Copyright (c) 1982, 2014, Oracle.  All rights reserved.

Last Successful login time: Fri May 18 2018 09:26:42 +00:00

Connected to:
Oracle Database 12c Standard Edition Release 12.1.0.2.0 - 64bit Production


# 查看sid
SQL> show parameter service_name

NAME                     TYPE    VALUE

------

service_names                string  xe
SQL> 
```



## sid

```
select instance_name from  V$instance;
or
ps -ef |grep oracle
```



##  连接到Oracle企业管理控制台

地址 http://localhost:8080/em
user: sys
password: oracle
connect as sysdba: true

