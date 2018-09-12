## --link参数依旧可以用


## 环境

docker启动一个db容器，数据目录 -v 挂载到主机上，可以备份数据到这个目录，这个目录和主机指定目录相通，未雨绸缪，以防万一。



## 使用方法

```
docker run -itd -p 8000:4555 --link pg:pgdb  -v /root/quip_org_project:/opt/ --name py  image_id    #启动一个后端服务，他需要与db通信


```



### 检测

必要的时候需要检测一下后端环境与db的连接是否畅通

pgdb在这里充当的是host的角色，其他的参数比如端口，密码什么的还需要你自己设置啊

#### 上代码

```
root@iZ2ze2xim85w29dthlhc5mZ:~# docker exec -ti 80974358ea31 /bin/bash
root@80974358ea31:/# ping pgdb         #这里pgdb充当的是host
PING pgdb (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: icmp_seq=0 ttl=64 time=0.102 ms
64 bytes from 172.18.0.2: icmp_seq=1 ttl=64 time=0.085 ms
64 bytes from 172.18.0.2: icmp_seq=2 ttl=64 time=0.089 ms
^C--- pgdb ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.085/0.092/0.102/0.000 ms
```



### 解释

pg 代表已经启动的一个数据库容器名字

pgdb 是我们起的一个别名，但是这个别名只对我们将要启动的这个容器有效

