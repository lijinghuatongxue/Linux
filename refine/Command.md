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

# virt-what

识别机器是怎么虚拟化的

```
root@paa1:~# virt-what
vmware
```

