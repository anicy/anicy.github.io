---
title: tiny and beautify
description happy wife, happy life ...
keywords: tools,command
category: Note
tags: tools,command
---


{% include JB/setup %}

- how to change u mysql pwd
```
mysqladmin -u root  -p password  newpwd
```
- check the port been used
```
netstat -tlnp | grep port
```
- run u command in a background  way with nohup 
```
nohup  you_command  &
```
- settings for export your project to a runnable jar
```
filename `manifest.mf`
Manifest-Version: 1.0
Main-Class: edu.dcy.weka.TaskModel
Class-Path: lib/weka.jar
# here shoud be add a blank line
```
- sed replace
```
sed 's/\//-/g' cheliu.csv > cheliuresult.csv
```
- awk test
```
awk -F ',' '{printf("%d,%s\n",NR,$0)}' cheresult.csv > finresult.csv
```
- python for shell
```python
import subprocess
subprocess.call("jps", shell=True)

##out promote
4418 DataNode
4554 NodeManager
7387 Jps
6235 SqlLine
4860 HRegionServer
4750 HQuorumPeer


```
- start hive with meta db
```
hive --service metastore
```
- sort && uniq
```bash
sort -n test.txt | uniq
```
- add sudoers
```
qxm@ubuntu:~$ sudo chmod +w /etc/sudoers
qxm@ubuntu:~$ sudo vim /etc/sudoers
qxm@ubuntu:~$ chmod -w /etc/sudoers
qxm@ubuntu:~$ sudo chmod -w /etc/sudoers
```
-  JAVA_HOME
```
export JAVA_HOME=/home/spark/soft/jdk8
export CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib:/home/spark/soft/lib
export PATH=$JAVA_HOME/bin:$PATH
```

- spark conf for hadoop yarn
```
export JAVA_HOME=/home/spark/soft/java
export SCALA_HOME=/home/spark/soft/scala
export HADOOP_HOME=/home/spark/soft/hadoop-2.5.2
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_MASTER_IP=spark-desktop
export SPARK_WORKER_MEMORY=1g
```

- del svn 
```
find . -type d -name “.svn”|xargs rm -rf 
```
