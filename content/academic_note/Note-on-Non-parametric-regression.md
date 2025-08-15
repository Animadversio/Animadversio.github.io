---
layout: post
title: Note on Non-Parametric Regression
author: Binxu Wang
date: 2020-10-13
# use_math: true
math: true
comments: true
categories: [mathematics, algorithm, machine learning]
tags: [tech note, Math, Statistics, Statistical Learning, ML]
typora-copy-images-to: ..\assets\img\notes\gp

---

# Problem Statement

Given a bunch of noisy data, you want a smooth curve going through the cloud. As the points are noisy, there is no need to going through each point. 

This is a little bit different from Interpolation in that, interpolation usually assumes your data is sparse, and is noise-small. So you can interpolate and get a degenerated version of it. 

For Regression problem, sometimes, you are data dense, and the data is full of noise thus doing interpolation will give you overly noisy data. However you can smooth the data by some estimation. 

## Kernel Regression

Kernel regression (see [notes]({{< relref "Note-on-Kernel-Ridge-Regression.md" >}})) can be thought of as an extension of nearest neighbor interpolation. 

> The value probed $f(\hat x)$ is the weighted average value of the data samples around it. $f(\hat x)={\sum_i w(x_i,\hat x)y_i /\sum_i w(x_i,\hat x)}$ 

Comparison:

* Bilinear interpolation can be thought of in this camp.
* Kernel Density Estimation, it's estimate the density without the y label! so more in the realm of unsupervised learning. 



## Gaussian Process Regression

Gaussian process (see [notes]({{< relref "Note-on-Gaussian-Process.md" >}})) is to model data by a gaussian distribution in the space of functions. For regression problem.

