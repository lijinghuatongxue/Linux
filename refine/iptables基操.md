## 拒绝任意网络访问主机的 6666端口

```
iptables -A INPUT -p TCP -s 0.0.0.0/0 --dport 6666 -j REJECT
```

## 丢弃任意网络访问主机的 6666端口

```
iptables -A INPUT -p TCP -s 0.0.0.0/0 --dport 6666 -j DROP
```

## 接受任意网络访问主机的 6666端口
```
iptables -A INPUT -p TCP -s 0.0.0.0/0 --dport 6666 -j ACCEPT
```



## 禁止ping
```
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP	 ### 向INPUT链追加规则：抛弃来自其他机器的imcp-request数据
```



## 禁止响应外部ping
```
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j DROP	 ### 向OUTPUT链追加规则：抛弃本机对外发出的icmp-reply数据
```



## 允许外部ping入
```
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT	 ### 向INPUT链追加规则：接受来自其他机器的imcp-request数据
```



## 允许响应外部ping入
```
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT	 ### 向OUTPUT链追加规则：接受本机对外发出的icmp-reply数据
```



## 接受其他机器向本机873端口发送的TCP
```
iptables -A INPUT -p tcp --dport 873 -j ACCEPT	 ### 向INPUT链追加规则：接受其他机器向本机873端口发送的TCP数据
```



## 拒绝其他所有机器的80端口响应
```
 iptables -A INPUT -p TCP --dport  80  -j REJECT
```



## 允许发送dns

```
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT	 ### 向INPUT链追加规则：允许本机通过53端口对外发送UDP数据
```

