## 示意图



![excel](https://s1.ax1x.com/2018/08/13/Pg3EeP.jpg)

## pull源码下来

- 本文档代码的位置都在/opt/projects/excel_project 

## 先pull下Python3.7的镜像

`bash docker_build.sh `



看下shell里面写的什么？

```
cat 

#！ /bin/bash
 docker pull python:3.7           #pull下Python3.7的镜像
 docker build -t python37:excel .    #这里定义镜像名字与Tag，后面compose会用到这个build好的镜像
```

看下build出来的是什么？

```
root@iZ2ze33pmk2jcn4l201z9hZ:/opt# docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
node                        excel               3926be036825        2 hours ago         999 MB
python37                    excel    # 他在这里          ff03fa1dfb67        5 hours ago         1.12 GB
```



## 启动 docker-compose

`docker-compose up -d  # -d代表挂起`，这将会启动所有写在docker-compase.yaml里面的服务



### docker-compose.yaml配置文件解释

```
cat docker-compose.yaml

version: '2'                                
services:
  web:                      
    ports:
      - "3003:3000"                         #端口映射 前面的是服务器端口，后面的是容器端口
    restart: always                         #在容器挂掉之后自动重启
    volumes:
      - /opt/projects/excel_project/excel:/opt/excel     #挂载卷 前者对应服务器目录，后者对应容器目录，以此类推
    working_dir: /opt/excel                 #工作目录
    command:       
        - /bin/bash
        - -c
        - |
          npm install --registry=https://registry.npm.taobao.org  
          npm start    # 这里写进入容器工作目录之后需要进行的命令，注意格式，比如Node环境需要的node install

    image: node:8     # 根据版本需求来引用镜像


  app:
    volumes:
      - /opt/projects/excel_project/excel_to_json:/opt/excel_to_json
    ports:
      - "23333:23333"
    restart: always
    working_dir: /opt/excel_to_json
    image: python37:excel       #这里引用的是前面build好的镜像 
    command:
        - /bin/bash
        - -c
        - |
          sleep 10    #这里的睡十秒是有讲究的，这里写的所有的命令 都是并行运行的，可能这会PG数据库都还没有建立好表关系
          python3 manage.py makemigrations
          python3 manage.py migrate
          python3 manage.py runserver 0:23333
    depends_on:
      - pgdb            #这里的pgdb作为PG库连接Django的HOST，后面会写出测试Django联通PG库的方法
  pgdb:
    image: postgres:9.5
    volumes:
       - /opt/projects/excel_project/db:/var/lib/postgresql/data
    restart: always
    ports:
       - "5432:5432"
    environment:
      POSTGRES_PASSWORD: wenyin100years       #这里是PG库的一些设置
      POSTGRES_USER: wenyin
      POSTGRES_DB: tianfeng
```

### 测试后端连接数据库

```
root@papa:/tmp/excel/src# docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS     NAMES
e7f42bad9297        node:excel          "/bin/bash -c 'npm..."   8 minutes ago       Up 8 minutes        0.0.0.0:3003->3000/tcp     root_web_1
04b37eaa7b7b        python37:excel      "/bin/bash -c 'sle..."   11 minutes ago      Up 8 minutes        0.0.0.0:23333->23333/tcp   root_app_1
2a685c280730        postgres            "docker-entrypoint..."   11 minutes ago      Up 8 minutes        5432/tcp     root_pgdb_1



root@papa:/tmp/excel/src# docker exec -ti root_app_1 /bin/bash   #这里是进入PG库里面的命令

root@04b37eaa7b7b:/tmp/excel_to_json# ping root_pgdb_1       #ping一下？ ok
PING root_pgdb_1 (172.20.0.2) 56(84) bytes of data.
64 bytes from root_pgdb_1.root_default (172.20.0.2): icmp_seq=1 ttl=64 time=0.097 ms
64 bytes from root_pgdb_1.root_default (172.20.0.2): icmp_seq=2 ttl=64 time=0.068 ms
64 bytes from root_pgdb_1.root_default (172.20.0.2): icmp_seq=3 ttl=64 time=0.068 ms
^C
--- root_pgdb_1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.068/0.077/0.097/0.017 ms
```



## 善后

主要容器服务都启动了，接下来就需要改一下需要灵活修改的地方

比如 前端连接 Django的配置文件，Django连接PG数据库的配置



 前面有介绍这个

```
volumes: 
	- /opt/projects/excel_project/excel:/opt/excel     #挂载卷 前者对应服务器目录，后者对应容器目录，以此类推
```



我们直接进入容器对应服务器的目录来修改这些 

`cd /opt/projects/excel_project/excel`



