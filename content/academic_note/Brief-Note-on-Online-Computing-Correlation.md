---
layout: post
title: Brief Note on Online Correlation Computation
author: Binxu Wang
date: May 22th, 2020
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Statistics]

---

* TOC
{:toc}


## Motivation

Sometimes the matrix (samples) to be correlated is too large, then you need to compute the correlation when the data is pouring in, i.e. online computing correlation. 

## Method

Correlation between 2 random variables or vectors $X,Y$ are defined as 
$$
\rho = \frac{(X-\bar X)\cdot (Y-\bar Y)}{\sqrt{(X-\bar X)\cdot (X-\bar X)}\sqrt{(Y-\bar Y)\cdot (Y-\bar Y)}}\\=\frac{E(X-\bar X)\cdot (Y-\bar Y)}{\sigma_X\sigma_Y}\\
$$
This formula is not suited for online calculation of correlation. Using the component representation
$$
\rho =\frac{\frac 1n \sum_iX_i Y_i - \bar X\bar Y}{\sqrt{\frac 1n \sum X_i^2-\bar X^2}\sqrt{\frac 1n \sum Y_i^2-\bar Y^2}}
$$
Note in this formula, the samples or trials are independent to each other, and update could be efficient. The stats we want to maintain through out this is 

* $\sum_i X_i Y_i$ 
* $\sum_i X_i, \sum_i Y_i$
* $\sum_i X_i^2, \sum_i Y_i^2$ 
* Sample number $n$

 Then we can use this to compute correlation real time. 

Potential usage includes using it real time to update correlation coefficients among channels or brain areas or between brain and *in silico* networks through out experiments. 



