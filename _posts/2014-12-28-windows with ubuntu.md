---
layout:  post
title:   "windows with ubuntu"
description:   "happy wife, happy life ..."
keywords:   win,os,ubuntu
category:   Note
tags:   [win,os,ubuntu] 
---


{% include JB/setup %}
###ubuntu-kylin安装

应肥妞要求，记录一下安装ubuntu-kylin的过程，这里先mark一下，留空在继续写。。。。哈哈哈

测试一下自带截图工具，结合markdown编辑器，感觉可以脱离windows进行happy的学习和研究啦啦。。。


![](http://needpp.qiniudn.com/2014/12/28/0667297a-8e61-11e4-a385-f23c9156bf7b.png)



嚯嚯嚯。。。。搜狗输入法很给力。。。。

###工具准备
- [ubuntu-kylin ](http://pan.baidu.com/s/1c09zUt6)
- [easy-bcd绿色版](http://pan.baidu.com/s/1gdgT811)
- [ultraiso](http://pan.baidu.com/s/1c01YxGG)
- 4g u盘（提前做好文件备份）

###window准备
如果直接安装在裸机上，不用windows与Ubuntu共存，这个可以不看，如果想单独安装Ubuntu到硬盘上面而不是在windwos文件系统中虚拟出的一块磁盘的话，我们有必要建立一个新的分区来进行Ubuntu的安装。

进入到磁盘管理（计算机-右键-管理-磁盘管理）

![](http://needpp.qiniudn.com/2014/12/28/0fdbc9ac-8e61-11e4-a385-f23c9156bf7b.png)

选择一个磁盘空间比较大的磁盘，右键-压缩卷 ，然后等待一会会提示可以压缩的空间，然后你就可以再这里选择新建的卷的大小，也就是你想安装Ubuntu系统的大小。随便玩玩体验下Ubuntu的话设置个30g足以。

###制作启动U盘
将下载好的操作系统镜像iso文件导入到utraliso这个软件中，这里以Ubuntu12.04.iso为例。其余类同。

![](http://needpp.qiniudn.com/2014/12/28/1c782142-8e61-11e4-a385-f23c9156bf7b.png)


然后插入U盘，`切记要备份文件`，这里制作需要进行格式化操作。

开始进行镜像写入，点击 启动---写入硬盘镜像

![](http://needpp.qiniudn.com/2014/12/28/11b8d0da-8e61-11e4-a385-f23c9156bf7b.png)

接下来就可以进行镜像的写入


![](http://needpp.qiniudn.com/2014/12/28/158aadb4-8e61-11e4-a385-f23c9156bf7b.png)


等待几分钟，就完成了启动U盘的制作。

###设置bios
如果需要从U盘启动进行系统安装的话，需要在bios里面进行设置，从而实现从U盘引导进入到系统。
不同的主板有不同的设置方式，一般开机会闪现提示如何进入bios。
可以尝试按下`delete`键进入设置。
进入到bios后 选择高级BIOS设置Advanced BIOS Features，并且选择U盘为第一启动项。然后按下`F10` 退出并且保存。系统则会从U盘进行引导。

另外一种方式可以选择开机按下`F12` 然后可以选择从哪里进行启动，而可以不用进行之前的步骤。具体看主板是否支持。建议可以优先尝试这种方式。

更加具体的bios操作步骤可以点击[这里](http://jingyan.baidu.com/article/295430f10f4acb0c7e00501b.html)。



###安装系统
这里没有截图，可以查看[这里](http://jingyan.baidu.com/article/76a7e409bea83efc3b6e1507.html) 需要注意的是，重启进入安装系统的时候，选择`其他`选项，这样才可以自己分区，选择刚刚在windows下新分出来的逻辑分区。

![](http://needpp.qiniudn.com/2014/12/28/185d8a02-8e61-11e4-a385-f23c9156bf7b.png)

接下来就是区分，点击那个`+`
- 设置swap大小 和物理内存一致就ok    选择swap
- 设置boot引导 一般200m就可以 挂载点选择 /boot
- 设置`/` 类似于c盘 设置10g差不多    选择/
- 接下来就是挂载/home 目录 剩下的都给他吧   选择/home

尤其需要注意的是，也是唯一需要注意的地方
`安装启动器引导的位置 一定要选择你安装boot的那个分区。`

![](http://needpp.qiniudn.com/2014/12/28/122ecd1c-8e61-11e4-a385-f23c9156bf7b.png)


接下来就可以安装了。。。。。

###等等，还没有完
刚刚的操作只是将系统安装到了硬盘，但是我们的window却不知道它的引导在哪里，所以我们需要到window配置一个入口 也就是Ubuntu的引导，谁让我们通过windo的门进行Ubuntu的引导呢？呵呵

在window安装一个easybcd

![](http://needpp.qiniudn.com/2014/12/28/10fcc8a4-8e61-11e4-a385-f23c9156bf7b.png)

选择你安装boot的那个分区序号，就是大概200m左右的。
然后点击添加，它反应有点慢 点击一下等待1s就可以。不要重复，不然到时候会多出很多的引导。
ok现在启动电脑就可以看到有ubun-ddp的选项了  就可以进入了。。。完成。。。




###什么？上面的太复杂了？
那好吧，有个简单的安装方法，可以在win下分出一块30g的虚拟磁盘出来用来存放Ubuntu，简直就是一键安装。。。不过我只有实验了Ubuntu12.04 ，也就是通过wubi的安装方式进行的，但是ubun-kylin没有成功过。貌似不支持了吧。。。

在磁盘根目录建立有个文件夹，把镜像放进去。然后镜像文件里面有个wubi.exe 的文件，把他解压出来和镜像放在同一个文件下面。如下图

![](http://needpp.qiniudn.com/2014/12/28/130b94fe-8e61-11e4-a385-f23c9156bf7b.png)


然后双击exe就可以了。选择你要安装到的逻辑分区比如DEF盘，然后填写密码就可以了。。。

![](http://needpp.qiniudn.com/2014/12/28/150e85cc-8e61-11e4-a385-f23c9156bf7b.png)


。。。over。。。。。



