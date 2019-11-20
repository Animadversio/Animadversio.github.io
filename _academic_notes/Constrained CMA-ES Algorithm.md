---
layout: post
title: Constrained CMA-ES Algorithm
author: Binxu Wang
date: June 20th, 2019
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Optimization]
---

* TOC
{:toc}

Constrained CMA-ES Algorithm
=======


# Target 

CMA-ES is originally used in unconstrained optimization. To adapt it into constrained optimization and we have to handle the boundary in some way. So how could it handle this geometric boundary? 

# Objective 



# Existing CMA-ES algorithm 



## Review of the Geometry of Multivariate Gaussian 

Although any uni-modal distribution could serve as the distribution for offspring distribution in CMA-ES. Most of the implementation of CMA-ES is based on Gaussian distribution, we'd better review some properties of Gaussian at first. The distribution, geometry of the space and algebra is closely related to each other. 

The density of general multivariate gaussian is written as 


$$
p( x; \mu, \Sigma) = \frac{1}{\sqrt{(2\pi)^k|\Sigma|}}\exp(-\frac12(x-\mu)^T\Sigma^{-1}(x-\mu))
$$


If we assume 0 mean for the distribution, the only parameter is the Covariate Matrix $\Sigma$ . It connects to the geometric structure of the distribution in the following way. 

For a positive definite and symmetric matrix $\Sigma\in S^k_+$, it could be decomposed in Cholesky decomposition or eigen decomposition. 


$$
\Sigma = VDV^T=AA^T, \\
VV^T=I,\\
A=VD^{1/2}, \\
A^{-1}=D^{-1/2}V^{-1}\\
$$


Similarly, we also have this equation


$$
\Sigma^{-1} = VD^{-1}V^T=A^{-T}A^{-1}\\
$$

Consider the equi-density contour of the distribution, which is a $k-1$ dimension ellipsoid in the $k$ dimensional space. It subjects to the equation 


$$
x^T\Sigma^{-1}x = const = \|A^{-1}x\|^2
$$

Then name $z=A^{-1}x$, the $z$ will resides in a sphere with radius $\sqrt{const}$. So this demonstrate that $A$ holds the **forward transformation** from the space $z$ in which distribution is isotropic to the actual optimization space of $x$. And $A^{-1}$ holds the **inversion of this transformation**. 

As $A=VD^{1/2}$ and normally $D$ is arranged by the value of eigenvalue of $\Sigma$, the first vertical vector $A_1=\sqrt \lambda_1 v_1$ is the direction corresponding to the largest eigen value, i.e. the longest axis of the ellipsoid, i.e. the direction that sphere gets most extension. And lower vectors corresponds to shorter axis.  

Back to the main subject, the point of CMA-ES is to morph this gaussian ellipsoid in a sensible way to sense the gradient of the landscape and migrate to the minimum / maximum. So how is this achieved computationally? 

## Ellipsoid Morphing in Covariant Matrix Adaptation

Note that, for a unit vector $y$, $y^T\Sigma y=\|A^Ty\|^2=Var(y^Tx)$ describe the distribution / expansion on the $y$ axis. Thus the simple way to expand or contract the distribution in some direction is to add rank-1 matrix to the covariate matrix $\Sigma+ cyy^T$ would expand the distribution in y direction if $c>0$. Note that as $y$ may not be an eigen-vector, this change of $\Sigma$ may change multiple value in the spectra. 

So for CMA-ES, we want the distribution to expand in the direction that is most probable to yield lower objective functions. 

# Boundary Handling Method 

The constraint is usually defined by a function on the optimization space $g(x)$. $g(x)\leq0$ define the feasible zone. 

## Resampling 

In the sample generation phase, it's easy to evaluate the feasibility function and only select the feasible offsprings. Thus when the 



However, in high dimensional scenario and multiple boundary case, 

## Covariance Matrix Adaptation







