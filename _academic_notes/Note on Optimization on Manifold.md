---
layout: post
title: Note on Optimization on Manifold
author: Binxu Wang
date: June 20th, 2019
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Differential Geometry, Optimization]
---

Note on Optimization on Manifold
===

[^1]: [2008 Absil book, Optimization Algorithms on Matrix Manifolds](https://press.princeton.edu/absil) Major reference
[^2]: [2013 Thesis of Wen Huang, Optimization Algorithms on Riemannian Manifolds with Applications](https://diginole.lib.fsu.edu/islandora/object/fsu:185265/datastream/PDF/download/citation.pdf) Major reference 

Manifold is locally similar to $\R^n$ flat space, but globally not. 

Manifold is locally homeomorphic to a Euclidean space of the same dimension. Besides there is Riemann logrithm map that connect the local vector space $T_p$ to the neighbourhood of $p$ on the manifold. Thus, many local optimization algorithm that work on flat $\R^n$ space can  work the same on neighborhood of a manifold. The unique thing of working on a manifold is how to transport the local direction information in one neighborhood into another neighborhood. 



To be concrete, consider gradient based optimization algorithm for a function $f$ on manifold $\mathcal M$. The gradient vector can be estimated in a neighbor, 



## Differential Geometry Revisit

Here we review a few differential geometry construct and their properties. 

### Differential Operator



### Riemann Connection



### Parallel Transport





## Example: n-sphere

$S^{n}$ is a useful and elegant manifold to work as example. 

We know that to work on a manifold, the crucial geometric structure to get is the **exponential map** and its inverse the **logarithm map**. And to transport the covariance and trajectory data at one point to another point, we need **parallel transport**. 

Note that, for simplicity, we work from extrinsic perspective instead of intrinsic perspective, i.e. we consider the canonical embedding of $S^{n-1}$ in  $\R^n$  as unit sphere. Thus the manifold and tangent space is defined as 


$$
S^{n-1}=\{x\in\R^{n}|x^Tx=1\}\\
T_xS^{n-1}=\{p\in\R^n|p^Tx=0\}
$$


Note that in extrinsic view, the geodesic path is just large circle. Thus for $x\in S^{n-1},\ v\in T_x$, 


$$
Exp_x(v)=\cos(\|v\|)x+\sin(\|v\|)\frac{v}{\|v\|}
$$


Note that the Exponential map can cover the whole sphere, but it's not one-to-one, thus if the tangent vector has too large norm, the Exponential map can send it back to itself, which is not desirable. Thus, it's crucial to limit the range of norm of the tangent vectors. 

When we have a start and an end point $x,y$ then we will can easily write the parametric geodesic connecting them, with the tangent vector $u$. 


$$
\gamma(t)=\cos(t)x+\sin(t)u\\
u=(y-x^Ty x)/\|y-x^Ty x\|
$$

With this geodesic, we can calculate the parallel transport of tangent space from $T_x\to T_y$ . Note from the Absil book[^1] Section 8.1 we learn that calculating parallel transport from the classic differential geometry machinery (coordinate charts, metric, christopher symbol, Riemann connection and parallel transport equation etc.) can be sophisticated. So here we derive the parallel transport from $S^{n-1}$ from the trivial parallel transport on $\R^n$, as the former is a **submanifold** of the latter. 

From Section 5.3[^1], the 















