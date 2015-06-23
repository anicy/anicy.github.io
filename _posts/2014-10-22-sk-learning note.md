---
title: sk-learning note
description happy wife, happy life ...
keywords: ml,tools
category: Study
tags: ml,tools
---


{% include JB/setup %}


####简介
scikit learning 是一个python的[机器学习](http://dcycome.vicp.net/categories.html#ml-ref)库,内置许多机器学习的算法诸如svm、随机森林、逻辑回归、贝叶斯网络等算法。覆盖了分类、聚类、回归、降维处理、模型选择等诸多方面的内容。具体介绍可以参见[官网](http://scikit-learn.org/stable/index.html),也可以fork源代码进行学习，或者成为contributer，fork地址在[这里](https://github.com/scikit-learn/scikit-learn)。

####加载数据集
在使用sk-learing进行机器学习时，我们需要先将数据加载到内存中，sk使用的是python写的，对于数据的读写具体的操作语言可以参看相关文档[python快速指南](#)，下面简单记录sk中读入数据的过程。
```python
#这是使用内置的数据集 机器学习中很经典的一个紫苑花数据集
>>> from sklearn import datasets
>>> iris = datasets.load_iris()
>>> digits = datasets.load_digits()

>>> print(digits.data)  
[[  0.   0.   5. ...,   0.   0.   0.]
 [  0.   0.   0. ...,  10.   0.   0.]
 [  0.   0.   0. ...,  16.   9.   0.]
 ...,
 [  0.   0.   1. ...,   6.   0.   0.]
 [  0.   0.   2. ...,  12.   0.   0.]
 [  0.   0.  10. ...,  12.   1.   0.]]
```
总之，就是把数据组织成二维表的形式，每行对应一个样本（也可以说是一条记录，对于这点，从计算机科学与统计学的角度来讲都是相当的），因为计算机科班出生所以还是习惯用记录这样的说法来描述一个样本（也是一个实例），在这样一个数据表中由很多不同的记录（实例）组成，而每个实例由很多属性（字段）构成，机器学习算法所完成的工作就是根据多个样本的这些属性（字段）的学习（不同算法有不同的策略），来达成一个特定的目标。（分类、回归。。。）
<!--more-->
####训练与预测
sk中，数据预处理、训练、预测、模型评估检测都实现了模块化，按照这个步骤我们可以非常方便的实现一个试验。然后这里面比较重要的一点就是对于模型的参数选择问题，还在初学尚且不能给出相关参考，以免误导他人。

-  构建模型
```python
# this is a demo ,and u can change the model for u self
>>> from sklearn import svm
>>> clf = svm.SVC(gamma=0.001, C=100.)
```

-  参数选择(以后补充)

 -----------------------------------------华丽的分割线-------------------------------------

-  训练模型
这里使用的内置的数据集合，使用支持向量机(svm)对其进行fit，拟合类似训练的意思，就是找到一个合适的“函数”来尽可能的满足训练集中的这些样本，然后通过这个“函数”来对未知的数据进行预测。其中的“尽可能”实际上是一个度量指标，比如均方差、欧式距离etc。。。什么？ 连均方差都忘了？！赶紧问下度娘。。。
表达的还是不是很清楚，建议参照 @Andrew NG [机器学习课程](https://www.coursera.org/course/ml)来理解。
```python
#bulid a classfier as clf ,it represent the model we want to build
# and then we train the clf use these data in order to caculate these paramater in the model
>>> clf.fit(digits.data[:-1], digits.target[:-1])  
SVC(C=100.0, cache_size=200, class_weight=None, coef0=0.0, degree=3,
  gamma=0.001, kernel='rbf', max_iter=-1, probability=False,
  random_state=None, shrinking=True, tol=0.001, verbose=False)
```

- 模型预测
```python 
# so easy ,just like this below
>>> clf.predict(digits.data[-1])
```

- 模型持久化
针对数据量很大的集合训练，我们可以把modle保存起来，类似于一种数据持久化的技术。
```python
>>> from sklearn import svm
>>> from sklearn import datasets
>>> clf = svm.SVC()
>>> iris = datasets.load_iris()
>>> X, y = iris.data, iris.target
>>> clf.fit(X, y)  
SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0, degree=3, gamma=0.0,
  kernel='rbf', max_iter=-1, probability=False, random_state=None,
  shrinking=True, tol=0.001, verbose=False)
#
#
# now we will save the model 
>>> import pickle
>>> s = pickle.dumps(clf)
>>> clf2 = pickle.loads(s)
>>> clf2.predict(X[0])
array([0])
>>> y[0]
0
#
#下次可以这样直接使用训练好的模型   
>>> clf = joblib.load('filename.pkl') 
```
####sklearing 训练评估
针对kdd99数据集使用逻辑回归分类训练 然后进行评估  发觉分数有点高的离谱 取出10%数据494021条，并从中选择四分之一作为测试集 结果这么高 是否过拟合了？


```python
import numpy as np
from sklearn import linear_model
from sklearn.externals import joblib
from sklearn import cross_validation
print("data loading ....")
data=np.loadtxt("newfile.csv",delimiter=",",dtype=np.int32)
print("load done....")

X=data[:,:-1]
target=data[:,-1]

X_train,X_test,y_train,y_test=cross_validation.train_test_split(X,target,test_size=0.25,random_state=1)

print("begin fit the model....")
clf=linear_model.LogisticRegression(penalty='l2', dual=False, tol=0.0001, C=1.0, fit_intercept=True, intercept_scaling=1, class_weight=None, random_state=None)
score=clf.fit(X_train,y_train).score(X_test,y_test)

print("the model have train success, we will save the model to file...")
#s=pickle.dumps(clf)
joblib.dump(clf, 'model.pkl')
#score 
print(score)

# result output....
data loading ....
load done....
begin fit the model....
dd
the model have train success, we will save the model to file...
0.997449516623

```

####十则交叉验证

```python
>>> from sklearn import cross_validation
>>> X = np.array([[1, 2], [3, 4], [1, 2], [3, 4]])
>>> y = np.array([1, 2, 3, 4])
>>> kf = cross_validation.KFold(4, n_folds=2)
>>> len(kf)
2
>>> print(kf)  
sklearn.cross_validation.KFold(n=4, n_folds=2, shuffle=False,
                               random_state=None)
>>> for train_index, test_index in kf:
...    print("TRAIN:", train_index, "TEST:", test_index)
...    X_train, X_test = X[train_index], X[test_index]
...    y_train, y_test = y[train_index], y[test_index]
TRAIN: [2 3] TEST: [0 1]
TRAIN: [0 1] TEST: [2 3]
.. automethod:: __init__
```




####参考
 [1] https://github.com/scikit-learn/scikit-learn
 [2] http://scikit-learn.org/stable/tutorial/basic/tutorial.html
 [3] http://dcycome.vicp.net/linux/2014-08/markdown-sys.html
 

























