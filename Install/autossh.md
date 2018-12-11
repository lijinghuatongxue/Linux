# 作用

- autossh 是一个用来启动 ssh 并进行监控的程序，可在需要时重启 ssh，如果程序问题或者是网络问题。其灵感和机制来自于 rstunnel (Reliable SSH Tunnel). autossh 1.2 的方法已经改变：autossh 使用 ssh 来构造一个 ssh 重定向循环(本地到远程和远程到本地)，然后发送测试数据并获得返回结果。
- 内网主机主动连接到外网主机，又被称作反向连接(Reverse Connection)，这样NAT路由/防火墙就会在内网主机和外网主机之间建立映射即可相互通信了。但这种映射是路由网关自动维持的，不会持续下去，如果连接断开或者网络不稳定都会导致通信失败，这时内网主机需要自动重连机制了



# 安装

```
apt-get -y install autossh
```



# 环境准备

ssh 免密

# 实例



x.x.x.x 代表公网ip



主机上开启一个本地侦听地址:6767端口,外网访问本地5428端口将转发至localhost:5429,先主后外

```bash
labs@hostname:~$ autossh -M 6767 -CTfnN  -D 5428:localhost:5429 user@x.x.x.x  -p 22
```

## 如

在外网机器访问内网的5428端口，-h后面直接跟localhost就可以

```
labs@pg-slave:~$ psql -h localhost -p 5429  -U labs  -d databasename
psql (9.5.4)
Type "help" for help.

databasename=#
```



## 参数解释

-M为autossh参数， -CqTfnN -D 为ssh参数

-M 6767 : 负责通过6767端口监视连接状态，连接有问题时就会自动重连

-C ：启动数据压缩传输

-q ：安静模式运行，忽略提示和错误

-T ：不占用shell

-f ：后台运行

-n ：配合 -f 参数使用

-N ：不执行远程命令，专为端口转发度身打造

-D 192.168.0.2:7070 ：指定一个本地机器 “动态的“ 应用程序端口转发，如果不加IP地址，默认只监听127.0.0.1



# 优化

authossh实际上是调用ssh，可以再加上 -o TCPKeepAlive=yes -o ServerAliveInterval=30 ，解决频繁断线问题。

```bash
labs@hostname:~$ autossh -M 6767 -CTfnN  -D 5428:localhost:5429 user@x.x.x.x  -p 22  -f AUTOSSH_POLL  86400 -o TCPKeepAlive=yes -o ServerAliveInterval=30
```

