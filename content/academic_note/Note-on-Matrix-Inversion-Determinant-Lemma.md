---
layout: post
title: Some Famous Matrix Determinant and Inversion Identities
author: Binxu Wang
date: 2022-04-16
# use_math: true
math: true
comments: true
featured: true
categories: [mathematics]
tags: [Linear Algebra]
---

## Motivation

How to compute determinant or inversion of matrix with a low rank modificaiton? This is a very interesting and important math technique in statistical methods, since people frequently model covariance matrix or connectivity matrix as such: a matrix plus a low rank modification. 

When people need the determinant or inversion of such large matrices, they will need alternative formulas instead of $n^3$ operation of inversion or determinant of the huge matrix. 

Moreover when the high dimensional matrix is updated step by steps these formulas allow algorithms to update the determinant or inversion instead of computing from scratch. 



## Main Results 

### Determinant Lemma

Generalized matrix determinant lemma

$$
\det(A+UWV^T)=\det(W)\det(A)\det(W^{-1}+V^TA^{-1}U)
$$

**Weinstein–Aronszajn identity**

$$
\det(I_m+AB)=\det(I_n+BA)
$$

**Block matrix determinant**

$$
M=\begin{bmatrix}
A & B\\
C & D
\end{bmatrix}\\
\det(M)=\det(A-BD^{-1}C)\det(D)\\
\det(M)=\det(D-CA^{-1}B)\det(A)
$$

**Derivation**: Basically use matrix multiplication trick to make the block matrix block upper / lower triangular. 

$$
\begin{bmatrix}
I_m & 0\\
-CA^{-1} & I_n
\end{bmatrix}
\begin{bmatrix}
A & B\\
C & D
\end{bmatrix}=
\begin{bmatrix}
A & B\\
0 & D-CA^{-1}B
\end{bmatrix}\\
$$

Taking determinant of this 

$$
\det(M)\times 1=\det(A)\det(D-CA^{-1}B)
$$

Using the two identities, we can substitute $$D\to -W^{-1}$$

$$
\det(A-BD^{-1}C)\det(D)=\det(D-CA^{-1}B)\det(A)\\
\det(A+BWC)\det(-W^{-1})=\det(-W^{-1}-CA^{-1}B)\det(A)\\
$$

Thus we get the final identity

$$
\det(A+BWC)=\det(W)\det(A)\det(W^{-1}+CA^{-1}B)
$$


### Inversion Lemma

Generalized matrix inversion lemma (Woodbury matrix identity; Sherman-Morrison formula)

$$
(A+UWV^T)^{-1}=A^{-1}-A^{-1}U(W^{-1}+V^TA^{-1}U)^{-1}V^TA^{-1}
$$
Derivation

* It's relatively easy to verify by multiplying $A+UWV^T$ from either side. 

* Simple inversion formula

$$
(I+P)^{-1} = I - (I+P)^{-1}P  = I - P(I+P)^{-1}
$$

Variants

* Sherman-Morrison formula: When $U,V$ are vectors

$$
(A+uv^T)^{-1}=A^{-1}-A^{-1}u(1+v^TA^{-1}u)^{-1}v^TA^{-1}\\
=A^{-1}-\frac{A^{-1}uv^TA^{-1}}{1+v^TA^{-1}u}
$$

* Sum of matrix: When $U=V=I$ 

$$
(A+B)^{-1}=A^{-1}-A^{-1}(B^{-1}+A^{-1})^{-1}A^{-1}\\
=A^{-1}-(A+AB^{-1}A)^{-1}
$$

* Low rank update to identity

$$
(I+UV^T)^{-1}=I-U(I+V^TU)^{-1}V^T
$$

## Application

In model [GPFA](https://elephant.readthedocs.io/en/latest/tutorials/gpfa.html), the latent process is determined by a Gaussian process with the kernel matrix $$K$$ . Moreover, the observation is connected to latent variables through a linear gaussian model with linear mapping $C$, with neuron independent noise $R$. Thus the marginal distribution of data $y$ is a gaussian. 

The mean and covariance of the observed variable $y$ is 

$$
\mu(y)=d\\
\Sigma(y)=R+CKC^T
$$

So to evaluate the exact density of an observation $y$, we need to have the determinant and inverse of $\Sigma$ 

$$
\log p(y)=-\log(\sqrt{(2\pi)^n|\Sigma|})-\frac{1}{2}(y-d)^{T}\Sigma^{-1}(y-d)\\
=-\frac n2 \log(2\pi)-\frac12\log\det\Sigma-\frac{1}{2}(y-d)^{T}\Sigma^{-1}(y-d)
$$

Thus we can use the two lemmas to compute the determinant ant inversion. 

$$
\det(R+CKC^T) =\det(R)\det(K)\det(K^{-1}+C^TR^{-1}C)\\
\log\det\Sigma =\log\det(R)+\log\det(K)+\log\det(K^{-1}+C^TR^{-1}C)
$$

As for the inversion 

$$
\Sigma^{-1}=(R+CKC^T)^{-1}\\
=R^{-1}+R^{-1}C(K^{-1}+C^TR^{-1}C)^{-1}C^TR^{-1}
$$

This formula could be clerly seen in the implementation of [GPFA in elephant](https://github.com/NeuralEnsemble/elephant/blob/378bc593ead97a9a46583ddd0a7c59ad80db47ce/elephant/gpfa/gpfa_core.py#L440) `gpfa_core.exact_inference_with_ll()`. 



## See also 

[A similar post by Djalil CHAFAÏ ](https://djalil.chafai.net/blog/2011/05/30/some-nonlinear-formulas-in-linear-algebra/)