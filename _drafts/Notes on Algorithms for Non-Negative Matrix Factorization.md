---
layout: post
title: Note on Algorithm for Non-Negative Matrix Factorization
author: Binxu Wang
date: June 25th, 2019
comments: true
use_math: true
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Applied Math, Linear Algebra, Numerical Method]

---

[TOC]

# Problem Setting 

The original problem of non-negative matrix factorization is simple, if the dissimarity $D(A||HW)$between original matrix and reconstructed one is L2 distance than, 
$$
argmin_{H,W} \|A-HW\|_F^2, \\
s.t.\ W\succeq0, H\succeq0
$$
The non-negative constraint applies element-wise. 

If the dissimilarity is quantified by cross-entropy, then it could be written as 
$$
argmin_{H,W} D_{KL}(A||HW), \\
s.t.\ W\succeq0, H\succeq0
$$

## Regularization to promote sparsity and other property

Note to promote sparsity and other desirable property, we can add other regularization terms to objective. 



Note NMF and soft label K-means clustering is mathematically equivalent! 

# Algorithm

For this problem, the basic idea is that when we focus on part of variables `H` or `W` the problem becomes a linearly constraint convex sub-problem, (even with some regularization term it's still a convex problem,) thus could be solved unanimously with matured method. But the alternating between `H` and `W` makes the problem non-convex. 

Because of this many algorithms has `Alternative` in its name. 

## Alternative Least Square



One algorithm that really interests us is Hierarchical Alternative Least Square Algorithm (`hals`). 

## Hierarchical Alternative Least Square Algorithm

Here I'll state the structure of HALS algorithm. 

The core idea is to solve each component to the residue separately, so each subproblem is much simpler, and also local to the component. 



# Reference

Reference for Implementation is this [repo](<https://github.com/kimjingu/nonnegfac-matlab>). And the HALS algorithm is from this paper specifically.

CICHOCKI, A., & PHAN, A.-H. (2009). Fast Local Algorithms for Large Scale Nonnegative Matrix and Tensor Factorizations. IEICE Transactions on Fundamentals of Electronics, Communications and Computer Sciences, E92-A(3), 708–721. https://doi.org/10.1587/transfun.E92.A.708