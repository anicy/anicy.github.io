---
layout:  post
title:   "Ubuntu 使用nginx部署flask应用"
description:   "happy wife, happy life ..."
keywords:   flask,nginx,ubuntu
category:   Study
tags:   [flask,nginx,ubuntu] 
---


{% include JB/setup %}


之前博客部署到新浪，因为没有备案需要进行海外中转。速度慢，还经常宕机。。。现金迁移至linode。

###准备

```
sudo apt-get install python-setuptools
sudo easy_install pip
sudo pip install virtualenv
sudo apt-get install build-essential python python-dev
# install nginx
sudo apt-get install nginx
Nginx是一个提供静态文件访问的web服务，然而，它不能直接执行托管Python应用程序，而uWSGI解决了这个问题。让我们先安装uWSGI，稍候再配置Nginx和uWSGI之间的交互。
sudo pip install uwsgi
```
<!--more-->
###示例代码

```
构建站点文件，或者在其他目录下建立目录，然后添加符号链接到www下亦可
sudo mkdir /var/www/mysite
或者 sudo ln -s /home/scut1/mysite  /var/www/mysite

创建完成之后将文件所有者改为非root用户
chown -R scut1:scut1 /home/scut1/mysite
```

创建并激活一个虚拟环境，在其中安装Flask：

```
cd /var/www/mysite
virtualenv venv
. venv/bin/activate
pip install flask
```
使用下面的代码创建hello.py文件：

```
from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
```

然后使用 `python hello.py` 就可以启动应用，通过http://localhost:8080 进行访问。如果不想带个端口做个尾巴 需要使用nginx进行端口转发

###配置nginx
首先删除掉Nginx的默认配置文件：
`sudo rm /etc/nginx/sites-enabled/default`

创建一个我们应用使用的新配置文件 `/var/www/mysite/mysite_nginx.conf`

```
server {
    listen      80;
    server_name localhost;   ###可以换成自己的域名，只要解析到这台主机的ip即可
    charset     utf-8;
    client_max_body_size 75M;

    location / { try_files $uri @yourapplication; }
    location @yourapplication {
        include uwsgi_params;
        uwsgi_pass unix:/var/www/mysite/mysite_uwsgi.sock;
    }
}
```

将刚建立的配置文件使用符号链接到Nginx配置文件文件夹中，重启Nginx：

```
sudo ln -s /var/www/mysitemysite_nginx.conf /etc/nginx/conf.d/
sudo /etc/init.d/nginx restart
```

###配置uwsgi
遇到502 Bad GateWay这是正常的，因为没有配置nginx与uwsgi之间的通信。
创建一个新的uWSGI配置文件/var/www/mysite/mysite_uwsgi.ini：

```
[uwsgi]
#application's base folder
base = /var/www/mysite

#python module to import
app = hello
module = %(app)

home = %(base)/venv
pythonpath = %(base)

#socket file's location
socket = /var/www/mysite/%n.sock

#permissions for the socket file
chmod-socket    = 666

#the variable that holds a flask application inside the module imported at line #6
callable = app

#location of log files
logto = /var/log/uwsgi/%n.log

```
创建一个新文件夹存放uWSGI日志，更改文件夹的所有权：

```
sudo mkdir -p /var/log/uwsgi
sudo chown -R scut1:scut1 /var/log/uwsgi
```

###完成
至此，配置完成，可以使用下面命令进行访问。
`uwsgi --ini /var/www/mysite/mysite_uwsgi.ini`
接下来访问你的服务器，现在Nginx可以连接到uWSGI进程了.

###wait....
等等，我们发现使用终端进行启动之后不能关闭，因为这样服务就停止了，那怎么办？
后台挂起即可后面的`&`不能少,原因自行查阅。

```
nohup uwsgi --ini /var/www/mysite/mysite_uwsgi.ini &
```

###遇到问题
在配置个人博客中遇到关于mysqldb无法引入的问题，但是在外部环境中python-mysql模块是正常安装的。查阅日志发现在使用virtualenv建立的隔离环境中没有该模块，重新安装即可。

```
sorry , i forgot it
```

###参考
http://www.oschina.net/translate/serving-flask-with-nginx-on-ubuntu?cmp
