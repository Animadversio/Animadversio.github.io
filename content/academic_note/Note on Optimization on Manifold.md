---
layout: post
title: Note on Optimization on Manifold
author: Binxu Wang
date: 2019-09-29
comments: true
# use_math: true
math: true
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

From Section 5.3[^1], the proposition 5.3.2 tells us 


$$
\nabla_u\eta=P_x\bar \nabla_u\eta\\
u\in T_xM,\ M\subset N
$$


With $\nabla,\bar\nabla$ as the connection in submanifold and parent manifold, $\eta$ is a vector field on $M$. It means, the differential operator on submanifold is just a projection of the result from connection in the major manifold (in Euclidean case, it's just standard direction derivative). 

In the case of $S^{n-1}$, as it's submanifold of $\R^n$ the Riemann connection on sphere reads 


$$
\nabla_v\eta=(I-xx^T)D_u(\eta)
$$


$D_v(\eta)$ is the directional derivative in the Euclidean space. For the parallel transport for a vector field $\eta$ along a curve $\gamma:t\mapsto M$, the equation reads


$$
\nabla_{\dot\gamma} \eta(\gamma(t))=0
$$

In the case of  sphere, it means that the direction derivative of the vector field $D_v(\eta(\gamma(t)))$ is parallel to the vector to the point $\gamma(t)$ for every $t$. 


$$
(I-xx^T)D_u(\eta)=0\\
\rightarrow D_u(\eta)//x
$$


Here consider a common case, that $\gamma$ is a geodesic on sphere. From classical dynamics, it's easy to intuit that parallel transport is doing rotation to the tangent space $T_{\gamma(t)}$ in the plane spanned by $x,u$, in which the geodesic $\gamma $ resides. this rotation maps the normal vector $x\mapsto \gamma(t)$, the tangent vector $u\mapsto \dot\gamma(t)$. And as the parallel transport has no effect on the linear space orthogonal to $x,u$, that part doesn't change. 

Thus, the vector field $\eta$ reads
$$
\eta(t)=\eta(\gamma(t))=-x\sin(\|\dot\gamma\|t)u^T\eta(0)+u\cos(\|\dot\gamma\|t)u^T\eta(0)+(I-uu^T)\eta(0)\\
\gamma(0)=x,\gamma(1)=y,\eta(0)\in T_xS^{n-1}
$$
And there is a much simpler result for $\eta(1)$ (the transported vector at $y$)


$$
\eta(1) = \eta(0)-2\frac{(x+y)^T\eta(0)}{\|x+y\|^2}(x+y)
$$

Which is reflection of the vector component  parallel to the bisector line of $x,\ y$ . As we know the transport from $T_xS^{n-1}\to T_yS^{n-1}$, and the normal space $N_x\to N_y$ the transformation of the tangent space of the euclidean space $T_x\R^n$ is easy to write, which is just a rotation in $x,u$ or $x,y$ plane. Denote the transformation $A_{x\to y}:T_x\R^n\to T_y\R^n$ , $V\in T_x\R^n$ and denote $v=\eta(1), u=\eta(0)$  the starting and ending point of transport. 


$$
A_{x\to y}V=(I-xx^T-uu^T+yx^T+vu^T)V\\
A_{y\to x}V=(I-xx^T-uu^T+xy^T+uv^T)V
$$


Easy to see, $A_{y\to x}$ is the inverse transform of this map. 



With these results, it's easy to write out CMA-ES algorithm on sphere. 















