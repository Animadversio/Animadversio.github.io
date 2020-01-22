---
layout: post
title: Note on Hessian Aware Zeroth Order Optimization Framework
author: Binxu Wang
date: Jan. 21th, 2020
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Optimization, Adversarial Example]
---

Motivation
---

[Major Reference ](https://arxiv.org/abs/1812.11377)

Zeroth order optimization, or derivative free optimization is also known as **the oracle problem**. It's nothing new to optimization community. 

Interest in ZOO algorithm resurges partly because it could be used in black box adversarial attack, if the softmax probability is given; and it could also be used in optimization of experimental output; and it could also be used for many design problem as the result has a non-analytical relationship with the parameters. 

> When we give up analytical gradients, there are so many things we could do! 

## Background

To give Zeroth Order Optimization a theoretical foundation, people want to map the constructs into normal gradient based optimization. 

For an optimization problem 
$$
\arg\max_xf(x)
$$
For normal optimizations, we have gradients and Hessian
$$
g(x)=\nabla f(x)\\
H(x)=\nabla^2f(x)=\nabla g(x)
$$


The classical Newtonian step is 
$$
x_{t+1}=x_t-\eta H(x)^{-1}g(x)
$$
As Hessian computation is expensive even in the differentiable case, people use proxy / estimates for Hessian $\tilde H$ instead of real Hessian. So here comes the quasi-newtonian methods. For an elegant example of quasi-newton method, please see [Note on LBFGS method](Note-on-LBFGS.md). And the common optimizer ADAM, ADAGRAD, ADADELTA can be viewed as quasi-newtonian methods as well. 


Obviously, Hessian is not a construct that is directly available from 0th order information, so we have to estimate it in some way. 

