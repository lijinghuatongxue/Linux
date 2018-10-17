

## 环境

perf 命令安装好 

Flame Graph项目clone下来



## 克隆项目

项目位置 <https://github.com/brendangregg/FlameGraph>

```
git clone <https://github.com/brendangregg/FlameGraph.git
```

 

## 以perf为例，看一下flamegraph的使用方法：

### 第一步

```
perf record -e cpu-clock -g -p $pid   #这里获取的是某个进程
or
perf record -e cpu-clock -g top      #这里获取的是top命令所获得的数据
```

Ctrl+c结束执行后，在当前目录下会生成采样数据perf.data.

### 第二步

用perf script工具对perf.data进行解析

```
perf script -i perf.data &> perf.unfold
```



### 第三步

将perf.unfold中的符号进行折叠：

```
./FlameGraph/stackcollapse-perf.pl perf.unfold &> perf.folded
```



### 第四步

生成svg图：

```
./FlameGraph/flamegraph.pl perf.folded > perf.svg
```



## 效果图



<p align="center">
  <img src="https://s1.ax1x.com/2018/10/17/id6ipn.png" alt="火焰图"/>
</p>