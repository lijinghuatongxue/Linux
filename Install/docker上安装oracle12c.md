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



# 本地图形化连接oracle

我使用的是 Navicat Premium

![](https://s1.ax1x.com/2018/10/16/iayBDS.md.png)



默认密码账号 system / oracle 或者 sys / oracle





##  连接到Oracle企业管理控制台

地址 http://localhost:8080/em
user: sys
password: oracle
connect as sysdba: true







##  1、修改用户的密码

```
-- 查看用户的proifle是哪个，一般是default：
SELECT username,PROFILE FROM dba_users;

-- 查看指定概要文件（如default）的密码有效期设置：
SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';

-- 将密码有效期由默认的180天修改成“无限制”：修改之后不需要重启动数据库，会立即生效。
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

-- 修改用户SYSTEM 密码
alter user SYSTEM identified by "****password****";
```





##     2、解锁用户的方法

```
-- 解锁方法
alter user SYSTEM account unlock;
```

