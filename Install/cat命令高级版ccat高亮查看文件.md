# 介绍

此方法对于mac，ubuntu，及Centos通用

采用下载二进制文件方式使用这个命令，系统自带的源是没有这个得



# 下载包安装

```
wget https://github.com/jingweno/ccat/releases/download/v1.1.0/linux-amd64-1.1.0.tar.gz
```



## 其他版本的看这里

```
https://github.com/jingweno/ccat/release
```


接着解压

```
tar -zxvf linux-amd64-1.1.0.tar.gz
```


移动到二进制文件目录

```
cd linux-amd64-1.1.0
sudo mv ccat /usr/bin/ccat
```

接着给这个文件赋予可执行权限

```
sudo chmod +x /usr/bin/ccat
```


之后就可以和cat一样执行命令了

# 使用

如果你觉得ccat比cat好，而且我以后不想使用cat了，想用ccat来代替cat，两个方法

## 别名

```
vim ~/.bashrc #注意，我使用的是bash

alias cat=ccat #添加此列
```


之后使配置文件生效

```
source ~/.bashrc
```


接着直接输入cat就相当于使用ccat了

 ## 再者就是直接覆盖掉之前的cat二进制命令

```
cp -f /usr/bin/ccat /usr/bin/cat
```

