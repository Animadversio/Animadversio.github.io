---
layout: post
title: Note on Kernel Ridge Regression
author: Binxu Wang
date: 2021-12-17 
comments: true
# use_math: true
math: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Applied Math, Linear Algebra, kernel method]

---

* TOC
{:toc}


## Motivation

Understand the use of kernel in regression problems. For usage in unsupervised learning / dimension reduction, see [notes on Kernel PCA]({{< relref "Note-on-Kernel-PCA.md" >}}). 

## Kernel in Classification

Kernel is usually introduced in SVM classification problems. The rationale is that a linearly non-separable dataset could be separable in a high-dimensional feature space using the mapping $\phi:\mathcal X\to\mathcal F$ . 

But people found that the for certain kinds of feature mapping like polynomial or radial basis function, it's more efficient to compute $\phi(x_i)^T\phi(x_j)$ instead of explicitly calculate the mapping $\phi(x_i)$. If the feature space far exceeds the dimensionality of data / data number. storing the inner products is more efficient than storing the features. 

Because of this we relied on the kernel $K(x_i,x_j)=\phi(x_i)^T\phi(x_j)$ and the mapping $\phi$ are left abstract. 

## Kernel in Regression

What does this have to do with regression?

For regression, we can imagine our target could be modelled by a linear function in the high dim feature space $\mathcal F$, but not in the data space $\mathcal X$ . 


$$
\hat y= w^T\phi(x)
$$


Thus given normal data set $X$ (shape $N,p$ ) and target $y$ (shape $N,1$), we can compute the features $\phi(X)=[\phi(x_1)^T;\phi(x_2)^T;\phi(x_3)^T...]$, which is a $(N,N_f)$ matrix. since usually this $N_f>N$ (more high-dim features than data point), the linear regression problem is ill posed, which needs regularization. 

One common regularization is ridge regression


$$
w=[\phi(X)^T\phi(X)+\lambda I_f]^{-1}\phi(X)^Ty
$$


The predicted will be 


$$
\hat y=\phi(X)[\phi(X)^T\phi(X)+\lambda I_f]^{-1}\phi(X)^Ty
$$


Note that in ridge regression, $[\phi(X)^T\phi(X)+\lambda I_f]$  is full rank and invertible. So we could find this identity 


$$
\phi(X)[\phi(X)^T\phi(X)+\lambda I_f]=[\phi(X)\phi(X)^T+\lambda I_N]\phi(X)
$$


Note the different dimensionality of the two identity matrices. With some inversion, we got this. 


$$
[\phi(X)\phi(X)^T+\lambda I_N]^{-1}\phi(X)=\phi(X)[\phi(X)^T\phi(X)+\lambda I_f]^{-1}
$$


Thus we could rewrite our original prediction values 


$$
\hat y=[\phi(X)\phi(X)^T+\lambda I_N]^{-1}\phi(X)\phi(X)^Ty
$$


Now we can hide the feature mappings and retain the kernel matrix $K$, of shape $[N,N]$ 


$$
\hat y=[K+\lambda I_N]^{-1}Ky\\
K=\phi(X)\phi(X)^T
$$


It's easy to see, without regularization term $\lambda$ the training error will be 0, and prediction for training point will be exactly same as training points. 

When we obtain new samples $X'$ 


$$
\hat y'=\phi(X')w\\
\hat y'=\phi(X')[\phi(X)^T\phi(X)+\lambda I_f]^{-1}\phi(X)^Ty\\
\hat y'=\phi(X')\phi(X)^T[\phi(X)\phi(X)^T+\lambda I_N]^{-1}y\\
\hat y'=K(X',X)[K(X,X)+\lambda I_N]^{-1}y
$$


Through this we can see, for prediction, the system stores weights on the samples $\alpha$ ($N,1$ shape), and then predict new targets based on their **similarity**   $K(X',X)$ with previous samples. 


$$
\hat y'=K(X',X)\alpha\\
\alpha=[K(X,X)+\lambda I_N]^{-1}y
$$


In this sense, the intuition of kernel regression is just to look for similar cases in training data, and draw similar results by averaging. The similarity is assessed in the kernel space. 

## Interpretation

Kernel matrix $K$ could be understood as a way of measuring similarity. 

* Representational similarity matrix is exactly doing this. 
* It shall assume larger value for more similar points and lower for less similar points. 
* In some sense we can picture it as the $\exp(-d)$ monotonic decrease function of distance. which is exactly the case for radial basis function. 

