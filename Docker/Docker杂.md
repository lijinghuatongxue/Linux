## docker 编码问题

```
docker run -i -t ubuntu env LANG=C.UTF-8 /bin/bash

# 编写 Dockerfile加上 http://ju.outofmemory.cn/entry/133027
ENV LANG=C.UTF-8
```

## 需要修改iptables主机上的规则以允许来自Docker容器的连接。像这样的事情会做的伎俩：

iptables -A INPUT -i docker0 -j ACCEPT

## 导出一个容器出来
docker export 7691a814370e > ubuntu.tar


### 导入一个容器
cat ubuntu.tar | sudo docker import - test/ubuntu:v1.0   /bin/bash

也可以通过指定 URL 或者某个目录来导入，例如
```
 docker import http://example.com/exampleimage.tgz example/imagerepo
 ```
注：用户既可以使用 docker load 来导入镜像存储文件到本地镜像库，也可以使用 docker import 来导入一个容器快照到本地镜像库。
这两者的区别在于容器快照文件将丢弃所有的历史记录和元数据信息（即仅保存容器当时的快照状态），而镜像存储文件将保存完整记录，体积也要大。此外，从容器快照文件导入时可以重新指定标签等元数据信息。

## 命令行往容器里面传送指令
 docker exec -it Container_name /bin/bash -c "source /etc/profile && java -jar neeq-es-0.0.1-SNAPSHOT.jar"

## docker  容器使用root权限

进入容器参数加上 --user root 

比如 
```
docker exec -ti --user root  new_es  /bin/bash
```