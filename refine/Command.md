# cp

-v 显示复制进度

# ipcs

**ipcs命令**用于报告Linux中进程间通信设施的状态，显示的信息包括消息列表、共享内存和信号量的信息

```
-a：显示全部可显示的信息；
-q：显示活动的消息队列信息；
-m：显示活动的共享内存信息；
-s：显示活动的信号量信息。
```

# ps

## 找出僵尸进程

```
ps -A -o stat,ppid,pid,cmd | grep -e '^[Zz]'
```

# cpio

主要是用来建立或者还原备份档的工具程序，cpio命令可以复制文件到归档包中，或者从归档包中复制文件。



waiting..











# type

**type命令**用来显示指定命令的类型，判断给出的指令是内部指令还是外部指令

## 参数

```
-t：输出“file”、“alias”或者“builtin”，分别表示给定的指令为“外部指令”、“命令别名”或者“内部指令”；
-p：如果给出的指令为外部指令，则显示其绝对路径；
-a：在环境变量“PATH”指定的路径中，显示给定指令的信息，包括命令别名。
```

## 对比which

```
root@host:~# which cd          #内建指令则不输出
root@host:~# type -t cd        #内部指令
builtin
root@host:~# type -a cd        #没有别名则只显示是内部指令还是外部指令
cd is a shell builtin
root@host:~# type -a cp 
cp is /bin/cp
root@host:~# type cp        
cp is /bin/cp
root@host:~# type -t cp          #外部指令
file

root@host:~# type -a ls         #显示出ls的别名
ls is aliased to `ls --color=auto'
ls is /bin/ls
```

# wget

**wget命令**用来从指定的URL下载文件。wget非常稳定，它在带宽很窄的情况下和不稳定网络中有很强的适应性，如果是由于网络的原因下载失败，wget会不断的尝试，直到整个文件下载完毕。如果是服务器打断下载过程，它会再次联到服务器上从停止的地方继续下载。这对从那些限定了链接时间的服务器上下载大文件非常有用

### 继续执行上次终端的任务，断点续传

```
wget -c url
```

### 将下载下来的文件以不同的文件名字保存

```
wget -o  file url
```

### 限制速度

```
wget --limit-rate=300k url
```

### 后台下载，后台

```
wget -o  url
```

### 失败后增加尝试次数

```
wget --tries=40 url
```

### 测试下载链接是否有效

```
wget --spider url
```

### 下载指定格式文件

```
wget -r -A.pdf url
```

### 下载/镜像/克隆整个网站到本地

```
wget --mirror -p --convert-links -P . URL
```

### 把下载信息存入日志

```
wget -o download.log URL
```

### FTP下载

```
wget ftp-url
wget --ftp-user=USERNAME --ftp-password=PASSWORD url
```



# lspic







# printenv 

打印出当前的环境变量



```
postgres@pa4:~$ printenv
XDG_SESSION_ID=10976
TERM=xterm-256color
SHELL=/bin/bash
HISTSIZE=3000
SSH_CLIENT=221.219.137.90 53936 22
OLDPWD=/root
SSH_TTY=/dev/pts/3
ZSH=/root/.oh-my-zsh
USER=postgres
LSCOLORS=Gxfxcxdxbxegedabagacad
MAIL=/var/mail/postgres
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/var/lib/postgresql/.local/bin:/var/lib/postgresql/bin:/usr/local/postgresql/bin:/var/lib/postgresql/.local/bin:/var/lib/postgresql/bin:/usr/local/postgresql/bin
PWD=/var/lib/postgresql
LANG=en_US.utf8
PGHOME=/usr/local/postgresql
SHLVL=2
HOME=/var/lib/postgresql
LESS=-R
LOGNAME=postgres
SSH_CONNECTION=221.219.137.90 53936 172.30.0.3 22
LC_CTYPE=en_US.UTF-8
PGDATA=/home/data/postgresql
PROMPT_COMMAND=history -a;
XDG_RUNTIME_DIR=/run/user/0
HISTTIMEFORMAT=%F %T
_=/usr/bin/printenv
```



```
postgres@pa4:~$ printenv  LANG
en_US.utf8
```



# fuser

fuser命令是用来显示所有正在使用着指定的file, file system 或者 sockets的进程信息。

```
-c	包含 File 的文件系统中关于任何打开的文件的报告。
-C	有关文件系统中安装在由 File 参数所指定的目录中的打开文件的报告。如果 File 参数不是安装点，那么该命令将报告错误。
-d	包含 File 的文件系统中关于任何打开的已取消链接（已删除）文件的报告。当与 -V 标志一起使用时，它也会报告被删除文件的节点号和大小。
-f	仅对 File 的打开实例报告。
-K SignalNumber | SignalName	将指定信号发送到每个本地进程。只有 root 用户才能终止另一个用户的进程。可以将信号指定为 SignalName，例如，对 SIGKILL 信号或 SignalNumber（例如，9）指定 KILL。SignalName 的有效值是由 kill -l 命令所显示的那些值。
-k	将 SIGKILL 信号发送到每个本地进程。只有 root 用户才能终止另一个用户的进程。
-u	为进程号后圆括号中的本地进程提供登录名。
-V	提供详细输出。
-x	与 -c 或 -f 连用，报告除标准 fuser 输出以外的可执行的和可装入对象。

```



fuser -k 或 -K 可能无法检测和杀死程序开始运行后立即创建的新进程。

##  查看当前占用800端口的用户及程序

```
➜  ~ fuser -v -n tcp 800
Cannot stat file /proc/24084/fd/4: Stale file handle
Cannot stat file /proc/24274/fd/4: Stale file handle
                     USER        PID ACCESS COMMAND
800/tcp:             root       1283 F.... nginx
                     www        1284 F.... nginx
```

# lsof

## -i 端口

```
➜  lsof -i :800
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
nginx   1283 root    7u  IPv4  15339      0t0  TCP *:800 (LISTEN)
nginx   1284  www    7u  IPv4  15339      0t0  TCP *:800 (LISTEN)
```

## -u 用户

```
➜  ~ lsof -u mysql |head -3
COMMAND   PID  USER   FD   TYPE             DEVICE SIZE/OFF   NODE NAME
mysqld  16328 mysql  cwd    DIR              253,1     4096 573773 /usr/local/mysql/var
mysqld  16328 mysql  rtd    DIR              253,1     4096      2 /
```

## -p pid

```
➜  ~ lsof -p 16328 |head -2
COMMAND   PID  USER   FD   TYPE             DEVICE SIZE/OFF   NODE NAME
mysqld  16328 mysql  cwd    DIR              253,1     4096 573773 /usr/local/mysql/var
```

## lsof 文件路径

```
➜  ~ lsof /usr/local/*    #列出该目录下所有的子目录中被打开的文件
COMMAND     PID USER   FD   TYPE             DEVICE SIZE/OFF   NODE NAME
YDService  1146 root    5u  unix 0xffff88003aa88000      0t0 238456 /usr/local/yd.socket.server type=STREAM
YDService  1146 root   14u  unix 0xffff88003761d400      0t0 238464 /usr/local/yd.socket.server type=STREAM
redis-ser  6048 root  cwd    DIR              253,1     4096  25660 /usr/local/redis
mysqld_sa 15829 root  cwd    DIR              253,1     4096 272364 /usr/local/mysql
zsh       22834 root  cwd    DIR              253,1     4096  25660 /usr/local/redis
```

## -c 程序名

```
➜  ~ lsof -c mysql |head -5  #进程名可以只输入开头字母，会自动列出以此开头的所有进程
COMMAND     PID  USER   FD   TYPE             DEVICE SIZE/OFF   NODE NAME
mysqld_sa 15829  root  cwd    DIR              253,1     4096 272364 /usr/local/mysql
mysqld_sa 15829  root  rtd    DIR              253,1     4096      2 /
mysqld_sa 15829  root  txt    REG              253,1   154072  65556 /bin/dash
mysqld_sa 15829  root  mem    REG              253,1  1868984 412328 /lib/x86_64-linux-gnu/libc-2.23.so
```

## -u 用户 -c 进程

```
➜  ~ lsof -a -u mysql -c mysql |head  -5
COMMAND   PID  USER   FD   TYPE             DEVICE SIZE/OFF   NODE NAME
mysqld  16328 mysql  cwd    DIR              253,1     4096 573773 /usr/local/mysql/var
mysqld  16328 mysql  rtd    DIR              253,1     4096      2 /
mysqld  16328 mysql  txt    REG              253,1 51142448 280892 /usr/local/mysql/bin/mysqld
mysqld  16328 mysql  DEL    REG               0,13          210919 /[aio]
```

## 关于网络

### -i TCP 列出所有TCP的连接

```
➜  ~ lsof   -i   TCP
COMMAND     PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
YDService  1146  root    4u  IPv4  238428      0t0  TCP 172.27.0.16:57708->169.254.0.55:5574 (ESTABLISHED)
redis-ser  6048  root    6u  IPv4 2026557      0t0  TCP localhost.localdomain:6399 (LISTEN)
mysqld    16328 mysql   11u  IPv4  211012      0t0  TCP *:mysql (LISTEN)
sshd      17704  root    3u  IPv4 1824577      0t0  TCP 172.27.0.16:ssh->114.245.248.187:58014 (ESTABLISHED)
sshd      31054  root    3u  IPv4  629630      0t0  TCP *:ssh (LISTEN)
```

### -i   :ssh 列出所有使用ssh的网络连接

```
➜  ~ lsof   -i   :ssh  #列出所有使用ssh的网络连接
COMMAND   PID USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
sshd    17704 root    3u  IPv4 1824577      0t0  TCP 172.27.0.16:ssh->114.245.248.187:58014 (ESTABLISHED)
sshd    31054 root    3u  IPv4  629630      0t0  TCP *:ssh (LISTEN)
```

### -i   TCP:80 列出所有在TCP80端口的连接

```
➜  ~ lsof   -i   TCP:3306
COMMAND   PID  USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
mysqld  16328 mysql   11u  IPv4 211012      0t0  TCP *:mysql (LISTEN)
```

### -a   -u   用户名   -i  列出某个用户使用的所有网络连接

```
➜  ~ lsof   -a   -u  root  -i
COMMAND     PID USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
dhclient    922 root    6u  IPv4   12983      0t0  UDP *:bootpc
YDService  1146 root    4u  IPv4  238428      0t0  TCP 172.27.0.16:57708->169.254.0.55:5574 (ESTABLISHED)
redis-ser  6048 root    6u  IPv4 2026557      0t0  TCP localhost.localdomain:6399 (LISTEN)
sshd      17704 root    3u  IPv4 1824577      0t0  TCP 172.27.0.16:ssh->114.245.248.187:58014 (ESTABLISHED)
sshd      31054 root    3u  IPv4  629630      0t0  TCP *:ssh (LISTEN)
```

### -i   @192.168.1.1   #列出远程主机打开的文件

```
➜  ~ lsof   -i   @172.27.0.16
COMMAND     PID USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
YDService  1146 root    4u  IPv4  238428      0t0  TCP 172.27.0.16:57708->169.254.0.55:5574 (ESTABLISHED)
ntpd       1240  ntp   19u  IPv4   16171      0t0  UDP 172.27.0.16:ntp
sshd      17704 root    3u  IPv4 1824577      0t0  TCP 172.27.0.16:ssh->114.245.248.187:58014 (ESTABLISHED)
```

### -g 进程组

```
➜  ~ lsof -g 31577 |head -5
COMMAND   PID  PGID USER   FD      TYPE             DEVICE SIZE/OFF   NODE NAME
nginx   31577 31577 root  cwd       DIR              253,1     4096 417793 /opt
nginx   31577 31577 root  rtd       DIR              253,1     4096      2 /
nginx   31577 31577 root  txt       REG              253,1 10725336 444745 /usr/local/nginx/sbin/nginx
nginx   31577 31577 root  mem       REG              253,1    47600 412341 /lib/x86_64-linux-gnu/libnss_files-2.23.so
```

