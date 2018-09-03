
=========================Shell变量====================================


## 删除变量 

```
unset  变量
```




## shell位置变量

$1         运行shell程序的第一个参数

$2         运行shell程序的第二个参数

$num       依次类推，但是最多只能到$9

$#         代表shell程序的所有参数的个数

$* $@      将所有的参数作为一个整体，但是有更细微的区别

$*将所有的参数作为一个整体，$@将所有的参数分别作为个体对待

$$         代表当前进程的ID号码  

$?         代码程序的退出代码(一般0代表程序执行成功，非0代表命令执行失败)

## 一个脚本

```
[root@pa2 tmp]# sh 6666.sh lijinghua sunwangli niecongcong duanyuxi
lijinghua   >>>>我是第一个参数
sunwangli   >>>>我是第二个参数
4   >>>>我是参数的总数
lijinghua sunwangli niecongcong duanyuxi   >>>>我是所有参数的内容
lijinghua sunwangli niecongcong duanyuxi   >>>>我是所有参数的内容，但是我把所有参数作为一个个体来看待
23384   >>>>我是当前执行shell进程的ID号码
0   >>>>我是当前程序的退出代码
```

```
[root@pa2 tmp]# cat 6666.sh 

#!/bin/bash
echo	"$1   >>>>我是第一个参数"
echo	"$2   >>>>我是第二个参数"
echo	"$#   >>>>我是参数的总数"
echo	"$*   >>>>我是所有参数的内容"
echo	"$@   >>>>我是所有参数的内容，但是我把所有参数作为一个个体来看待"
echo	"$$   >>>>我是当前执行shell进程的ID号码"
echo	"$?   >>>>我是当前程序的退出代码"
```


​	

## 变量的展开替换

### 返回值

##### 否则返回

${name:-word}         如果name存在且非null，否则返回word

##### 否则设置

${name:=word}         如果name存在且非null，否则设置为word

##### 否则显示

${name:?message}      如果name存在且非null，则返回name:message

##### 返回word，否则返回null

${name:+word}         如果name存在且非null，则返回word，否则返回null


​	
### 删除和替换

${varible#key}                从头开始删除关键词，执行最短匹配

${varible##key}               从头开始删除关键词，执行最长匹配

${varible%key}                从尾开始删除关键词，执行最短匹配

${varible%%key}               从尾开始删除关键词，执行最长匹配

${variable/old/new}           将old替换为new，仅替换第一个出现的old

${variable//old/new}          将old替换为new，替换所有出现的old



### 示范

```
[root@pa2 ~]# usr=$(head -1 /etc/passwd)   #将$（）中的变量赋值给usr
[root@pa2 ~]# echo $usr
root:x:0:0:root:/root:/bin/bash 
[root@pa2 ~]# echo ${usr#*:}             
x:0:0:root:/root:/bin/bash
[root@pa2 ~]# echo ${usr##*:}
/bin/bash
[root@pa2 ~]# echo ${usr%:*}
root:x:0:0:root:/root
[root@pa2 ~]# echo ${usr%%:*}
root
[root@pa2 ~]# echo ${usr/root/admin}
admin:x:0:0:root:/root:/bin/bash
[root@pa2 ~]# echo ${usr//root/admin}
admin:x:0:0:admin:/admin:/bin/bash
```





## 再一个脚本

```
#!/bin/bash
foo() {
    # Whatever. An error occurred and I'm returning -1
    return -1
}
bar() {
    foo
    if [ "$?" = "-1" ]; then
        # -1 is my "error code" and I'm returning it
        exit -1
    fi
}
bar # Calls the "bar" function
```




