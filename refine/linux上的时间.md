# 要知道的

GMT====(Greenwich Mean Time，格林威治标准时间): 是指位于英国伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。

UTC=====(Universal Time/Temps Cordonné 世界标准时间)

UTC+800是指比格林威治标准时间提前8个小时，应当是东八区的时间，也就是北京时间

CST====中国标准时间



# 查看当前时区

## timedatectl

RedHat|Debian通用

```bash
root@paa3:~# timedatectl
      Local time: Thu 2018-12-27 18:25:02 CST   #本地时间是中国标准时间
  Universal time: Thu 2018-12-27 10:25:02 UTC   #世界标准时间
        RTC time: Thu 2018-12-27 10:25:01
       Time zone: Asia/Shanghai (CST, +0800)
 Network time on: yes
NTP synchronized: yes
 RTC in local TZ: no
```

## date

```bash
root@paa3:~# date -R
Thu, 27 Dec 2018 18:43:39 +0800      #中国标准时间
```



# 修改时区

## RedHat

```
#  tzselect
```

## Debian

```
# dpkg-reconfigure tzdata
```

## Debian | RedHat通用

```
# tzselect
```





# 报错

```
ntpdate[1103]: Can't adjust the time of day: Operation not permitted
```

同步阿里云时间的时候，报错

修改时区就好了