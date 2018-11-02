

# 前面的话



ETL，是英文 Extract-Transform-Load 的缩写，用来描述将数据从来源端经过抽取（extract）、转换（transform）、加载（load）至目的端的过程。



 DataX 是一个异构数据源离线同步工具，致力于实现包括关系型数据库(MySQL、Oracle等)、HDFS、Hive、MaxCompute(原ODPS)、HBase、FTP等各种异构数据源之间稳定高效的数据同步功能。





# 环境准备

- Linux
- [JDK(1.8以上，推荐1.8)](http://www.oracle.com/technetwork/cn/java/javase/downloads/index.html)
- [Python(推荐Python2.6.X)](https://www.python.org/downloads/)
- [Apache Maven 3.x](https://maven.apache.org/download.cgi) (Compile DataX)
- 两台数据库

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





# 怎样获取标准json格式？



jdbcUrl防乱码处理  "jdbcUrl": ["jdbc:mysql://127.0.0.1:3306/database_name?characterEncoding=utf8"], 

## mysql 到 mysql

```
python datax.py  -r mysqlreader -w mysqlwriter
```



## postgres到mysql

```
➜  bin python datax.py  -r postgresqlreader -w mysqlwriter

DataX (DATAX-OPENSOURCE-3.0), From Alibaba !
Copyright (C) 2010-2017, Alibaba Group. All Rights Reserved.


Please refer to the postgresqlreader document:
     https://github.com/alibaba/DataX/blob/master/postgresqlreader/doc/postgresqlreader.md

Please refer to the mysqlwriter document:
     https://github.com/alibaba/DataX/blob/master/mysqlwriter/doc/mysqlwriter.md

Please save the following configuration as a json file and  use
     python {DATAX_HOME}/bin/datax.py {JSON_FILE_NAME}.json
to run the job.

{
    "job": {
        "content": [
            {
                "reader": {
                    "name": "postgresqlreader",
                    "parameter": {
                        "connection": [
                            {
                                "jdbcUrl": [],
                                "table": []
                            }
                        ],
                        "password": "",
                        "username": ""
                    }
                },
                "writer": {
                    "name": "mysqlwriter",
                    "parameter": {
                        "column": [],
                        "connection": [
                            {
                                "jdbcUrl": "",
                                "table": []
                            }
                        ],
                        "password": "",
                        "preSql": [],
                        "session": [],
                        "username": "",
                        "writeMode": ""
                    }
                }
            }
        ],
        "setting": {
            "speed": {
                "channel": ""
            }
        }
    }
}
➜  bin
```



# 使用

```
➜  bin python datax.py   *.json
```



#  例子补充

*mysql数据库测试* 

## mysql插入数据

### 写入表字段

```
mysql> use test1;
Database changed
mysql> show tables;
+-----------------+
| Tables_in_test1 |
+-----------------+
| table1          |
+-----------------+
1 row in set (0.00 sec)


mysql> CREATE TABLE IF NOT EXISTS `table1`
(    `runoob_id`  VARCHAR(100) NOT NULL,  
     `runoob_title` VARCHAR(100) NOT NULL,   
     `runoob_author` VARCHAR(40) NOT NULL,    
     `submission_date` VARCHAR(40) NOT NULL ,    
     `runoob` VARCHAR(40) NOT NULL )
;


CREATE TABLE test_bak(
   runoob_id  VARCHAR(100) NOT NULL,
   runoob_title           VARCHAR(100)    NOT NULL,
   runoob_author            VARCHAR(100)     NOT NULL,
   submission_date        CHAR(50) NOT NULL ,
   runoob    VARCHAR(40)     NOT NULL
);  
```

### json参考格式

```
{
    "job": {
        "setting": {
            "speed": {
                "channel": 1
            }
        },
        "content": [
            {
                 "reader": {
                    "name": "streamreader",
                    "parameter": {
                        "column" : [
                            {
                                "value": "DataX",
                                "type": "string"
                            },
                            {
                                "value": 19880808,
                                "type": "long"
                            },
                            {
                                "value": "1988-08-08 08:08:08",
                                "type": "date"
                            },
                            {
                                "value": true,
                                "type": "bool"
                            },
                            {
                                "value": "test",
                                "type": "bytes"
                            }
                        ],
                        "sliceRecordCount": 10000
                    }
                },
                "writer": {
                    "name": "mysqlwriter",
                    "parameter": {
                        "username": "db_user",
                        "password": "db_password",
                        "column": [
                            "runoob_id",
                            "runoob_title",
			    "runoob_author",
			    "submission_date",
			    "runoob"
                        ],
                        "preSql": [
                        ],
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://127.0.0.1:3306/test1",
                                "table": [
                                    "table1"
                                ]
                            }
                        ]
                    }
                }
            }
        ]
    }
}
```

### 截图

<a href="https://imgchr.com/i/iDQw34"><img src="https://s1.ax1x.com/2018/10/22/iDQw34.png" alt="iDQw34.png" border="0" /></a>





## postgres插入数据



### 写入表字段

```
 CREATE TABLE test_bak(
   runoob_id  VARCHAR(100) NOT NULL,
   runoob_title           VARCHAR(100)    NOT NULL,
   runoob_author            VARCHAR(100)     NOT NULL,
   submission_date        CHAR(50) NOT NULL ,
   runoob    VARCHAR(40)     NOT NULL
);
```



### json参考格式

```
{
    "job": {
        "setting": {
            "speed": {
                "channel": 1
            }
        },
        "content": [
            {
                 "reader": {
                    "name": "streamreader",
                    "parameter": {
                        "column" : [
                            {
                                "value": "DataX",
                                "type": "string"
                            },
                            {
                                "value": 19880808,
                                "type": "long"
                            },
                            {
                                "value": "1988-08-08 08:08:08",
                                "type": "date"
                            },
                            {
                                "value": true,
                                "type": "bool"
                            },
                            {
                                "value": "test",
                                "type": "bytes"
                            }
                        ],
                        "sliceRecordCount": 1000
                    }
                },
                "writer": {
                    "name": "postgresqlwriter",
                    "parameter": {
                        "username": "db_user",
                        "password": "db_password",
                        "column": [
                            "runoob_id",
                            "runoob_title",
			    "runoob_author",
			    "submission_date",
			    "runoob"
                        ],
                        "preSql": [
                        ],
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:postgresql://ip:port/test1",
                                "table": [
                                    "test_bak"
                                ]
                            }
                        ]
                    }
                }
            }
        ]
    }
}
```

## postgres导入到mysql

```
{
    "job": {
        "setting": {
            "speed": {
                 "byte": 1048576
            },
                "errorLimit": {
                "record": 0,
                "percentage": 0.02
            }
        },
        "content": [
            {
                "reader": {
                    "name": "postgresqlreader",
                    "parameter": {
                        "username": "db_user",
                        "password": "db_password",
                        "column": [
				            "runoob_id",
                            "runoob_title",
                            "runoob_author",
                            "submission_date",
                            "runoob"
                        ],
                        "connection": [
                            {
                                "table": [
                                    "test_bak"
                                ],
                                "jdbcUrl": [
     "jdbc:postgresql://ip:5432/test1"
                                ]
                            }
                        ]
                    }
                },
			                "writer": {
                    "name": "mysqlwriter",
                    "parameter": {
                        "column": [
                            "*"
                        ],
                        "connection": [
                            {
                                "jdbcUrl": "jdbc:mysql://127.0.0.1:3306/test1",
                                "table": ["table1"]
                            }
                        ],
                        "password": "db_password",
                        "preSql": [],
                        "session": [],
                        "username": "db_user",
                        "writeMode": "insert"
                    }
                }
            }
        ]
}
    }
```

