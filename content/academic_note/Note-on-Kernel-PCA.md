---
layout: post
title: Note on Kernel PCA
author: Binxu Wang
date: 2022-03-21 
comments: true
# use_math: true
math: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Applied Math, Linear Algebra, kernel method]


---

* TOC
{:toc}


## Motivation 

Simply put, "kernel trick" is the finding that sometimes only inner product appears in the formulation of some algorithms. because of this, we could substitute the inner product with some fancier kernel function, i.e. inner product in some other spaces.  This post is about another usage of kernel trick. Another usage is [Kernel (ridge) Regression]({{< relref "Note-on-Kernel-Ridge-Regression.md" >}}).  

We want to analyze the principal component in a feature space instead of the original $x$ space, can we do so by specifying a kernel function $K(x,x')$ instead of the feature map $\phi(x)$ explicitly? 

## Method

Given a dataset $\{x_1,x_2,...x_N\}$. For a principal component analysis, we would like to analyze the spectral structure of the covariance matrix. Assume the feature map $\phi:\mathbb R^d\to\mathbb R^D$. Then our feature matrix $\Phi$ is of shape $D\times N$.  
$$
\Phi = [\phi(x_1),\phi(x_2),...\phi(x_N)]
$$
The covariance matrix is the inner product matrix of centered features $\Phi$. 
$$
C= \bar\Phi\bar\Phi^T\\
\bar \Phi = \Phi - \frac 1N\Phi 11^T
$$
Note the feature covariance matrix ($D\times D$) is different from the kernel matrix $K$, $N\times N$. 
$$
K = \Phi^T\Phi
$$
Note that if we want to use high dimensional feature spaces (e.g. neural network, kernel features) the covariance matrix is rank deficient:  $\rank C \leq N <D$. Thus, it will have a large null space with 0 eigen values. For the meaningful, non zero eigenvalues, the eigenvectors live in the column space of $\Phi$. Let we have an eigen pair $v,\lambda$
$$
Cv = \lambda v\\
\bar\Phi (\bar\Phi^T v)  = \lambda v
$$
We represent the eigenvectors by the coefficients $v:=\bar\Phi \alpha$, $\alpha$ is a coefficient vector of length $N$. 
$$
\bar\Phi \bar\Phi^T \bar\Phi \alpha  = \lambda \bar\Phi \alpha\\
\bar\Phi \bar K \alpha = \lambda \bar\Phi\alpha\\
\bar K^2 \alpha = \lambda \bar K\alpha
$$
Thus we got another eigenvalue problem w.r.t the kernel matrix which we could solve. 

As the eigenvectors need to be normalized properly, the squared L2 norm of coefficients shall be $1/\lambda$, 
$$
v^Tv = 1\\
 \alpha^T \bar K \alpha = 1\\
\alpha^T\alpha = 1/\lambda
$$
For the centering operation, we could do so by modifying the kernel matrix
$$
\begin{align}
\bar K =&\bar\Phi^T\bar\Phi=(\Phi - \frac 1N\Phi 1_N1_N^T)^T(\Phi - \frac 1N\Phi 1_N1_N^T)\\
=& \Phi^T\Phi-\frac 1N 1_N1_N^T \Phi^T\Phi - \frac 1N \Phi^T\Phi1_N1_N^T +\frac 1 {N^2} 1_N1_N^T \Phi^T\Phi 1_N1_N^T\\
=& K - \frac 1N\mathbb 1_N K - \frac 1N K\mathbb 1_N - \frac 1 {N^2} \mathbb 1_N K\mathbb 1_N 
\end{align}
$$
The matrix $\mathbb 1_N = 1_N1_N^T$ is a $N\times N$ matrix full of one. 

## Projection to Kernel PC space

One key usage of PCA is to visualize samples onto the PC space, i.e. we need to obtain projections of sample features with the PC vectors $v$. 
$$
v^T\phi (x)= \phi(x)^Tv = \phi(x)^T \bar\Phi \alpha \\
= \sum_i^N \alpha_i (\phi(x)^T\phi(x_i))\\
= \sum_i^NK(x,x_i) \alpha_i 
$$
Similar to regression, we can also use kernel function to obtain projection coefficients. 

## Relation to Spectral Embedding

Note this view of kernel PCA  is also related to [spectral embedding]({{< relref "Spectral-Graph-and-Segmentation.md" >}}), i.e. the inverse of kernel matrix $K$ is a form of distance matrix. 

The top eigenvectors of kernel matrices == the bottom eigenvectors of the inverse. These eigenvectors could be used as coordinates to embed the samples, since these coordinates will minimize the stress energy of the embedding if we regard the $K$ as a form of elasticity strength. 
$$
E(u)=\sum_{ij} K_{ij} (u_i-u_j)^2 \\
= 2\sum_{ij}K_{ij}u_j^2-2\sum_{ij} u_i K_{ij} u_j \\
=2 1_N^TK u^2 - 2 u^TKu
$$
Thus choose $u$ as the top eigenvectors will reduce this energy $E(u)$. 

## Reference

[Kernel principal component analysis | SpringerLink](https://link.springer.com/chapter/10.1007/BFb0020217) 

