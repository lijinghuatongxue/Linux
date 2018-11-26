# 添加密码认证



```
vim redis.conf
···
requirepass redispasswd
···
```



# 重启redis

不重启不生效



# 客户端使用？

mac客户端推荐使用 rdm

## 没有密码直接登录成功

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/redis_no_passwd.png)



## 有密码登录失败

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/redis_nopasswd_error.png)

## 有密码登录成功

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/redis_passwd_success.png)





# 先登录后验证



```
➜  webmap redis-cli -p 6399 -h  127.0.0.1      #端口我改为6399，先登录
127.0.0.1:6399> auth redispasswd               #再验证
OK
127.0.0.1:6399> config get requirepass         # 查询当前密码
1) "requirepass"
2) "redispasswd"
127.0.0.1:6399>
```

