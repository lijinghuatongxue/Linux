# 环境

Ubuntu 16.04

能联网，防火墙关闭



# 安装

## GPG密钥

```bash
curl https://packagecloud.io/gpg.key | apt-key add -
```

## 将packagecloud存储库添加到APT源

```bash
add-apt-repository "deb https://packagecloud.io/grafana/stable/debian/ stretch main"
```

## 更新软件包列表

```bash
apt-get update
```

## 安装

```bash
apt-get install grafana -y
```

## 启动

```bash
systemctl start grafana-server
```

## 开机自启

```bash
systemctl enable grafana-server
```

# demo

默认端口是3000



![](https://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/grafana/grafana.png)







