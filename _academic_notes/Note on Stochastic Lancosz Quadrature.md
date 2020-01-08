---
layout: post
title: Stochastic Lancosz Quadrature
author: Binxu Wang
date: Jan 9th, 2020
use_math: true
comments: true
published: false
categories: [mathematics, algorithm]
tags: [tech note, Linear Algebra, Math, Numerical Algebra, Numerical Analysis, Monte Carlo, Algorithm, Matrix Computation]
---

# Note on Stochastic Lancosz Quadrature



## Motivation

We want to find the trace of a analytical function of a matrix $tr(f(M))$. If the matrix is huge, and is implicitly represented i.e. can only be used as a operator and cannot be stored in memory at once, then a classic clever method to solve this problem is Stochastic Lancosz Quadrature. 

This computational problem sounds bezarre, but there are quite a few interesting application of this, including estimate spectrum of a huge implicit matrix, e.g. hessian matrix during some high dimensional optimization. 

I'll try to articulate the algorithm according to this recent article[^0]. 





[^0]: [FAST ESTIMATION OF tr(f(A)) VIA STOCHASTIC LANCZOS QUADRATURE](https://epubs.siam.org/doi/10.1137/16M1104974)



