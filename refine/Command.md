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

