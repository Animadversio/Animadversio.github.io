---
layout: post
title: Analytical Techniques for Finding Spectrum of Tridiagonal Toeplitz Matrix 
author: Binxu Wang
date: Feb 4th, 2022
use_math: true
comments: true
published: true
categories: [mathematics]
tags: [Linear Algebra, Eigenvalue problem, Recursion]
typora-copy-images-to: ..\assets\img\notes\PCA_highdimen


---

## Motivation

As mentioned in our [high-dimensional PCA note](PCA-of-High-Dimensional-Trajectories.md), understanding the spectrum of Toeplitz matrix is important. 

The subject itself is a bit technical, but the analytical techniques involved in it are splendid and general. So here I took note from this paper and present way to calculate the spectrum on paper (or by mathematica). 

## Problem Formulation 

Given a $n$ dimensional tri-toeplitz matrix $A$, 

Classic way of finding eigenvalues is to solve the eigenequation $(A-\lambda I)v=0$ or the eigen polynomial $\det(A-\lambda I)$. 

Note the eigen-polynomial $W_n(\lambda)$ is a $n$ degree polynomial in $\lambda$. The first useful trick is to calculate this polynomial by recursion or mathematical induction! 

## Eigenpolynomial by Induction

Simply, we denote the eigenpolynomial of dimension $n$ matrix as $W_n(\lambda)$. These polynomials are easy to calculate by hand for low dimensions. 

* For $n=1$, $W_1=a-\lambda$, 
* For $n=2$, $W_2=(a-\lambda)^2-bc$ 

The key is to notice that $W_n$ of different dimensions were recursively connected: using [the minor expansion formula of determinant](https://en.wikipedia.org/wiki/Minor_(linear_algebra)#Cofactor_expansion_of_the_determinant), we can see 

$$
W_{n+2}(\lambda)=(a-\lambda)W_{n+1}(\lambda)-bcW_{n}(\lambda)
$$

### Solve the Linear Recurrence Relation

We got the two element recursion rule for determinant, what's the closed form solution for this sequence? For [constant recursive sequence](https://en.wikipedia.org/wiki/Constant-recursive_sequence) also known as linear recurrence relation, a general way to solve it is to [solve the characteristic polynomial equation](https://en.wikipedia.org/wiki/Linear_recurrence_with_constant_coefficients#General_solution). 

$$
\eta^2-(a-\lambda)\eta+bc=0
$$

When there are two distinct solutions $\Delta\neq0$ 

$$
\eta_{1,2}=\frac{(a-\lambda)\pm\sqrt{\Delta}}{2}\\
\Delta = (a-\lambda)^2-4bc
$$

Let's make ansatz $W_n(\lambda)=A\eta_1^n+B\eta_2^n$ and solve the coefficients $A,B$ by the initial condition. 

$$
\begin{bmatrix}
\eta_1 & \eta_2\\
\eta_1^2 & \eta_2^2
\end{bmatrix}
\begin{bmatrix}
A\\
B
\end{bmatrix}=
\begin{bmatrix}
a-\lambda\\
(a-\lambda)^2-bc
\end{bmatrix}
$$

By tedious computation (or Mathematica), we got 

$$
A=\eta_1/\sqrt{\Delta}\\B=-\eta_2/\sqrt{\Delta}\\
W_n(\lambda)=\frac{1}{\sqrt{\Delta}}(\eta_1^{n+1}-\eta_2^{n+1})
$$

## Solve Eigenpolynomial

Given this beautiful relationship, solve the polynomial became easier $W_n(\lambda)=0$

$$
\eta_1\eta_2=bc\\
\eta_1+\eta_2=a-\lambda\\
\frac{1}{\sqrt{\Delta}}(\eta_1^{n+1}-\eta_2^{n+1})=0\\
(\eta_1^{2n+2}-(bc)^{n+1})\frac{\eta_2^{n+1}}{\sqrt{\Delta}}=0
$$

Solution to this equation is 

$$
(\frac{\eta_1^2}{bc})^{n+1}=1\\
\eta_1^2 = bc\exp{\frac{i2k\pi}{n+1}},\mbox{ for }k=0,...n\\
\eta_1 = \pm\sqrt{bc}\exp{\frac{ik\pi}{n+1}}\\
\eta_2 = \pm\sqrt{bc}\exp{\frac{-ik\pi}{n+1}}\\
$$

Thus by $\eta_1+\eta_2$

$$
\lambda= a - (\eta_1+\eta_2)\\
\lambda_k=a\mp\sqrt{bc}(\exp{\frac{ik\pi}{n+1}}+\exp{\frac{-ik\pi}{n+1}})\\
\lambda_k =a\mp2\sqrt{bc} \cos(\frac{k\pi}{n+1}),\mbox{ for }k=0,...n\\
$$

It seems there are $2(n+1)$ choices, but there are $n+2$ unique values in this formula, since. 

$$
a+2\sqrt{bc} \cos(\frac{k\pi}{n+1})=a-2\sqrt{bc} \cos(\frac{(n+1-k)\pi}{n+1})\mbox{ for }k=1...n
$$

Thus we could summarize the $n+2$ unique values in this formula

$$
\lambda_k =a-2\sqrt{bc} \cos(\frac{k\pi}{n+1}),\mbox{ for }k=0,...n+1\\
$$

Notice that $k=0,n+1$ will generate eigenvalue $\lambda_0=a\pm2\sqrt{bc}$. which leads to $\Delta=(a-\lambda)^2-4bc=0$, thus it violates the assumption above. 

In summary the valida solution for $\lambda$ are the following, exactly $n$ values. (since the $W_n$ is a $n$ degree polynomial, it shall only have $n$ solutions. )

$$
\lambda_k =a-2\sqrt{bc} \cos(\frac{k\pi}{n+1}),\mbox{ for }k=1,...n\\
$$
