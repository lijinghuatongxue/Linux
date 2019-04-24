## 有规律的折线图

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/zabbix/action/zabbix-cron.png)



会发现在折线图上有一个很规律的毛刺，应该是定时任务或者是突发性运算任务，大多是凌晨的备份，网络流量显示为outgoing

此法也可以间接检测备份功能有没有生效，但绝不能作为检测备份功能的依据，还是要以实体备份为准。

### 对比的cpu

高带宽往往伴随着磁盘高IO，也意味着CPU要开始工作了

可以看到，大多数是和上图的流量图重合的

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/zabbix/action/zabbix-outgoing-cpu.png)





## 突然的毛刺

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/zabbix/action/zabbix_outgoing_1.png)



该如何分析这个呢，gitlab主要的服务是代码仓库，在下午2.34左右，流量开始流出，内网带宽达到4.0M，持续时间为2分钟，应该是某个同学在pull代码(大概率是)

如果有人长时间的push或者pull代码，误将大量的数据文件或者包依赖上传，其他的同学使用gitlab可能会卡顿。



## 分析属于什么类型的应用



如果蓝色的较多，代表服务在正常使用cpu，瓶颈在处理器这里，这个正常，可能是CPU密集型服务

红色较多，时间消耗在硬件上，消耗在硬盘，内存等上，主要服务可能是IO密集型服务

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/zabbix/action/zabbix_io_iowait.png)

