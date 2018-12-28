

# 要知道的

进程优先级值的范围是-20 到 19，总共40个

- Linux 和 UNIX系统使用有 40 个优先级的优先级系统，范围从 -20（最高优先级）到 19（最低优先级）。
- 常规用户启动的进程优先级一般是 0。
- `ps` 命令可以使用 `-l` 选项显示优先级（例如，nice 或 NI、level）。
- `nice` 命令显示我们的默认优先级。

# 查看当前默认优先级

```bash
root@paa3:~# nice
0
```

效果图

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/other/nice_top.png)

# nice

nice命令用于指定**新创建**的进程调度优先级

## 范例

```bash
root@paa3:~# cat test.sh
#! /bin/bash
for i in {1..10000};do
	echo 233
	sleep 1
done
```

```bash
root@paa3:~# bash test.sh
```

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/other/nice_bash.png)



# renice

更改**已有进程**的优先级

先找到已有进程

```bash
root@paa3:~# ps -ef |grep test.sh
root     17551 16051  0 13:34 pts/0    00:00:00 bash test.sh
```

更改

```bash
root@paa3:~# renice +10 17551
17551 (process ID) old priority -19, new priority 10  #老得优先权是19，新的是10 （-19+10=10）
```



![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/other/renice_bash.png)