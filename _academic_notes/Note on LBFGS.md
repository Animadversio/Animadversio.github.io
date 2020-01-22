---
layout: post
title: LBFGS Algorithm
author: Binxu Wang
date: Nov 11th, 2019
comments: true
use_math: true
published: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Optimization]

---

* TOC
{:toc}


L-BFGS algorithm
=======
## Motivation
L-BFGS is one of the not so simple optimization algorithm that we may encounter in large scale optimization problems. Not so simple means it’s not simply a first order algorithm, and the deviation from that is well motivated by theoretical arguments. So this note target to understand this algorithm 



## Quasi Newtonian Methods.
First of all, it is an quasi-Newtonian method. For Newtonian methods, the idea is to approximate the local function landscape with a quadratic function, defined by the local gradient and Hessian. 
$$
f(x_n+\Delta x)\sim h_n(\Delta x)=f(x_n)+\Delta x^Tg(x_n)+{1\over2}\Delta x^T H(x_n)\Delta x
$$
Differentiation provides the optimal Newtonian update, which is solving a linear system. 
$$
\Delta x=H(x_n)^{-1}g(x_n)
$$
THe resulting algorithm is (abbreviate $H_n=H(x_n),g_n=g(x_n)$. )
$$
\begin{align}
 & \mathbf{NewtonRaphson}(f,x_0): \\
 & \qquad \mbox{For $n=0,1,\ldots$ (until converged)}: \\
 & \qquad \qquad \mbox{Compute $g_n$ and $H^{-1}_n$ for $x_n$} \\
 & \qquad \qquad d = H^{-1}_n g_n \\
 & \qquad \qquad \alpha = \min_{\alpha \geq 0} f(x_{n} - \alpha d) \\
 & \qquad \qquad x_{n+1} \leftarrow x_{n} - \alpha d
\end{align}
$$

## Quasi Newton Methods

The philosophy of quasi-Newton method is, as most of Hessian is hard to inverse, we can use an approximate version of $H$ which is easier to invert. And this approximate version of $H$ is usually computed by accumulating information from the update steps and the gradients along the path. 
$$
\begin{align}
& \mathbf{QuasiNewton}(f,x_0, H^{-1}_0, \mbox{QuasiUpdate}): \\
& \qquad \mbox{For $n=0,1,\ldots$ (until converged)}: \\
& \qquad \qquad \mbox{// Compute search direction and step-size } \\
& \qquad \qquad d = H^{-1}_n g_n \\
& \qquad \qquad \alpha \leftarrow \min_{\alpha \geq 0} f(x_{n} - \alpha d) \\
& \qquad \qquad x_{n+1} \leftarrow x_{n} - \alpha d \\
& \qquad \qquad \mbox{// Store the input and gradient deltas } \\
& \qquad \qquad g_{n+1} \leftarrow \nabla f(x_{n+1}) \\
& \qquad \qquad s_{n+1} \leftarrow x_{n+1} - x_n \\
& \qquad \qquad y_{n+1} \leftarrow g_{n+1} - g_n \\
& \qquad \qquad \mbox{// Update inverse hessian } \\
& \qquad \qquad H^{-1}_{n+1} \leftarrow \mbox{QuasiUpdate}(H^{-1}_{n},s_{n+1}, y_{n+1})
\end{align}
$$

## Update Hessian

To update Hessian, they used the following principle, the update should be minimal comparing to the current $H^{-1}$. And the updated $H^{-1}$ should satisfy certain conditions for a Hessian. 

* $H^{-1}$ should be symmetric (and positive definite)
* $H^{-1}$ suffice the secant condition. 

The *Secant condition* means the following. For a quadratic function like 
$$
h_n(\Delta x)=f(x_n)+\Delta x^Tg_n+{1\over2}\Delta x^T H_n\Delta x
$$
we would like the gradient of this approximate agree with $f$ at $x_n$ and the last point $x_{n-1}$. 
$$
\nabla h_n(x_{n-1}) = g_{n-1}\\
\nabla h_n(x_{n}) = g_{n}
$$
Thus we must have condition for $H_n$
$$
H_n(x_n-x_{n-1})=g_n-g_{n-1}\\
i.e.\; H_n^{-1}y_n=s_n
$$
Using this condition, we update our Hessian by solving a Positive Definite Programming problem
$$
\arg\min_{H^{-1}}\|H^{-1}-H^{-1}_n\|_F^2\\
s.t.\ H^{-1} \mbox{ is symmetric}\\
H^{-1}y_n=s_n
$$
There is closed form solution to this convex optimization problem. 



## Limit Memory 

The part above mainly address the problem of computing a large Hessian analytically, or inverting it numerically. Now we can form an approximate invert Hessian just by updating the last one. 

However, for huge scale problems, representing Hessian is impossible. So what we need is a **procedural way** to compute $H^{-1}d$ from $d$ and the histories $\{s_i\},\ \{y_i\}$, without forming $H$ explicitly. 



## Comments

For large scale problems, the performance and convergence speed is usually not competitive with the online gradient descent methods like SGD and variants. 

Related: 

* [Understanding LBFGS Blog](http://aria42.com/blog/2014/12/understanding-lbfgs) Really easy to read and clear, and the thought flow of this note is mostly copied from this one. 
* [L-BFGS paper: On the limited memory BFGS method for large scale optimization](https://huzhiliang.com/docs/On the Limited Memory BFGS Method for Large Scale Optimization.pdf)
* 