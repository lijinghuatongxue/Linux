

# 下载安装

## 下载地址
[链接]: https://www.postgresql.org/ftp/source/


## 获取源码包
```
 wget https://ftp.postgresql.org/pub/source/v9.6.4/postgresql-9.6.4.tar.gz
```

## 解压
```
 tar xf postgresql-9.6.4.tar.gz 
```

## 安装需要的依赖

readline 

zlib 

make 

gcc

```
apt-get install libreadline6 libreadline6-dev make gcc  zlib1g.dev zlib1g -y
```



## 编译

```
 cd postgresql-9.6.4/
 ./configure --prefix=/usr/local/postgresql
 make && make install
```

出现这个为ok

PostgreSQL installation complete

## 添加postgres用户

```
adduser postgres
```



##  环境变量的配置

```
su postgres
```

vim .bashrc  

```
#export PS1='[\u@\h \W]\$'
PGHOME=/usr/local/postgresql
export PGHOME
PGDATA=/home/data/postgresql   #这里的数据存储目录，在这里配置的话，后续初始化则不需要多谢，默认不写使用默认配置
export PGDATA

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$PGHOME/bin

export PATH 
```

### 立即生效

```
source .bashrc
```

## 数据目录及日志文件配置

```
mkdir /home/data/postgresql -p
chown -R postgres:postgres /home/data/postgresql
```



## 二进制文件拷贝

```
cp /usr/local/postgresql/bin/* /usr/bin/

chmod +x /usr/bin/pg*

chmod +x /usr/bin/ps*
```

## 数据库初始化

```
/usr/local/postgresql/bin/initdb  
```

```
[postgres@pa2 postgresql]$initdb
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

fixing permissions on existing directory /home/data/postgresql ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 32MB
creating configuration files ... ok
creating template1 database in /home/data/postgresql/base/1 ... ok
initializing pg_authid ... ok
initializing dependencies ... ok
creating system views ... ok
loading system objects' descriptions ... ok
creating collations ... ok
creating conversions ... ok
creating dictionaries ... ok
setting privileges on built-in objects ... ok
creating information schema ... ok
loading PL/pgSQL server-side language ... ok
vacuuming database template1 ... ok
copying template1 to template0 ... ok
copying template1 to postgres ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:
```



## 开启

在postgres用户操作

```
pg_ctl -D /home/data/postgresql   start
```

## 关闭 

在postgres用户操作

```
pg_ctl -D /home/data/postgresql -m fast    stop
```

“-m fast”选项立即断开会话而不是
等待会话发起的断开


## 重启

```
在postgres用户操作
pg_ctl restart -m fast
```

## 检查下端口
```
[root@pa2 ~]# netstat -lntup 
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/systemd           
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      3951/java           
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      22565/nginx: master 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1800/sshd           
tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      10157/postmaster     #在这里
```





# 使用

## 修改密码步骤

默认密码是随机的，我们进入数据库里面直接再改一个

```
su postgres                              #切换postgres用户
psql                                     #进入数据库
ALTER USER postgres WITH PASSWORD '密码';   #修改用户postgres的密码，必须以分号结束
```



## 配置文件在哪儿？


配置文件都在数据储存的目录里面，就是我的 /home/data/postgresql

包括postgresql.conf和pg_hba.conf

然后配置下远程连接及postgres用户权限等等



## 关于连接配置

```
vim pg_hba.conf

···
"local" is for Unix domain socket connections only  # 翻译：“本地”仅适用于Unix域套接字连接
local     all     postgres                                      trust
···

重启
```

这里的trust 和 md5 将会决定你切换到postgres用户之后能不能psql 直接进入到pg数据库
### 远程（http）访问配置

要想远程访问，需要修改两处配置，需要重启postgresql

```
1.
vim postgresql.conf  # 该文件作用和 mysql数据库里面的 /etc/my.cnf类似

listen_addresses = '*'

2.
vim pg_hba.conf

host  all  all 0.0.0.0/0 md5          #代表任何一个ip都能连接

#注意：这个配置是我测试用的，线上生产用请谨慎配置

重启
```



##  信任指定服务器连接

pg_hba.conf ip段配置示范

```
# IPv4 local connections:

host    all            all      127.0.0.1/32      md5
host    all            all      10.211.55.6/32（需要连接的服务器IP）  md5
重启
```





