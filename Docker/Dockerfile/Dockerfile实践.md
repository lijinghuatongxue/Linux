# 创建一个Dockerfile文件

创建一个有意义的目录

```
mkdir -p  /dockerfile/nginx
cd /dockerfile/nginx 
```



# create Dockerfile  file 

(注意首字母大写)

```
touch Dockerfile
```



# 编辑 Dockerfile

```
vim Dockerfile
#来源 ubuntu系统(我用的是ubuntu)
FROM ubuntu
#维护者信息
MAINTAINER lijinghua woshilijinghua@gmail.com
#先更新源
RUN apt-get update
#下载nginx
RUN apt-get install -y nginx 
#下载vim(日后好编辑)
RUN apt-get install -y  vim
#添加本地文件(当然,已经提前写好的,这是我站点子配置文件)
ADD xiaofupai.conf /etc/nginx/sites-enabled/xiaofupai.conf
ADD toupiao.conf  /etc/nginx/sites-enabled/toupiao.conf
#卷的挂载
VOLUME /www 
#给个端口
EXPOSE 80
#
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#
CMD ["nginx"]
```



## 重头戏来了
```
docker build -t mynginx:v2 .
```



mynginx 代表build完之后的镜像名字

V2 版本号


