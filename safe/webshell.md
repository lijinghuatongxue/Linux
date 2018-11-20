# 问题

1.

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/webshell_warn.jpeg)



2. cpu负载暴涨
3. 网站访问速度变慢



作案总在入睡时

# 原因

## webshell是什么

WebShell 是一个asp或php木马后门，黑客在入侵了一个网站后，常常在将这些 asp或php木马后门文件放置在网站服务器的web目录中，与正常的网页文件混在一起。

然后，黑客就可以用web的方式，通过asp或php木马后门控制网站服务器，包括上传下载文件、查看数据库、执行任意程序命令等



## webshell的优点是什么

webshell 最大的优点就是可以穿越防火墙，由于与被控制的服务器或远程主机交换的数据都是通过80端口传递的，因此不会被防火墙拦截。

并且使用webshell一般不会在系统日志中留下记录，只会在网站的web日志中留下一些数据提交记录，没有经验的管理员是很难看出入侵痕迹的



# 着手杀木马

## 降权

```
chmod -R 755 /www/webdir     #年轻的时候图快，直接给的777，该来的总会来
```



## find查找最近更新的文件

```
find .  -type f -name "*.php" -mtime -1  #查找最近一天更改的 php结尾的文件
```



## 借助工具

### webshell在线查杀

支持打包web目录

[http://n.shellpub.com/](http://n.shellpub.com/)



```
zip -r webshell.zip /www/webdir/*      #把打包的要检测是否有木马的web目录压缩包放到网站上去检测
```



### 检测结果？

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/WechatIMG6.jpeg)

### 清除木马文件

```
rm -rf /wecenter-master/system/Services/VideoUrlParser.php /wecenter-master/system/Zend/Db/Adapter/Pdo/Abstract.php /wecenter-master/system/Zend/Db/Adapter/Pdo/Mssql.php /wecenter-master/system/Zend/Db/Adapter/Pdo/Pgsql.php /wecenter-master/system/Zend/Db/Adapter/Pdo/Sqlite.php
```



# 再看下负载？

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/WX20181120-110959%402x.png)

已经开始降了

观察一会



# 总结

千万不要给web目录777权限