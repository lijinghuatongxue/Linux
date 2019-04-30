# 字符问题

check LANG and LC_* environment variables



解决：

```
postgres@pa4:~$ LC_ALL="en_US.UTF-8"
postgres@pa4:~$ LC_CTYPE="en_US.UTF-8"
```



# apt安装error code (1)

E: Sub-process /usr/bin/dpkg returned an error code (1)

```
mv /var/lib/dpkg/info /var/lib/dpkg/info.bak #现将info文件夹更名
mkdir /var/lib/dpkg/info    #再新建一个新的info文件夹
apt-get update -y
```

# Mysql 内存不足

报错日志

```
171112 8:13:06 InnoDB: Fatal error: cannot allocate memory for the buffer pool
```

描述：mysql在一次重启之后，怎么都起不来

解决：先停掉app层的业务，再重启数据库

或者增加内存|swap

# mysql 恢复模式

错误日志如下

```
InnoDB: Page [page id: space=0, page number=7] log sequence number 40549246340 is in the future! Current system log sequence number 39314497566
```

添加在/etc/my.cnf 下面

恢复模式，永远都是read-only

```
innodb_force_recovery=6
```

第一：添加此行到/etc/my.cnf文件中： 
 [mysqld] 
 innodb_force_recovery = 4 
第二：重启MySQL。你的数据库现在将启动，但是在innodb_force_recovery参数作用下，所有的插入与更新操作将被忽略。 
第三：导出所有的表(Dump all tables) 
第四：关闭数据库，删除所有的数据文件。运行mysql_install_db 创建默认MySQL表。 
第五：从/etc/my.cnf文件中去掉innodb_force_recovery参数，重启数据库。(库现在应该能正常启动) 

