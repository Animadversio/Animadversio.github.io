---
layout: post
title: Note on Bayesian Optimization
author: Binxu Wang
date: 2020-07-01
# use_math: true
math: true
comments: true
categories: [mathematics, algorithm, machine learning]
tags: [tech note, Math, Statistics, Statistical Learning, ML, Optimization]
typora-copy-images-to: ..\assets\img\notes\gp
---

# Note on Bayesian Optimization

Related to [Gaussain Process model]({{< relref "Note-on-Gaussian-Process.md" >}})

## Philosophy 

Bayesian Optimization applies to black box functions and it employs the active learning philosophy. 



## Use Case and Limitation

BO is preferred in such cases

* Objective evaluation is very expensive
* Global Solution is desired
* Low accuracy
* Low dimension

When not to use BO

* High dimensional problem

https://nbviewer.jupyter.org/github/SheffieldML/GPyOpt/blob/devel/manual/GPyOpt_modular_bayesian_optimization.ipynb



## Matlab Package

In matlab bayesian optimization have been well wrapped up in a package. 

```matlab
num = optimizableVariable('n',[1,30],'Type','integer');
dst = optimizableVariable('dst',{'chebychev','euclidean','minkowski'},'Type','categorical');
c = cvpartition(351,'Kfold',5);
fun = @(x)kfoldLoss(fitcknn(X,Y,'CVPartition',c,'NumNeighbors',x.n,...
    'Distance',char(x.dst),'NSMethod','exhaustive'));
results = bayesopt(fun,[num,dst],'Verbose',0,...
    'AcquisitionFunctionName','expected-improvement-plus')
```

## Python Package

https://github.com/fmfn/BayesianOptimization