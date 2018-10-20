

# 前面的话



ETL，是英文 Extract-Transform-Load 的缩写，用来描述将数据从来源端经过抽取（extract）、转换（transform）、加载（load）至目的端的过程。



 DataX 是一个异构数据源离线同步工具，致力于实现包括关系型数据库(MySQL、Oracle等)、HDFS、Hive、MaxCompute(原ODPS)、HBase、FTP等各种异构数据源之间稳定高效的数据同步功能。





# 环境准备

- Linux
- [JDK(1.8以上，推荐1.8)](http://www.oracle.com/technetwork/cn/java/javase/downloads/index.html)
- [Python(推荐Python2.6.X)](https://www.python.org/downloads/)
- [Apache Maven 3.x](https://maven.apache.org/download.cgi) (Compile DataX)

```
➜  ~ mvn -v
Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-18T02:33:14+08:00)
Maven home: /usr/local/maven
Java version: 1.8.0_20, vendor: Oracle Corporation, runtime: /usr/java/jdk/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.4.0-130-generic", arch: "amd64", family: "unix"
➜  ~ java -version
java version "1.8.0_181"
Java(TM) SE Runtime Environment (build 1.8.0_181-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.181-b13, mixed mode)
➜  ~ python -V
Python 2.7.12
```



# 下载与解压

[源地址](https://github.com/alibaba/DataX)：https://github.com/alibaba/DataX



```
➜  ~ wget http://datax-opensource.oss-cn-hangzhou.aliyuncs.com/datax.tar.gz
➜  ~ tar xf datax.tar.gz
```



# 自检

```
➜  cd /datax
➜  datax  python ./bin/datax.py ./job/job.json

DataX (DATAX-OPENSOURCE-3.0), From Alibaba !
Copyright (C) 2010-2017, Alibaba Group. All Rights Reserved.

2018-10-20 22:52:33.019 [main] INFO  VMInfo - VMInfo# operatingSystem class => sun.management.OperatingSystemImpl
2018-10-20 22:52:33.042 [main] INFO  Engine - the machine info  =>

​```
osInfo:	Oracle Corporation 1.8 25.181-b13
jvmInfo:	Linux amd64 4.4.0-130-generic
cpu num:	1

totalPhysicalMemory:	-0.00G
freePhysicalMemory:	-0.00G
maxFileDescriptorCount:	-1
currentOpenFileDescriptorCount:	-1

GC Names	[Copy, MarkSweepCompact]

MEMORY_NAME                    | allocation_size                | init_size
Eden Space                     | 273.06MB                       | 273.06MB
Code Cache                     | 240.00MB                       | 2.44MB
Survivor Space                 | 34.13MB                        | 34.13MB
Compressed Class Space         | 1,024.00MB                     | 0.00MB
Metaspace                      | -0.00MB                        | 0.00MB
Tenured Gen                    | 682.69MB                       | 682.69MB
​```

2018-10-20 22:52:33.093 [main] INFO  Engine -
{
	"content":[
		{
			"reader":{
				"name":"streamreader",
				"parameter":{
					"column":[
						{
							"type":"string",
							"value":"DataX"
						},
						{
							"type":"long",
							"value":19890604
						},
						{
							"type":"date",
							"value":"1989-06-04 00:00:00"
						},
						{
							"type":"bool",
							"value":true
						},
						{
							"type":"bytes",
							"value":"test"
						}
					],
					"sliceRecordCount":100000
				}
			},
			"writer":{
				"name":"streamwriter",
				"parameter":{
					"encoding":"UTF-8",
					"print":false
				}
			}
		}
	],
	"setting":{
		"errorLimit":{
			"percentage":0.02,
			"record":0
		},
		"speed":{
			"byte":10485760
		}
	}
}

2018-10-20 22:52:33.183 [main] WARN  Engine - prioriy set to 0, because NumberFormatException, the value is: null
2018-10-20 22:52:33.189 [main] INFO  PerfTrace - PerfTrace traceId=job_-1, isEnable=false, 
···········
DataX Process was killed ! you did ?
➜  datax
```



# 参考json配置



mysql|drds|oracle|ads|sqlserver|postgresql|db2 通用







jdbcUrl防乱码处理  "jdbcUrl": ["jdbc:mysql://127.0.0.1:3306/database_name?characterEncoding=utf8"],   

```
{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "db_reader", 
                    "parameter": {
                        "column": [
							"id",
                            "name"
						], 
                        "connection": [
                            {
                                "jdbcUrl": ["jdbc:mysql://127.0.0.1:3306/dbname"], 
                                "table": ["table1"]
                            }
                        ], 
                        "password": "123456", 
                        "username": "root"
                    }
                }, 
                "writer": {
                    "name": "db_writer", 
                    "parameter": {
                        "column": [
                        "id",
                        "name"
						], 
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://ip地址:端口/dbname", 
                                "table": ["table2"]
                            }
                        ], 
                        "password": "123456", 
                        "username": "root"
                    }
                }
            }
        ], 
        "setting": {
            "speed": {
                "channel": "1"
            }
        }
    }
}
```





```
CREATE TABLE table_name (column_name column_type);
```

```
INSERT INTO table_name ( test, test2,test3 )
                       VALUES
                       ( 1, 111,2222 );
```

```
CREATE TABLE IF NOT EXISTS `table_name`(
   `id` INT UNSIGNED AUTO_INCREMENT,
   `title` VARCHAR(100) NOT NULL,
   `author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
);
```