# 简介

EFK就是elasticsearch+filebeat+kibana

其中elasticsearch是核心，负责数据的存储，分析，检索，分词处理

filebeat负责数据采集，轻量级的logstash。如果用logstash，就叫ELK

kibana负责数据展示，用的nodeJs写的一个web界面

# 工作流程图

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/EFK/EFK.jpg)

# 原理简介

**filebeat**轻量级的缘故，所以一般和容器安装在一起，采集本地日志然后发送给elasticsearch。

官网上介绍filebeat传送数据的时候使用了敏感压力协议，如果检测到elasticsearch接收数据变慢，则会自动调整传输速率。

**kibana** 通过rest请求elasticsearch获取数据，并展示在web页面上，自带多种图表和开发者工具。
图中的app可以理解成某些微服务内置的应用，需要从elasticsearch中进行读写，例如在程序中使用jest直接操作elasticsearch。 
**elasticsearch**:这套日志方案中的核心，它的搜索引擎用的是lucene，所以可以胜任数据的检索。它有自己一套基于restful风格的查询语言。

# 安装

系统:ubuntu 16.04 (本文采用源码安装，这个无所谓)

内存大点，希望是2G及以上，毕竟是java应用

java环境



## 安装elasticsearch

### 下载

版本要求不要太低

[官网下载地址]( https://www.elastic.co/downloads/elasticsearch)

```bash
# wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.0.tar.gz
# tar xf elasticsearch-6.1.0.tar.gz
```

### 启动

```
# cd elasticsearch-6.1.0/ 
# sysctl -w vm.max_map_count=262144
# su 普通用户 #因为不能用root直接启动，不知道是否有配置可以修改，这里不深究
# ./bin/elasticsearch -d # -d 后台启动
```



### 检验

不过你也可以检查端口 9200 9300 ，比较慢，可能需要等一会

```bash
root@paa4:~# curl http://localhost:9200
{
  "name" : "c_pqyvs",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "V1DH_qO8SHKiSqrFpDVdjg",
  "version" : {
    "number" : "6.1.0",
    "build_hash" : "c0c1ba0",
    "build_date" : "2017-12-12T12:32:54.550Z",
    "build_snapshot" : false,
    "lucene_version" : "7.1.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

这里记住，你的elasticsearch 是localhost:9200

## 安装kibana

[官网下载地址](https://www.elastic.co/downloads/kibana)

### 下载

```bash
# wget https://artifacts.elastic.co/downloads/kibana/kibana-6.1.0-linux-x86_64.tar.gz #下载
# tar -xzf kibana-6.1.0-linux-x86_64.tar.gz #解压
cd kibana-6.1.0-linux-x86_64/ #进入安装目录

```

### 启动

```bash
# ./bin/kibana #运行，自动进入后台，端口5601
```

### 检验

这里要注意，kibana的进程名字叫node，他其实和elasticsearch是一家

```bash
root@paa4:~# netstat -lntup |grep node
tcp        0      0 192.168.0.168:5601      0.0.0.0:*               LISTEN      8889/node
```

### 修改host配置

```bash
root@paa4:~/kibana-6.1.0-linux-x86_64# vim config/kibana.yml
···
server.host: "192.168.0.168"  #这里是你的服务器ip
···
```

web页面查看 ：http://192.168.0.168:5601

## 安装filebeat

较新版的系统可以直接apt|yum 下载，不过比较少，现在最新版是5.6.0

[官网下载地址](https://www.elastic.co/downloads/past-releases/filebeat-5-6-0)
[直接安装地址](https://www.elastic.co/guide/en/beats/filebeat/current/setup-repositories.html)

### 下载

```bash
# wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.4-linux-x86_64.tar.gz
# tar xf filebeat-6.5.4-linux-x86_64.tar.gz
```

### 修改配置文件

采集日志文件位置

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/EFK/filebeat%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E6%94%B6%E9%9B%86%E6%97%A5%E5%BF%97.png)





kibana的host地址

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/EFK/filebeat%E7%9A%84kibana%E7%9A%84host.png)

elasticsearch的host地址

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/EFK/filebeat%E7%9A%84elasticsearch.png)



### 启动

```
# ./filebeat -e -c filebeat.yml #这个不能自动挂起哦
```



# demo

登录kibana 

web页面查看 ：http://192.168.0.168:5601

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/EFK/EFK1.png)



使用部分，请听下回分解