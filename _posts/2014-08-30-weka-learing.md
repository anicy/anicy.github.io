---
layout: post
title: "Weka快速入门v1.0"
description: "weka提供的功能有数据预处理、特征选择、分类、回归、聚类、关联规则、可视化等，本文旨在记录学习过程遇到的知识点以及使用方法，备忘用。"
keywords: weka,machine learning,ml,tools,data mining
category: data mining 
tags: [weka,machine learning,ml,tools,data mining]
---



weka提供的功能有数据预处理、特征选择、分类、回归、聚类、关联规则、可视化等，本文旨在记录学习过程遇到的知识点以及使用方法，备忘用。

####weka内置数据格式
Weka存储数据的格式是ARFF(Attribute-Relation File Format)文件,是一种ASCII文本文件。如下例，weka自带的weather.arff文件。具体参照[这里](http://blog.csdn.net/buaalei/article/details/7103055)。


<!-- more -->




```

@relation weather

@attribute outlook {sunny, overcast, rainy}
@attribute temperature numeric
@attribute humidity numeric
@attribute windy {TRUE, FALSE}
@attribute play {yes, no}

@data
sunny,85,85,FALSE,no
sunny,80,90,TRUE,no
overcast,83,86,FALSE,yes
rainy,70,96,FALSE,yes
rainy,68,80,FALSE,yes
rainy,65,70,TRUE,no
overcast,64,65,TRUE,yes
sunny,72,95,FALSE,no
sunny,69,70,FALSE,yes
rainy,75,80,FALSE,yes
sunny,75,70,TRUE,yes
overcast,72,90,TRUE,yes
overcast,81,75,FALSE,yes
rainy,71,91,TRUE,no

```


####数据预处理
数据预处理包括数据的缺失值处理、标准化、规范化和离散化处理。

**数据的缺失值处理：** weka.filters.unsupervised.attribute.ReplaceMissingValues。
对于数值属性，用平均值代替缺失值，对于nominal属性，用它的mode(出现最多的值)来代替缺失值。

**标准化(standardize)：**类weka.filters.unsupervised.attribute.Standardize。标准化给定数据集中所有数值属性的值到一个0均值和单位方差的正态分布。 

**规范化(Nomalize):** 类weka.filters.unsupervised.attribute.Normalize。规范化给定数据集中的所有数值属性值，类属性除外。结果值默认在区间[0,1]，但是利用缩放和平移参数，我们能将数值属性值规范到任何区间。如：但scale=2.0，translation=-1.0时，你能将属性值规范到区间[-1,+1]。

**离散化(discretize):** 类weka.filters.supervised.attribute.Discretize和weka.filters.unsupervised.attribute.Discretize。分别进行监督和无监督的数值属性的离散化，用来离散数据集中的一些数值属性到分类属性。     




>归一化：一种简化计算的方式，将有量纲的表达式，经过变换，化为无量纲的表达式，成为纯量，避免具有不同物理意义和量纲的输入变量不能平等使用。在统计学中，归一化的具体作用是归纳统一样本的统计分布性。归一化在0-1之间是统计的概率分布，归一化在-1--+1之间是统计的坐标分布。这里需要注意的是归一化需要对训练集和测试集进行归一化，而不是仅仅对训练集进行归一化，如果数据是慢慢加入的，加入一部分就更新一次很浪费时间也很没必要，可以记录下当前数据集的最大值和最小值进行处理，最后能不用归一化的时候尽量不要用。
标准化：数据的标准化是将数据按比例缩放，使之落入一个小的特定区间
正则化：在求解最优化问题中，调节拟合程度的，参数一般称为正则项，越大表明欠拟合，越小表明过拟合，推荐中主要用在矩阵分解中。??????????????
区别呢？

####分类应用
在weka内进行 **数据预处理，训练，验证** 这三个步骤进行，分类、聚类、关联等操作均可以按照这个流程。 
1. 数据预处理：数据预处理包括特征选择，特征值处理（比如归一化），样本选择等操作。 
2. 训练：训练包括算法选择，参数调整，模型训练。 
3. 验证：对模型结果进行验证。

预处理页面

![pic]({{ site.qiniudn }}/images/1.jpg)

详细说明

Filters可分为两大类，supervised(监督、管理)和unsupervised。supervised下的方法需要类别标签，而unsupervised则不需要。attribute类别表示对特征做筛选，instance表示对样本做选择。

![pic]({{ site.qiniudn }}/images/2.jpg)

选择训练算法&验证

![pic]({{ site.qiniudn }}/images/3.jpg)

查看相关评估结果

![pic]({{ site.qiniudn }}/images/4.jpg)

可视化

![pic]({{ site.qiniudn }}/images/5.jpg)

####关联分析
按照同样的流程进行处理，不同的是在结果中可以生成关联规则。注意的是其中算法属性的设置。
算法属性设置：


>1.car：如果设为真，则会挖掘**类关联规则**而不是全局关联规则。
2.classindex： 类属性索引。如果设置为-1，最后的属性被当做类属性。
3.delta： 以此数值为迭代递减单位。不断减小支持度直至达到最小支持度或产生了满足数量要求的规则。
4.lowerBoundMinSupport： 最小支持度下界。
5.metricType： 度量类型，设置对规则进行排序的度量依据。可以是：置信度（类关联规则只能用置信度挖掘），提升度(lift)，杠杆率(leverage)，确信度(conviction)。
在 Weka中设置了几个类似置信度(confidence)的度量来衡量规则的关联程度，它们分别是：
a)Lift ： P(A,B)/(P(A)P(B)) Lift=1时表示A和B独立。这个数越大(>1)，越表明A和B存在于一个购物篮中不是偶然现象,有较强的关联度.
b)Leverage :P(A,B)-P(A)P(B)
Leverage=0时A和B独立，Leverage越大A和B的关系越密切
c) Conviction:P(A)P(!B)/P(A,!B) （!B表示B没有发生） Conviction也是用来衡量A和B的独立性。从它和lift的关系（对B取反，代入Lift公式后求倒数）可以看出，这个值越大, A、B越关联。
6.minMtric ：度量的最小值。
7.numRules： 要发现的规则数。
8.outputItemSets： 如果设置为真，会在结果中输出项集。
9.removeAllMissingCols： 移除全部为缺省值的列。
10.significanceLevel ：重要程度。重要性测试（仅用于置信度）。
11.upperBoundMinSupport： 最小支持度上界。 从这个值开始迭代减小最小支持度。
12.verbose： 如果设置为真，则算法会以冗余模式运行。

如图所示，具体参数可以点击more查看

![pic]({{ site.qiniudn }}/images/6.jpg)

运行结果如图所示


![pic]({{ site.qiniudn }}/images/7.jpg)


###*more to be continue~~~*


####参考资料
- [初试weka数据挖掘](http://www.cnblogs.com/hxsyl/p/3307343.html)
- [weka数据预处理](http://blog.csdn.net/hunauchenym/article/details/5847314)
- [weka内置数据类型arff](http://blog.csdn.net/buaalei/article/details/7103055)
- [weka-关联规则挖掘](http://blog.csdn.net/buaalei/article/details/7103424)
