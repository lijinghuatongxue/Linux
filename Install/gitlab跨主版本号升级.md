

# 要知道的



要求：升级现有的10.1.0版本的gitlab，保证备份数据可以直接导入



从[官网](https://docs.gitlab.com/omnibus/update/gitlab_11_changes.html)得知：跨越主版本号的升级，从10.1.0到最新的11.2.7，必须先把目前的10.1.0升级到10.8版本，再升级到最新的11.2.7

当然，我们可以直接按照官网给出的文档直接安装最新的，但是存在的问题是，无法轻松的把现在备份的仓库代码导入到新版本的gitlab上。

gitlab对备份数据的导入要求是苛刻的，导入之前，老版本号和新版本号必须一致，否则无效。



安装包下载地址：[https://packages.gitlab.com/gitlab/gitlab-ce](https://packages.gitlab.com/gitlab/gitlab-ce)



## 删除老配置文件并重新配置

```
➜  ~  rm /etc/gitlab/gitlab.rb
➜  ~  gitlab-ctl reconfigure
```



## 获取老版本号码

```
lijinghua@debian:~$ cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
10.1.0
```

​    

## 先安装10.8的版本

```
➜  ~ wget --content-disposition https://packages.gitlab.com/gitlab/gitlab-ce/packages/debian/wheezy/gitlab-ce_10.8.7-ce.0_amd64.deb/download.deb

➜  ~ dpkg -i gitlab-ce_10.8.7-ce.0_amd64.deb
```



## 再安装最新版本11.2.7

```
➜  ~ wget https://packages.gitlab.com/gitlab/gitlab-ce/packages/debian/wheezy/gitlab-ce_11.2.7-ce.0_amd64.deb
➜  ~ dpkg -i gitlab-ce_11.2.7-ce.0_amd64.deb
```

## 重启gitlab（必须的）

重新加载所有

```
➜  ~  gitlab-ctl restart
```



## 当前版本号

```
➜  ~ cat /opt/gitlab/embedded/service/gitlab-rails/VERSION
     11.2.7
```

  cat /opt/gitlab/embedded/service/gitlab-rails/VERSION



升级成功

