# apt

```
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install -y oracle-java8-installer
sudo apt install -y oracle-java8-set-default
java -version
```



# yum

```
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm

sudo yum localinstall -y jdk-8u131-linux-x64.rpm
java -version
```

