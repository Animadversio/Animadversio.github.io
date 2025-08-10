---
layout: post
title: Note on Gaussian Process
author: Binxu Wang
date: 2020-07-01
# use_math: true
math: true
comments: true
categories: [mathematics, algorithm, machine learning]
tags: [tech note, Math, Statistics, Statistical Learning, ML]
typora-copy-images-to: ..\assets\img\notes\gp
---

# Note on Gaussian Process

Gaussian Process can be thought of as a Gaussian distribution in function space (or infinite dimension vector). One of its major usage is to tackle nonlinear regression problem and provide mean estimate and errorbar around it. 

## Motivation

Why this definition is important or has any practical relevance to non-linear regression? 

We can gain intuition by simulating a finite gaussian vector. 

In a 2d gaussian, if we know one variable $x_1$ then the other variable $x_2$ will distribute like a gaussian. We can calculate its mean and variance from the given $x$. 

Similarly, if we set the covariance matrix $\Sigma$ of 5 variables as tri-diagonal matrix, then the 5 variables will distribute much like a chain! Actually this is a probabilistic graph model, or more specifically Markov Chain. If we know some of the 5 variables then the others could be sampled or calculated. 

This could be generalized to other kind of covariance matrix $\Sigma$. As we can see the covariance matrix and the mean fully define the distribution of function in this space. 

The examples above only illustrate the finite case covariance $\Sigma$ matrix. For infinite dimension it's a kernel function $K(x_1,x_2)$ and it's obvious that the tridiagonal matrix is just a realization of certain Gaussian kernel 
$$
K(x_1,x_2)\propto\exp(-{(x_1-x_2)^2\over2\sigma^2})
$$


So it is a non-parametric ($\infty$ parameter) method but it utilizes many parametrized trick. 

https://distill.pub/2019/visual-exploration-gaussian-processes/

## Kernel Design



## Application



### Gaussian Processes Regression





