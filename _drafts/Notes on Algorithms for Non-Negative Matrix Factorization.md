---
layout: post
title: Note on Algorithm for Non-Negative Matrix Factorization
author: Binxu Wang
date: May 18th, 2019
comments: true
use_math: true
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Applied Math, Linear Algebra, Numerical Method]

---

[TOC]

# Problem Setting 





# Algorithm 

For this problem, the basic idea is that when we focus on part of variables `H` or `W` the problem becomes a linearly constraint convex sub-problem, (even with some regularization term it's still a convex problem,) thus could be solved unanimously with matured method. But the alternating between `H` and `W` makes the problem non-convex. 

Because of this many algorithms has `Alternative` in its name. 

One algorithm that really interests us is `hals`, i.e. Hierarchical Alternative Least Square Algorithm. 

## Hierarchical Alternative Least Square Algorithm

Here I'll state the structure of HALS algorithm. 





# Reference

Reference for Implementation is this [repo](<https://github.com/kimjingu/nonnegfac-matlab>). 