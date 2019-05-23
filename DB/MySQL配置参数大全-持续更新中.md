```
[client]

# =======================================================CLIENT

socket                  =/usr/local/mysql/mysql.sock
port                           = 3306

[mysqldump]
quick

[mysqld]

# ======================================================GENERAL

# 服务器标识id(用于主从复制)

server_id               = 1

# 操作mysql的系统用户名

user   = mysql
#默认字符
character_set_server    =utf8mb4
#gtid_mode              =on                 
basedir                 =/usr/local/mysql
datadir                 =/home/MysqlData

# mysql socket连接文件

socket                  =/usr/local/mysql/mysql.sock

# 记录mysql进程的文件

pid-file                =/usr/local/mysql/mysql.pid

# MyISAM

# 索引缓冲区大小

key_buffer_size         = 1024M

# 自动检查和修复没有适当关闭的MyISAM表

#myisam-recover = FORCE,BACKUP

# MyISAM表发生变化时重新排序所需要的缓冲区大小

#myisam-sort-buffer-size=  128M

# 重建索引时所允许的最大临时文件大小

#myisam-max-sort-file-size  =  10G

# 设置网络传输中一次消息传输量的最大值，取值范围为1MB~1GB,必须设置为1024的倍数

max_allowed_packet      = 160M

#每个线程的堆栈大小
thread_stack            = 192K

#线程缓存
thread_cache_size       = 200

#session级别
binlog_cache_size       = 512M

# 单个查询能够使用的缓冲区大小

query-cache-limit  = 4M

# SQL模式(在生产环境要设置为严格模式，可以防止非法数据的插入)

sql-mode   = STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_AUTO_VALUE_ON_ZERO,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ONLY_FULL_GROUP_BY

#==========================================default settings===============

# 系统时间和当前时间一致

sysdate-is-now = 1
#服务器时区
default-time-zone = system 

# 二进制日志是否同步写入磁盘(1表示每次每写入，是最安全的，但也是最慢的)

sync_binlog             =1

# 日志有效时间

expire-logs-days   = 14

# 默认存储引擎

default-storage-engine = InnoDB

#=======================================提升性能开关

# 线程并发数，一般设置为核数的2倍，如8核的CPU可以设置为16

#thread_concurrency     = 2
#所有线程打开的表的数目。增大该值可以增加mysqld需要的文件描述符的数量
#table_cache = 512 

# innodb文件IO线程数(与cpu有关)

#innodb-file-io-threads =  4

# innodb并发线程数(与CPU核数相关)

#innodb-thread-concurrency  =  8

# 打开文件描述符的限制(至少在大于 table-open-cache*2+InnoDB表的数量)

open-files-limit   = 65535

#=====================================安全

# 避免MySQL外部锁定

external-locking = FALSE
# innodb的dml操作的行级锁的等待时间
innodb_lock_wait_timeout = 5

# 数据结构ddl操作的锁的等待时间
lock_wait_timeout = 5
# 连接地址限制

bind-address		= 0.0.0.0

#=========================================连接 

# 每个主机在连接请求异常中断的最大次数，当超过该次数，则禁止host的连接请求，直到服务器重启或flush hosts;命令清空该host的相关信息

#max-connect-errors = 6000

# mysql最大进程连接数

max_connections         = 3000
#连接超时之前的最大秒数,在Linux平台上，该超时也用作等待服务器首次回应的时间
connect-timeout = 10
#等待关闭连接的时间
wait_timeout            = 288000
#关闭连接之前，允许interactive_timeout（取代了wait_timeout）秒的不活动时间。客户端的会话wait_timeout变量被设为会话interactive_timeout变量的值
interactive_timeout     = 288000



# CACHES AND LIMITS

#====================================log 

#超过多少天的binlog删除
expire_logs_days        = 10
max_binlog_size         = 1G
#路径相对于datadir，开启binlog
log-bin                 = mysql-bin
#二进制日志格式
binlog_format           =mixed

# 是否记录未使用索引的查询

log-queries-not-using-indexes  = 1

# 是否开启慢查询日志

slow-query-log = 1

# 慢查询日志文件位置

slow-query-log-file= /home/MysqlData/mysql-slow.log
#错误日志
log-error               = /home/MysqlData/mysql.err
#当不用中继日志时，删除他们。这个操作有SQL线程完成
relay-log-purge = 1 

# 内存临时表大小(超过其大小会写入磁盘)

tmp-table-size = 32M

# 可创建的内存表大小

max-heap-table-size= 32M

# 是否将查询结果放到查询缓存中

query-cache-type   = 0

# 单个查询能够使用的缓冲区大小

query_cache_limit       = 4M

# 查询缓存大小(在写入量大的系统，建议关闭)

query-cache-size   = 0
#查询缓存分配的最小块大小
query_cache_min_res_unit = 2K 

# 服务器线程缓存大小，类似于缓存池，1G内存建议为8，2G内存建议为16，4G以上可以配置更大

query_cache_size        = 1024M
#线程缓存
thread_cache_size       = 150

#innodb_thread_concurrency = 0

#session级别
binlog_cache_size = 1M 

#explicit_defaults_for_timestamp=true

# 线程并发数，一般设置为核数的2倍，如8核的CPU可以设置为16

#thread-concurrency = 1

# 表缓存区大小，应该与max_connections设置相关

#table-cache= 614

# 表定义信息缓存(从.frm文件中获取的)

#table-definition-cache = 1024

# 打开表(文件描述符)的缓存数量

#table-open-cache   = 1024

# 读入缓冲区大小

#read-buffer-size   = 1M

# 随机读缓冲区大小

#read-rnd-buffer-size   = 16M

# 批量插入缓冲区大小

#bulk-insert-buffer-size= 64M

# 用于排序的缓冲区大小

#sort-buffer-size   = 2M

# 表间关联的缓冲区大小

#join-buffer-size   = 2M



# ====================================================INNODB

#innodb刷新日志和数据的模式，有

#innodb-flush-method= O_DIRECT

# 为提高性能，可以以循环方式将日志文件写入到多个文件， 两组事物日志

innodb-log-files-in-group  = 2

# 日志缓存区大小

innodb-log-buffer-size =  16M

# innodb日志文件大小

innodb-log-file-size   = 256M

# 提交事务后将日志写入磁盘的频率

innodb-flush-log-at-trx-commit = 1

# 每个innodb表使用一个数据文件

innodb-file-per-table  = 1

# innodb缓存池大小

innodb-buffer-pool-size= 1G
#innodb主线程刷新缓存池中的数据，使脏数据比例小于90%
innodb_max_dirty_pages_pct = 90 

# 在MySQL暂时停止响应新请求前，短时间内的多少个请求可以被存在堆栈中

back_log = 600

# 设置事务的隔离级别，可以使用READ-UNCOMMITED 读未提交，READ-COMMITED 读已提交；REPEATABLE-READ 可重复读；SERIALIZABLE 串行

#transaction_isolcation = READ-COMMITED

# 表名都小写

#lower_case_table_names =  1

#==================================================从服务器优化
slave-net-timeout = 600 #从服务器也能够处理网络连接中断。但是，只有从服务器超过slave_net_timeout秒没有从主服务器收到数据才通知网络中断
net_read_timeout = 30 #从服务器读取信息的超时
net_write_timeout = 60 #从服务器写入信息的超时
net_retry_count = 10 #如果某个通信端口的读操作中断了，在放弃前重试多次
net_buffer_length = 16384 #包消息缓冲区初始化为net_buffer_length字节，但需要时可以增长到

 #复制时忽略数据库及表
replicate-wild-ignore-table = mysql.%
#复制时忽略数据库及表
replicate-wild-ignore-table = test.% 
#开启log-slave-updates参数后，从库从主库复制的数据会写入log-bin日志文件里。这也是该参数的功能
log-slave-updates       = 1
#skip_slave_start 该选项能够阻止备库在崩溃后自动启动复制，崩溃后启动复制，数据可能不一致
skip_slave_start        =1 
#该选项会阻止任何没有特权权限的线程修改数据
read_only = 1   

#skip-grant-tables
[mysqlsafe]
```

