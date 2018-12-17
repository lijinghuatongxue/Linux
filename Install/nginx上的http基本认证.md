# Install htpasswd 

## ubuntu

```
apt-get install apache2-utils -y
```

## centos

```
yum -y install httpd-tools -y
```



# Create an authenticated user

pass_file 是存储认证的文件  username1 用户名

```
root@neeq3:/etc/nginx/sites-enabled# htpasswd -c -d /etc/nginx/pass_file  username1
New password:
Re-type new password:
Warning: Password truncated to 8 characters by CRYPT algorithm.
Adding password for user username1
```



# nginx setting

我是放在引申的子配置文件里面

```
···
auth_basic   "Welcome Memect Gitlab";
auth_basic_user_file /etc/nginx/pass_file;     #这里放的是认证文件位置
···
```

# Reload configuration files 

```
/etc/init.d/nginx reload
```



# Demo

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/nginx_%E8%AE%A4%E8%AF%81.png)

# Other

 浏览器中使用 直接在浏览器中输入地址, 会弹出用户密码输入框, 输入即可访问 

## wget 获取数据

```
wget wget --http-user=username1 --http-passwd=123456 http://xxxx.com/xxx.zip  
```

## curl 获取数据

```
curl -u username1:123456 -O http://xxxxx.com/xxx.zip
```

