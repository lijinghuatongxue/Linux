# 前期环境准备

系统：centos7.4 64位

用户：root

# 看效果？

![WechatIMG583](https://s1.ax1x.com/2018/09/20/imL2h6.jpg)

## 进入Python项目自动载入python虚拟环境

```
echo "source /opt/py3/bin/activate" > /opt/project_name/.env  
```

## 字符集支持中文，日志里面打印了中文

```
localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf
```

## 防火墙（临时关闭）

```
systemctl stop firewalld.service
setenforce 0 
```

## Python3安装并载入虚拟环境

```
wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz && tar xvf Python-3.6.1.tar.xz  && cd Python-3.6.1 && ./configure && make && make install

cd /opt && python3 -m venv py3 && source /opt/py3/bin/activate
```

## 必要依赖包安装

```
yum -y install wget sqlite-devel xz gcc automake zlib-devel openssl-devel epel-release git
```

## 自动载入 Python 虚拟环境配置

此项仅为懒癌晚期的人员使用，防止运行 Jumpserver 时忘记载入 Python 虚拟环境导致程序无法运行。使用autoenv

```
cd /opt
git clone https://github.com/kennethreitz/autoenv.git
echo 'source /opt/autoenv/activate.sh' >> ~/.bashrc
source ~/.bashrc
```



# 安装jumpserver

## Clone项目

```
cd /opt/
git clone https://github.com/jumpserver/jumpserver.git && cd jumpserver && git checkout master
echo "source /opt/py3/bin/activate" > /opt/jumpserver/.env  # 进入 jumpserver 目录时将自动载入 python 虚拟环境

```

## 安装依赖 RPM 包

```
cd /opt/jumpserver/requirements
yum -y install $(cat rpm_requirements.txt)  # 如果没有任何报错请继续
```



## 安装 Redis

Jumpserver 使用 Redis 做 cache 和 celery broke

```
yum -y install redis
systemctl enable redis
systemctl start redis

# centos6
$ yum -y install redis
$ chkconfig redis on
$ service redis start
```

## 安装 Python 库依赖

```
pip install -r requirements.txt -i https://pypi.douban.com/simple
```

## 安装数据库

```
# centos7上安装mariadb
yum -y install mariadb mariadb-devel mariadb-server 
systemctl enable mariadb
systemctl start mariadb
```

### 创建数据库 Jumpserver 并授权

```
$ mysql
> create database jumpserver default charset 'utf8';
> grant all on jumpserver.* to 'jumpserver'@'127.0.0.1' identified by 'swl19960706';
> flush privileges;
```

## 修改 Jumpserver 配置文件

```
cd /opt/jumpserver
cp config_example.py config.py
vi config.py

# 注意对齐，不要直接复制本文档的内容，实际内容以文件为准，本文仅供参考
```

## 生成数据库表结构和初始化数据

```
 cd /opt/jumpserver/utils
 bash make_migrations.sh
```

## 运行 Jumpserver

```
cd /opt/jumpserver
./jms start all  # 后台运行使用 -d 参数./jms start all -d

#新版本更新了运行脚本，使用方式./jms start|stop|status|restart all  后台运行请添加 -d 参数
```

运行不报错，请浏览器访问 <http://ip:8080/> 

默认账号: admin 密码: admin 

页面显示不正常先不用处理，继续往下操作，后面搭建 nginx 代理后即可正常访问，原因是因为 django 无法在非 debug 模式下加载静态资源





# 安装 SSH Server 和 WebSocket Server: Coco

继续引用之前的python虚拟环境

## 下载或 Clone 项目

新开一个终端，别忘了 source /opt/py3/bin/activate

```
cd /opt
source /opt/py3/bin/activate
git clone https://github.com/jumpserver/coco.git && cd coco && git checkout master
echo "source /opt/py3/bin/activate" > /opt/coco/.env  # 进入 coco 目录时将自动载入 python 虚拟环境

# 首次进入 coco 文件夹会有提示，按 y 即可
# Are you sure you want to allow this? (y/N) y
```

## 安装依赖

```
cd /opt/coco/requirements
yum -y  install $(cat rpm_requirements.txt)
pip install -r requirements.txt -i https://pypi.python.org/simple
```

## **修改配置文件并运行** 

```
cd /opt/coco
cp conf_example.py conf.py  # 如果 coco 与 jumpserver 分开部署，请手动修改 conf.py
vi conf.py


./cocod start -d  # 后台运行使用 -d 参数./cocod start -d

# 新版本更新了运行脚本，使用方式./cocod start|stop|status|restart  后台运行请添加 -d 参数
# 注意对齐，不要直接复制本文档的内容
```

# 安装 Web Terminal 前端: Luna

Luna 已改为纯前端，需要 Nginx 来运行访问

访问（<https://github.com/jumpserver/luna/releases>）下载对应版本的 release 包，直接解压，不需要编译

## 解压 Luna

```
cd /opt
wget https://github.com/jumpserver/luna/releases/download/1.4.1/luna.tar.gz
tar xvf luna.tar.gz
chown -R root:root luna
```

## 安装运行 Nginx

```
yum -y install nginx

# 我的子配置文件贴上来

server {
    listen 80;  # 代理端口，以后将通过此端口进行访问，不再通过8080端口

    client_max_body_size 100m;  # 录像上传大小限制

    location /luna/ {
        try_files $uri / /index.html;
        alias /opt/luna/;  # luna 路径，如果修改安装目录，此处需要修改
    }

    location /media/ {
        add_header Content-Encoding gzip;
        root /opt/jumpserver/data/;  # 录像位置，如果修改安装目录，此处需要修改
    }

    location /static/ {
        root /opt/jumpserver/data/;  # 静态资源，如果修改安装目录，此处需要修改
    }

    location /socket.io/ {
        proxy_pass       http://localhost:5000/socket.io/;  # 如果coco安装在别的服务器，请填写它的ip
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        access_log off;
    }

    location /guacamole/ {
        proxy_pass       http://localhost:8081/;  # 如果guacamole安装在别的服务器，请填写它的ip
        proxy_buffering off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        access_log off;
    }

    location / {
        proxy_pass http://localhost:8080;  # 如果jumpserver安装在别的服务器，请填写它的ip
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}


nginx -t   # 确保配置没有问题, 有问题请先解决

# CentOS 7
systemctl start nginx
systemctl enable nginx
```

服务启动后，访问的是nginx最新代理的jumpserber的IP+端口

如果部署过程中没有接受应用的注册，需要到Jumpserver 会话管理-终端管理 接受 Coco Guacamole 等应用的注册。

# 测试连接

```
如果登录客户端是 macOS 或 Linux ，登录语法如下
$ ssh -p2222 admin@192.168.244.144
$ sftp -P2222 admin@192.168.244.144
密码: admin

如果登录客户端是 Windows ，Xshell Terminal 登录语法如下
$ ssh admin@192.168.244.144 2222
$ sftp admin@192.168.244.144 2222
密码: admin
如果能登陆代表部署成功

# sftp默认上传的位置在资产的 /tmp 目录下
# windows拖拽上传的位置在资产的 Guacamole RDP上的 G 目录下
```

