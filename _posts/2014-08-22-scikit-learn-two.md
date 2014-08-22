---
layout: post
title: "sk-learning学习笔记(2)"
description: "scikit learning 是一个python的[机器学习](http://dcycome.vicp.net/categories.html#ml-ref)库,内置许多机器学习的算法诸如svm、随机森林、逻辑回归、贝叶斯网络等算法。覆盖了分类、聚类、回归、降维处理、模型选择等诸多方面的内容。具体介绍可以参见[官网](http://scikit-learn.org/stable/index.html),也可以fork源代码进行学习，或者成为contributer，fork地址在[这里](https://github.com/scikit-learn/scikit-learn)。"
keywords: ml ,machine learning ,data mining ,python 
category: ml
tags: [ml ,machine learning ,data mining ,python ]
---





####sklearing 训练评估
针对kdd99数据集使用逻辑回归分类训练 然后进行评估  发觉分数有点高的离谱 取出10%数据494021条，
并从中选择四分之一作为测试集 结果这么高 是否过拟合了？

<!-- more -->


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

```


