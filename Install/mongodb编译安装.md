# 下载解压源码包

下载地址 https://www.mongodb.com/download-center#community

```
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.9.tgz
```

```
tar xf mongodb-linux-x86_64-3.4.9.tgz
mkdir -p /opt/mongodb
mkdir -p /opt/mongodb/db    #db存储目录
mkdir -p /opt/mongodb/logs  #日志存储目录
mv mongodb-linux-x86_64-3.4.9/* /opt/mongodb/
```

# 二进制启动文件配置

*方案很多*

*1.直接复制二进制文件到/usr/bin下面然后加权，系统直接调用*

*2.编辑环境变量，我这里采用后者*

```
vim ~/.bashrc

export MONGODB_HOME=/opt/mongodb/bin
export PATH=$MONGODB_HOME:$PATH
export PATH

source ~/.bashrc
```

## 检验

```
[root@zyd ~]#mongo --version
MongoDB shell version v3.4.9
git version: 876ebee8c7dd0e2d992f36a848ff4dc50ee6603e
allocator: tcmalloc
modules: none
build environment:
    distarch: x86_64
    target_arch: x86_64
```



# 给个启动配置文件

```
vim mongodb.conf

dbpath=/opt/mongodb/db
logpath=/opt/mongodb/logs/mongodb.log
port=27017
fork=true               #以守护进程方式运行，默认为false
nohttpinterface=true    #是否禁止http接口，默认为false
bind_ip = 127.0.0.1     #绑定监听的ip
```



# 启动

```
mongod -f mongodb.conf
```

启动之后可以查看一下启动日志

在这里

tail -30 /opt/mongodb/logs/mongodb.log



# End

后续会总结配置文件



