# 环境

ubuntu 16.04

Go 1.11.5 （自带）

# server 端

## 下载解压server端

官网地址：https://prometheus.io/download/

```bash
root@paa3:~# wget https://github.com/prometheus/prometheus/releases/download/v2.7.1/prometheus-2.7.1.linux-amd64.tar.gz
root@paa3:~# tar xf prometheus-2.7.1.linux-amd64.tar.gz -C /usr/local/
root@paa3:/usr/local# mv prometheus-2.7.1.linux-amd64 prometheus
```

## 看版本

```bash
root@paa3:/usr/local/prometheus# ./prometheus --version
prometheus, version 2.7.1 (branch: HEAD, revision: 62e591f928ddf6b3468308b7ac1de1c63aa7fcf3)
  build user:       root@f9f82868fc43
  build date:       20190131-11:16:59
  go version:       go1.11.5
```

## 启动server

```bash
root@paa3:/usr/local/prometheus# /usr/local/prometheus/prometheus
level=info ts=2019-02-02T08:12:02.989555596Z caller=main.go:302 msg="Starting Prometheus" version="(version=2.7.1, branch=HEAD, revision=62e591f928ddf6b3468308b7ac1de1c63aa7fcf3)"
level=info ts=2019-02-02T08:12:02.989690547Z caller=main.go:303 build_context="(go=go1.11.5, user=root@f9f82868fc43, date=20190131-11:16:59)"
···
level=info ts=2019-02-02T08:12:03.038777217Z caller=main.go:695 msg="Loading configuration file" filename=prometheus.yml
level=info ts=2019-02-02T08:12:03.04072375Z caller=main.go:722 msg="Completed loading of configuration file" filename=prometheus.yml
level=info ts=2019-02-02T08:12:03.040790936Z caller=main.go:589 msg="Server is ready to receive web requests."
```

## demo

随意选择一个选项，然后点击execute

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/prometheus-demo.png)

# Node端

## 下载解压node端

```bash
root@paa2:~# wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
root@paa2:~# tar xf node_exporter-0.17.0.linux-amd64.tar.gz -C /usr/local/
root@paa2:/usr/local# mv node_exporter-0.17.0.linux-amd64 node_exporter
```

## 启动node

```bash
root@paa2:/usr/local/node_exporter# ./node_exporter
INFO[0000] Starting node_exporter (version=0.17.0, branch=HEAD, revision=f6f6194a436b9a63d0439abc585c76b19a206b21)  source="node_exporter.go:82"
INFO[0000] Build context (go=go1.11.2, user=root@322511e06ced, date=20181130-15:51:33)  source="node_exporter.go:83"
INFO[0000] Enabled collectors:                           source="node_exporter.go:90"
INFO[0000]  - arp                                        source="node_exporter.go:97"
INFO[0000]  - bcache                                     source="node_exporter.go:97"
INFO[0000]  - bonding                                    source="node_exporter.go:97"
INFO[0000]  - conntrack                                  source="node_exporter.go:97"
INFO[0000]  - cpu                                        source="node_exporter.go:97"
····
INFO[0000]  - xfs                                        source="node_exporter.go:97"
INFO[0000]  - zfs                                        source="node_exporter.go:97"
INFO[0000] Listening on :9100                            source="node_exporter.go:111"
```

## 检测node端

返回大一堆指标，省略一部分

```bash
root@paa2:/usr/local/node_exporter# curl 127.0.0.1:9100/metrics |head
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0# HELP go_gc_duration_seconds A summary of the GC invocation durations.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 0
go_gc_duration_seconds{quantile="0.25"} 0
go_gc_duration_seconds{quantile="0.5"} 0
go_gc_duration_seconds{quantile="0.75"} 0
go_gc_duration_seconds{quantile="1"} 0
go_gc_duration_seconds_sum 0
go_gc_duration_seconds_count 0
# HELP go_goroutines Number of goroutines that currently exist.
100  8026    0  8026    0     0   266k      0 --:--:-- --:--:-- --:--:--  279k
curl: (23) Failed writing body (0 != 2048)
```

## node 加入监控集群

### 配置文件



注意空格，要求比较严格

```bash
root@paa3:/usr/local/prometheus# cat prometheus.yml  | tail -3
  - job_name: "node1"
    static_configs:
    - targets: ['192.168.0.166:9100']
```

### demo

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/prometheus-add-node-ui.png)



# 安装 grafana 

略

# grafana 连接 prometheus

## 添加数据源



![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/grafana-add-data-source.png)



## 直接选择

默认就有

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/prometheus2.png)



## 配置

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/promtheus-grafana-add.png)



## 导入模版

![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/prometheus%2Bgrafana-dashboards.png)



## 查看demo



![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/prometheus/grafana%2Bpromethues%2Bdemo.png)

