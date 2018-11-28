# Source code

https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner

![](http://lijinghua-img.oss-cn-beijing.aliyuncs.com/blog/sonarqube-scanner.png)

# Download and Decompress

```
root@mysql:/opt# wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
root@mysql:~# unzip sonar-scanner-cli-3.2.0.1227-linux.zip -d /usr/local/
root@mysql:~# mv /usr/local/sonar-scanner-3.2.0.1227-linux /usr/local/sonar-scanner-3.2.0
```

# Environment Variable

```
root@mysql:~# vim /etc/profile
···
#set  sonar-scanner-cli

export SONAR_SCANNER_HOME=/usr/local/sonar-scanner-3.2.0
export PATH=${SONAR_SCANNER_HOME}/bin:${PATH}

···
```

```
root@mysql:~# source /etc/profile
```

# Test

```
root@mysql:~# sonar-scanner -h
INFO:
INFO: usage: sonar-scanner [options]
INFO:
INFO: Options:
INFO:  -D,--define <arg>     Define property
INFO:  -h,--help             Display help information
INFO:  -v,--version          Display version information
INFO:  -X,--debug            Produce execution debug output
```













