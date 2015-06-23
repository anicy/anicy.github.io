---
title: Maven编译hadoop2.5.2
description happy wife, happy life ...
keywords: maven,hadoop
category: Study
tags: maven,hadoop
---


{% include JB/setup %}

###准备工具
- jdk安装配置 （使用orace-jdk 6以上，而不是open-jdk）
- maven配置 `sudo apt-get install maven` ，使用二进制包进行配置更加灵活。
- protobuf的安装
`wget https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz`
备用链接 [百度云]()
解压安装，记得导入这个变量 
```bash
export LD_LIBRARY_PATH=~/protobuf-2.5.0
```
- ant安装 
- 其他软件安装
```
sudo apt-get -y install maven build-essential autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev 
```
- 编译命令
进入到hadoop-src目录进行编译
```
mvn package -Pdist,native -DskipTests -Dtar  
```
耐心等待。。。。
-  完成编译
![](http://needpp.qiniudn.com/2014/12/28/3149d2a8-8e63-11e4-a385-f23c9156bf7b.png)


- ps
如果之前没有安装好这些包，可能会遇到各式各样的问题。。。话说maven的中央仓库的网速也很有关系。。

###参考
- http://www.aboutyun.com/thread-8130-1-1.html
- http://www.aboutyun.com/thread-9245-1-1.html
- http://wiki.apache.org/hadoop/HowToContribute
