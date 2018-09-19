## 显示docker版本信息
	docker version
## 显示 Docker 系统信息，包括镜像和容器数
	docker info
## 搜索镜像
	docker search <image> # 在docker index中搜索image
## 下载镜像
	docker pull <image>  # 从docker registry server 中下拉image
## 查看镜像 
    docker images： # 列出images
    docker images -a # 列出所有的images（包含历史）
    docker rmi  <image ID>： # 删除一个或多个image
## 查看当前所有正在运行的container
    docker ps 
## 查看最近一次启动的容器
    docker ps -l 
## 列出所有的container（包含历史，即运行过的container）
    docker ps -a 
## 列出最近一次运行的container ID
    docker ps -q 
## 查看容器状态
	docker stats
## 查看容器状态快照
	docker stats --no-stream
## 查看docker实例运行日志，确保正常运行
	docker logs $CONTAINER_ID
## 查看image或container的底层信息
	docker inspect $CONTAINER_ID         #这个可以看到容器的挂载目录以及网络状况，很实用
## 进入到容器
    docker exec  -ti  容器名 /bin/bash             解释>>>>>>          -t 在容器里生产一个伪终端       -i 对容器内的标准输入 (STDIN) 进行交互
    docker exec -ti my_phpfpm /bin/bash
## 使用nsenter(注意看格式,只需要变化容器名字)
	PID=`docker inspect --format "{{ .State.Pid }}" my_nginx`
	nsenter --target $PID --mount --uts --ipc --net --pid
## docker attach是Docker自带的命令
## 通过docker attach进入
	docker attach  容器ID
## 从本地移除一个或多个指定的容器
	docker rm  container ID
## 从本地移除一个或多个指定的镜像
	docker rmi   镜像名
## 导出docker镜像至本地
	docker save  images > /opt/images.tar.gz
## 导入本地镜像到docker镜像库
	docker load < /opt/nginx.tar.gz
## 极端方式停止容器(风险大,不推荐)
### 先列出所有容器ID
```
docker ps -a -q
```


### 批量杀死
```
docker kill $(docker ps -a -q)
```


## 删除正在运行的容器
```
docker rm -f  容器名(ID)   #参数 -f 在很多地方都是强制性质

```

## 容器退出时就能够自动清理容器内部的文件系统
```
docker --rm
```
显然，--rm选项不能与-d同时使用，即只能自动清理foreground容器，不能自动清理detached容器
注意，--rm选项也会清理容器的匿名data volumes。
所以，执行docker run命令带--rm命令选项，等价于在容器退出后，执行docker rm -v。

## docker服务重启时容器自动重启

```
--restart=always
```



​	
​	
​	
​	
​	
​	
​	
​	
