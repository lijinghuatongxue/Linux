# 容器退出时就能够自动清理容器内部的文件系统

```
docker --rm
```

显然，--rm选项不能与-d同时使用，即只能自动清理foreground容器，不能自动清理detached容器
注意，--rm选项也会清理容器的匿名data volumes。
所以，执行docker run命令带--rm命令选项，等价于在容器退出后，执行docker rm -v。

# docker服务重启时容器自动重启

```
--restart=always
```

# Mysql 编码问题

```
--character-set-server=utf8 --collation-server=utf8_bin
```

