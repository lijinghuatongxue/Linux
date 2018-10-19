  # ping出ip

域名=ip

```
➜  ~ ping www.lijinghua.club -c 5
PING www.lijinghua.club (59.110.172.131) 56(84) bytes of data.
64 bytes from 59.110.172.131: icmp_seq=1 ttl=47 time=51.0 ms
64 bytes from 59.110.172.131: icmp_seq=2 ttl=47 time=51.0 ms
64 bytes from 59.110.172.131: icmp_seq=3 ttl=47 time=51.0 ms
64 bytes from 59.110.172.131: icmp_seq=4 ttl=47 time=51.0 ms
64 bytes from 59.110.172.131: icmp_seq=5 ttl=47 time=51.0 ms

--- www.lijinghua.club ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4004ms
rtt min/avg/max/mdev = 51.006/51.035/51.089/0.032 ms
```



# python 

## builtwith库

python提供了builtwith库，会返回一些它获取到的服务，比如web服务，

本文环境 python 2.7 

官网提供的格式我用2.7版本的python有些问题

>>> ```
>>> ➜  ~ python
>>> Python 2.7.12 (default, Dec  4 2017, 14:50:18)
>>> [GCC 5.4.0 20160609] on linux2
>>> Type "help", "copyright", "credits" or "license" for more information.
>>> 
>>> > > > import builtwith
>>> > > > builtwith.parse('http://www.biaodianfu.com/')
>>> > > > {u'blogs': [u'PHP', u'WordPress'], u'font-scripts': [u'Font Awesome'], u'web-servers': [u'Nginx'], u'javascript-frameworks': [u'jQuery'], u'programming-languages': [u'PHP'], u'marketing-automation': [u'Yoast SEO'], u'web-frameworks': [u'Twitter Bootstrap'], u'cms': [u'WordPress'], u'cache-tools': [u'WordPress Super Cache']}
>>> > > > builtwith.parse('http://www.lijinghua.club/')
>>> > > > {u'web-servers': [u'Nginx']}
>>> > > > builtwith.parse('http://blog.lijinghua.club/')
>>> > > > {u'javascript-frameworks': [u'jQuery'], u'web-servers': [u'Nginx']}
>>> > > > builtwith.parse('http://img.lijinghua.club/')
>>> > > > {u'web-servers': [u'Nginx']}
>>> ```



## wad库

环境 python 2.7 

```
➜  WAD git:(master) pip install --upgrade pip
➜  WAD git:(master) wad -u https://pypi.python.org/
{
    "https://pypi.org/": [
        {
            "type": "web-servers", 
            "app": "Nginx", 
            "ver": "1.13.9"
        }, 
        {
            "type": "font-scripts", 
            "app": "Google Font API", 
            "ver": null
        }
    ]
}
➜  WAD git:(master) wad -u https://lijinghua.club/ 
{
    "https://lijinghua.club/": [
        {
            "type": "web-servers", 
            "app": "Nginx", 
            "ver": null
        }
    ]
}
```



# nmap 扫描

左边的是扫描出来的服务，下面是扫描出来的端口

扫描出的信息很多，有最基本的web服务是什么，猜测下该机器是什么内核，仔细看

<img src="https://s1.ax1x.com/2018/10/19/iw5MRO.png" alt="iw5MRO.png" border="0" />





# 嗅探子域名

```
(py3) ➜  git clone https://github.com/TheRook/subbrute.git

(py3) ➜  cd subbrute

(py3) ➜  subbrute git:(master) ✗ ./subbrute.py lijinghua.club -o lijinghua.names

lijinghua.club

www.lijinghua.club

blog.lijinghua.club

img.lijinghua.club

·····
```



# builtwith网站提供的服务

地址：https://builtwith.com/



<a href="https://imgchr.com/i/iwIwA1"><img src="https://s1.ax1x.com/2018/10/19/iwIwA1.md.png" alt="iwIwA1.png" border="0" /></a>





<a href="https://imgchr.com/i/iwIbuQ"><img src="https://s1.ax1x.com/2018/10/19/iwIbuQ.md.jpg" alt="iwIbuQ.jpg" border="0" /></a>



# 现在存在的问题

我们可能ping出该域名的ip，查出但是不能揪出其背后的服务架构，可能根据nmap扫描出的端口猜测下用了什么服务（但是常用端口可以更改），小体量的服务可能所有的服务都在同一台机器，稍微大一点的网站都会db与web分离，准确性有待提高



## 找出ip所在的机器在云上还是物理机器



地址：http://ip.cn

<a href="https://imgchr.com/i/iwoEU1"><img src="https://s1.ax1x.com/2018/10/19/iwoEU1.md.png" alt="iwoEU1.png" border="0" /></a>

## nmap ip出来的端口

```
➜  ~ nmap 66.66.**.**

Starting Nmap 7.01 ( https://nmap.org ) at 2018-10-19 13:30 CST
Nmap scan report for 118.24.197.55
Host is up (0.0012s latency).
Not shown: 996 closed ports
PORT     STATE    SERVICE
22/tcp   open     ssh
25/tcp   filtered smtp
800/tcp  open     mdbs_daemon
3306/tcp filtered mysql
```

