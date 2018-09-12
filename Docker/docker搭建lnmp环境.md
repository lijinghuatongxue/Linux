# 安装nginx php mysql

## 拉取官方镜像

```
docker pull nginx
docker pull php:5.6-fpm
docker pull  mysql
```



## 使用php镜像运行容器

```
docker run -d -v /var/nginx/www/html:/usr/share/nginx  -p 9000:9000 --link my_mysql:mysql --name my_phpfpm php:5.6-fpm 
```



## 使用mysql镜像运行容器

```
docker run -d -p 3307:3307 -e MYSQL_ROOT_PASSWORD=swl123456  -v /var/lib/mysql:/var/lib/mysql --name my_mysql mysql
```



## 使用nginx镜像运行容器

(这里注意,我的nginx容器要和php容器互联,mysql容器外网连接,其实可以通过内网连接的,我没搞,待下次)

```
docker run -d -p 80:80  --name my_nginx  --link my_phpfpm:my_phpfpm -v   /var/nginx/www/html:/usr/share/nginx  --volumes-from my_phpfpm  nginx
```



## 进入容器中

```
docker exec -ti my_phpfpm /bin/bash
docker exec -ti my_mysql  /bin/bash
docker exec -ti my_nginx  /bin/bash
```



## 进入容器后的必要操作
```
#php
安装vim
apt-get -y update
apt-get -y install vim
然后更改用户用户组(设置为和nginx一样的)
#nginx
安装vim
apt-get -y update
apt-get -y install vim
vim /etc/nginx/nginx.conf 
查看用户是否为nginx,我是设置为nginx,你们随意,但是要注意容器中是否有你改的这个用户
vim /etc/nginx/conf.d/xiaofupai.conf (我知道你们喜欢看详细的,那我就贴出来给你们看,其中其中大部分是默认的,主要是设置了站点目录和用户)

站点目录权限给足
chmod -R 755  目录
chown -R nginx.nginx 目录

#mysql
mysql重要的就是设置root远程登录,开启远程登录,好了,我知道你们都会

reload一下
service nginx reload
php和mysql则需要重启(是我没找到reload的方法)
```



## 补充:

#热更新(进入容器后)

```
service nginx reload
```


#php

```
docker-php-ext-install -help #查看系统自带可安装扩展，并进行追加
```

示范:

```
docker-php-ext-install pdo
```


解释:
-d 让容器在后台运行 
-p 添加主机到容器的端口映射 
-v 添加目录映射，即主机上的/var/nginx/www/html和容器中/var/www/html目录是同步的 
–link 与另外一个容器建立起联系，这样我们就可以在当前容器中去使用另一个容器里的服务。
这里如果不指定–link参数其实也是可以得，因为容易本身也是有ip的且唯一，所以我们也可以直接利用ip去访问容器。

-e 设置环境变量，这里是设置mysql的root用户的初始密码，这个必须设置 
–name 容器的名字，随便取，但是必须唯一
-t 在容器里生产一个伪终端 
-i 对容器内的标准输入 (STDIN) 进行交互


docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=swl123456  -v /var/lib/mysql:/var/lib/mysql --name my_mysql mysql

/usr/share/nginx