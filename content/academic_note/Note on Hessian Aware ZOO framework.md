---
layout: post
title: Note on Hessian Aware Zeroth Order Optimization Framework
author: Binxu Wang
date: 2020-01-21
comments: true
# use_math: true
math: true
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
As Hessian computation is expensive even in the differentiable case, and inverting a large matrix is expensive, people use proxy / estimates for Hessian $\tilde H$ instead of real Hessian, for the ease of computation and inversion. So comes the quasi-newtonian methods. For an elegant example of quasi-newton method, please see [Note on LBFGS method]({{< relref "Note-on-LBFGS.md" >}}). 

And the common optimizer ADAM, ADAGRAD, ADADELTA can be viewed as quasi-newtonian methods with a highly structured Hessian matrix (diagonal) assumption. 

Before diving into their method, the geometric intuition behind Newtonian step is that: 
$$
H^{-1}g=U\Lambda^{-1}U^Tg
$$
Using the eigen decomposition of $H(x)=U\Lambda U^T$ , we project the gradient into the eigen coordinates of the Hessian matrix, and then scale the components according to the inverse of the eigenvalue.  and then rotate the vector back to normal coordinates system. 

So the directions with larger eigen value (steeper direction) get shrunk, so the optimizer proceeds slower ; and the directions (flat subspace) with smaller eigen values get amplified, so the optimizer march faster in this subspace.    

## Gradient Estimator

It's intuitive that we can guess the gradient from sampling the function, but what is a good guess (estimator)? 



## Hessian Estimator

Moreover, Hessian is not a construct that is directly available from 0th order information, so we have to estimate it in some way. 

### Diagonal approximation

ADAM, ADAGRAD, ADADELTA can be viewed from this perspective, i.e. they assume the hessian matrix is diagonal. That is to say the major axis are aligned to the coordinate axis. This guess will make the variable drop from $n^2$ to $n$ . 

Then they can use the memory of gradient vectors to estimate the diagonal values of Hessian. As the Newtonian Equation shows this is equivalent to adjust the learning rate for different variable / axis separately. Those variables with larger gradient will have a smaller learning rate, and the variables with smaller gradient will have a larger learning rate. 

Geometrically you kind of scale the space you are optimized in along each axis to make it more isotropic! 

### Low-rank plus Identity

Another Hessian estimator is the Gaussian sampling estimator. 
$$
\tilde H=\frac1b\sum_{i=1}^b\frac{f(x+\mu u_i)+f(x-\mu u_i)-2f(x)}{2\mu^2}u_iu_i^T+\lambda I_d
$$
in which $u_i\sim N(0,I_d)$ are samples from isotropic Gaussian.

Actually, they prove that this estimator $ \tilde H$ has such desirable property. 
$$
\nabla^2f_\mu(x)\preceq\mathbb E_u[\tilde H]=\nabla^2f_\mu(x)+(\lambda-{f(x)-f_\mu(x)\over\mu^2})\cdot I_d
$$
The prove has to be in another post. But as long as the expectation converge fast enough with the batch size $b$ then it's possible to estimate the Hessian. 

For how to invert the hessian, see [below](#Inverting-Hessian). 

### Full estimator



### Inverting Hessian

We have mentioned that inverting an unstructured hessian matrix is $O(n^3)$, we need to do it faster based on the structure. 

For **Diagonal matrix**, it's trivial. 

For **Low rank plus Identity**, $C\in \R^{n\times b},H\in\R^{n\times n}$
$$
H=CC^T+\lambda I
$$
Doing SVD decomposition of $C$ gives us $C=U_C\Lambda_CV_C^T$, $U_C\in\R^{n\times b}, \Lambda_C\in\R^{b\times b}, V_C\in\R^{b\times b}$. Thus we have 
$$
H=U_C\Lambda^2_CU_C^T+\lambda I
$$
It's easy to see square root of $H$ is 
$$
H^{1/2}=U_C(\Lambda^2_C+\lambda I)^{1/2}U_C^T+\lambda^{1/2} (I-U_CU_C^T)\\
H^{1/2}=U_C[(\Lambda^2_C+\lambda I)^{1/2}-\lambda^{1/2}]U_C^T+\lambda^{1/2} I\\
$$
Actually, without the complicated [Woodbury matrix inversion identity](https://en.wikipedia.org/wiki/Woodbury_matrix_identity) we can still figure out the inverse of the square root by geometric intuition
$$
H^{-1/2}=U_C(\Lambda^2_C+\lambda I)^{-1/2}U_C^T+\lambda^{-1/2} (I-U_CU_C^T)\\
H^{-1/2}=U_C((\Lambda^2_C+\lambda I)^{-1/2}-\lambda^{-1/2})U_C^T+\lambda^{-1/2} I\\
$$
Thus we only have to do SVD for each population sample vectors to compute the inverse. And the best thing is as long as we have the $C$ matrix factorized, the eigen decomposition of Hessian is done as well. 

### What does it mean to be a good Hessian estimate?

