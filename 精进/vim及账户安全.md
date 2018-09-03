
## vim删除光标至行尾的内容

d$

## vim复制和粘贴

yy 复制

p 粘贴至当前行之后
P 粘贴至当前行之前

### vim 替换 （命令模式）

### 将光标当前行中第一个出现的lijinghua替换为admin，没有则不替换

:s/lijinghua/admin/

### 将光标当前行中所有的lijinghua替换为admin

:s/lijinghua/admin/g 

### 将第三行至第五行之间的所有lijinghua替换为bin 

:3,5 s/lijinghua/bin/g

### 将所有行的lijinghua替换为admin

:% s/lijinghua/admin/g 


## vim 保存或退出

保存 :x

另存为 :w b.txt

## vim 忽略大小写

:set ignorecase 



## 账户安全


### 创建账户及组

useradd 

-M 不创建家目录
-s 设置账户的登录shell，默认为bash

-c 设置账号描述信息，一般为账号全称
-d 设置账号家目录，默认为/home/用户名
-e 设置失效日期
-g 设置用户的基本组
-G 设置账户的附加组，多个附加组之间用逗号隔开
-u 指定账户UID 

useradd -s /sbin/nologin -M nginx   ##创建无法登录系统且没有家目录的用户 nginx 

useradd -c test -d  /home/lijinghua -e 2018-11-11 -g root -G bin,mail,adm  lijinghua  
#创建普通账户，名称为lijinghua，描述信息为test，失效日期为2018-11-11，账户的基本组为root，附加组为bin，mail，adm



### 修改账户及组

passwd

-l 锁定账户，仅root可使用此选项
--stdin 从文件或管导读取密码
-u 解锁账户
-d 快速清除账户密码


举个栗子

echo "qwer123" | passwd --stdin lijinghua 


usermod 

-e 修改用户失效日期 

-d 修改用户家目录 

---与useradd参数类似


