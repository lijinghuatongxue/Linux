# Environment

1. java环境，在普通用户下（启动需要普通用户身份）
2. 能上网
3. mysql数据库创建好



# source code download

地址：[https://www.sonarqube.org/downloads/](https://www.sonarqube.org/downloads/)

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/sonar%E2%80%94%E2%80%94download.png)



# Install

## 创建普通用户

```sh
root@mysql:~# useradd sonar
root@mysql:~# passwd sonar
```

必须以普通用户才能启动

## 下载，解压，权限

```sh
root@mysql:~# wget https://binaries.sonarsource.com/CommercialDistribution/sonarqube-enterprise/sonarqube-enterprise-7.4.zip
root@mysql:~# unzip sonarqube-enterprise-7.4.zip -d /home/sonar/
root@mysql:~# chown -R sonar.sonar /home/sonar/sonarqube-7.4/*
```



## 配置文件

```sh
sonarqube-7.4/conf$ vim sonar.properties
```

配置文件在这里

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/sonar-create-db.png)

```sh
sonar.web.javaOpts=-server -Xms256m -Xmx768m -XX:+HeapDumpOnOutOfMemoryError
sonar.jdbc.username=mysqluser    #mysql用户，请提前创建好这些，这里不再赘述
sonar.jdbc.password=mysqlpasswd   #mysql密码
sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar? useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false    #mysql创建的库叫sonar

sonar.web.host=0.0.0.0   #外网可以访问
sonar.web.port=9000      #端口
sonar.web.context=/sonar  #url
```

# Start sonar

以普通用户才能启动

```sh
sonar@mysql:~/sonarqube-7.4$ ./bin/linux-x86-64/sonar.sh start
```

# demo

## login

默认登录账号

user：admin 

passwd：admin

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/sonar_login.png)

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/sonar.png)





