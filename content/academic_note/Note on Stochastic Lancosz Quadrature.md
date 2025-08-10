---
layout: post
title: Stochastic Lancosz Quadrature
author: Binxu Wang
date: 2020-01-09
# use_math: true
math: true
comments: true
# published: false
draft: true
categories: [mathematics, algorithm]
tags: [tech note, Linear Algebra, Math, Numerical Algebra, Numerical Analysis, Monte Carlo, Algorithm, Matrix Computation]
---

# Note on Stochastic Lancosz Quadrature



## Motivation

We want to find the trace of a analytical function of a matrix $tr(f(M))$. If the matrix is huge, and is implicitly represented i.e. can only be used as a operator and cannot be stored in memory at once, then a classic clever method to solve this problem is Stochastic Lancosz Quadrature. 

This computational problem sounds bezarre, but there are quite a few interesting application of this, including estimate spectrum of a huge implicit matrix, e.g. hessian matrix during some high dimensional optimization. 

I'll try to articulate the algorithm according to this recent article[^0]. 

## Problem Reformulate

The original question is to compute 





### Lanczos Iteration



## Caveats

One of the reason that this algorithm is not as popular as Householder transform is that it has long suffered from issues of numerical stability. 





## Reference Implementation

One python package that implement Stochastic Lanczos Quadrature is [eMaTe](https://github.com/stdogpkg/emate) from StDoG, which use Tensorflow computational machinery. See their [documentation](https://emate.readthedocs.io/en/latest/examples.html#sthocastic-lanczos-quadrature)  . 



[^0]: [FAST ESTIMATION OF tr(f(A)) VIA STOCHASTIC LANCZOS QUADRATURE](https://epubs.siam.org/doi/10.1137/16M1104974)

[^1]: Matrix Computations 4th Ed. Chapter 10. 



