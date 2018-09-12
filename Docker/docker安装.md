# 环境 

内核的版本必须大于3.10

# 安装docker

```
yum install -y epel-release
yum install docker-io # 安装docker
```



# 配置文件 /etc/sysconfig/docker
## 加入开机启动

```
chkconfig docker on  
```


# 启动docker服务
```
service docker start 

## 查看启动情况

ps -ef |grep docker
```

## 查看docker的版本号，包括客户端、服务端、依赖的Go等

```
docker version
```



## 查看系统(docker)层面信息，包括管理的images, containers数等

```
docker info
```

# 配置docker国内加速器(不然得下载到明年,时间宝贵啊)

```
#阿里云docker加速地址申请地址https://cr.console.aliyun.com/    (打开这个链接就明白了,选择你的服务器版本)

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://p0usl3vw.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```


