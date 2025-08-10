---
layout: post
title: Krylov Subspace, Conjugate Gradient and Lancosz Iteration
author: Binxu Wang
date: 2020-01-01
# use_math: true
math: true
comments: true
categories: [mathematics, algorithm]
tags: [tech note, Linear Algebra, Math, Numerical Algebra, Algorithm, Optimization]
---

# Krylov Subspace, Lancosz Iteration, QR and Conjugate Gradient 



## Motivation

In practise, many numerical algorithms include iteratively multiply a matrix, like power method and QR algorithm. 

All these algorithms have their core connected to a single construct, Krylov subspace and a operation, Lancosz Iteration. So this note motivates to understand this core. 



### Some properties of eigenvalue 

Given $A\in\C^{n\times n}$ , it has eigen pairs $(\lambda_i,x_i)$. 

we know the transform to the spectra if we transform the matrix in following ways.[^1] 

* For polynomial transform $p(.)$, the eigen pairs of $p(A)$ are $(p(\lambda_i),x_i)$. 
* For rational transform $p(.)/q(.)$ the eigen pairs of $q(A)^{-1}p(A)$ are $(p(\lambda_i)/q(\lambda_i),x_i)$
* For spectra shifting, $(A-\mu I)^{-1}$ has eigen pairs $(1/(\lambda_i-\mu),x_i)$ . 

## Reference 

* [Krylov subspace method for eigenvalue problem](https://cseweb.ucsd.edu/classes/fa04/cse252c/sakumar.pdf) 
* [Krylov subspace method for large linear system](http://www.sam.math.ethz.ch/~mhg/pub/biksm.pdf)

[^1]: [Krylov subspace method for eigenvalue problem](https://cseweb.ucsd.edu/classes/fa04/cse252c/sakumar.pdf)