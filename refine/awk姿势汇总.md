# 基本姿势

`$0`代表当前行

`awk`会根据空格和制表符，将每一行分成若干字段，依次用`$1`、`$2`、`$3`代表第一个字段、第二个字段、第三个字段等

`FNR` 代表行号

变量`NF`表示当前行有多少个字段，因此`$NF`就代表最后一个字段

`$(NF-1)`代表倒数第二个字段



```sh
➜  ~ echo I love U |awk '{print $1}'             #不加-F参数默认根据空格来切割
I

➜  ~ echo I love U |awk -F " " '{print $1}'
I
```



# 变量

## NF

变量`NF`表示当前行有多少个字段，因此`$NF`就代表最后一个字段

```sh
➜  ~ echo I love U |awk -F " " '{print $NF}'
U
```

`$(NF-1)`代表倒数第二个字段

```sh
➜  ~ echo I love U |awk -F " " '{print $1 , $(NF-1) }'   #逗号代表空格分开
I love
```

`print`命令里面，如果原样输出字符，要放在双引号里面

```sh
➜  ~ echo I love U |awk -F " " '{print $1 ":" $(NF-1) }'
I:love
```

## 其他变量

- `FILENAME`：当前文件名
- `FS`：字段分隔符，默认是空格和制表符。
- `RS`：行分隔符，用于分割每一行，默认是换行符。
- `OFS`：输出字段的分隔符，用于打印时分隔字段，默认为空格。
- `ORS`：输出记录的分隔符，用于打印时分隔记录，默认为换行符。
- `OFMT`：数字输出的格式，默认为`％.6g`。



# 函数

## `length`返回字符串

```sh
➜  ~ echo I love U |awk  '{print  length($2) }'
4
```



## 其他函数

- `tolower()`：字符转为小写。
- `toupper()`：字符串转为大写。
- `substr()`：返回子字符串。
- `sin()`：正弦。
- `cos()`：余弦。
- `sqrt()`：平方根。
- `rand()`：随机数。



# 条件

格式：

```bash
awk '条件 动作' 字符流
```

demo文件

```sh
➜  ~ cat 67.txt
/001
/002
/001 /003 /004 /005
/006 /007 lijinghua limeihua
niecongcong duanyuxi duanyuxi
```

## 过滤包含00的行

/00/ 这里当作正则表达式

```shell
➜  ~ cat 67.txt |awk '/00/ {print $1}'
/001
/002
/001
/006
```

## 过滤奇数行and行号

NR % 2 == 1

```shell
➜  ~ cat 67.txt |awk 'NR %2 == 1 {print FNR " " $1}'
1 /001
3 /001
5 niecongcong
```

## 过滤大于2行以后的行

```shell
➜  ~ cat 67.txt |awk 'NR>2 {print FNR " " $1}'
3 /001
4 /006
5 niecongcong
```

## 指定输出字符第一行是啥







# if

demo文件

