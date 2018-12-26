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

