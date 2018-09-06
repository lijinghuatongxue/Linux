===================================bash数组=========================================

## 前面的话

bash提供了一堆数组变量的功能，数组中的所有变量都会被编录成索引
数组的索引是从0开始的整数，且没有大小限制，一般有两种方法创建数组变量


## 怎么定义

1. name[subscript]=value  

subscript必须是大于或者等于0的整数

2. name=(value1 value2 value3 valuen)

declare -a <name> 可以预定义一个空数组变量



## 怎么调用

数组定义完成之后，我们使用${name[subscript]}来调用数组变量的值，如果subscript是@或者*符号，则将调用所有的数组成员

使用${#name[subscript]}可以返回${name[subscript]}的长度，如果subscript是*或者@，则返回数组中元素的个数

## 示例

```
[root@local ~]#name[1]=lijinghua
[root@local ~]#name[2]=niecongcong
[root@local ~]#echo ${name[1]},${name[2]}
lijinghua,niecongcong



[root@local ~]#num=(1 2 3 4 5 66666)
[root@local ~]#echo ${num[2]}
3
[root@local ~]#echo ${num[2]} ${num[4]}
3 5
[root@local ~]#echo ${num[2]}:${num[4]}
3:5

[root@local ~]#echo ${num[*]}
1 2 3 4 5 66666
[root@local ~]#echo ${num[@]}
1 2 3 4 5 66666

[root@local ~]#echo ${#num[5]}   #返回长度
5

[root@local ~]#echo ${#num[@]}   #数组中元素的个数
6


```

