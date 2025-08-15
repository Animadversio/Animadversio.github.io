---
layout: post
title: PCA of High Dimensional Trajectory
author: Binxu Wang
date: 2022-01-22
# use_math: true
math: true
comments: true
categories: [mathematics]
tags: [Unsupervised Learning, PCA, Geometry, high dimensional, random process, Linear Algebra]
typora-copy-images-to: ..\assets\img\notes\PCA_highdimen

---

## Motivation

When you think about random walks, what shape do you think about? 

Is it like this? Or this? 

These are good examples of random walks in two or three dimensions. But what about random walks in higher dimensions? 

## Formulation

We first consider the simplest case, a random walk in a $d$ dimensional space $\mathbb R^d$, i.e. continuous space, discrete time. For each time step, it took a step $\eta_i$ i.i.d. sampled from a zero-mean and finite covariance distribution $\mathcal P$, with $x_i,\eta_i\in \mathbb R^d$

$$
x_{i}=x_{i-1}+\eta_i\;, \eta_i\sim\mathcal P
$$

Now we consider the trajectory $\{x_1,x_2...x_T\}$ formed by the random walk of $T$ step. We could compute the PCA of this trajectory based on its covariance matrix $C_{i,j}=cov(x_i,x_j)$.  

We represent $x_i,\eta_i$ as row vectors, then we form the $T$-by-$d$ data matrix $X=[x_1;x_2;x_3...x_T]$, further we set $x_0=[0,0,...0]$, s.t. $x_1=\eta_1$. Similarly we could form a $T$-by-$d$ matrix of steps $H=[\eta_1;\eta_2;\eta_3...\eta_T]$

### Reduce Data Matrix to Steps

How to compute this covariance matrix? This paper [^1] noticed that it was easier to tackle $H$ than $X$. First they noticed the relationship between the data matrix $X$ and the matrix, where $S$ is the $T$-by-$T$ matrix of "differentiation" between rows. 

$$
SX=H\\
S=\begin{bmatrix}
 1 & 0 & 0 & ... & 0 & 0\\
-1 & 1 & 0 & ... & 0 & 0\\
 0 &-1 & 1 & ... & 0 & 0\\
 & & &... \\
 & & &...& 1 & 0\\
 0 & 0 & 0 & ... & -1 & 1
\end{bmatrix}
$$

Then we know the inverse of this, $S^{-1}$ is the $T$-by-$T$ matrix of "accumulating" rows, i.e. the lower triangular matrix filled with $1$.  

$$
X=S^{-1}H\\
S^{-1}=\begin{bmatrix}
 1 & 0 & 0 & ... & 0 & 0\\
 1 & 1 & 0 & ... & 0 & 0\\
 1 & 1 & 1 & ... & 0 & 0\\
 1 & 1 & 1 &... \\
 1 & 1 & 1 &...  & 1 & 0\\
 1 & 1 & 1 & ... & 1 & 1
\end{bmatrix}
$$

Next, after centering (mean subtracting) each column of $X$, then the covariance matrix is the expected inner product of the centered data matrix $\bar X$. 

$$
\hat X = CX \mbox{, with  }C = I-\frac 1T 11^T\\
\Sigma[x]=\mathbb E[\hat X \hat X^T]=\mathbb E[CS^{-1}HH^TS^{-T}C]
$$

Note that $C,S$ are both constant matrix with shape $T$-by-$T$ , and $C$ is symmetric, the only random variables are $H$. Thus we only need to compute the expectation for $H H^T$. 

### Covariance of Steps $H$

Since we assumed the steps $\eta_i$ were taken i.id. from the same distribution $\mathcal P$, then it's simple to compute elements of $HH^T$, using the linearity of inner product and independence. ($\eta_i^{(k)}$ represent the $k$th component of the row vector $\eta_i$). The expectation of each component vanish, since we assume the distribution $\mathcal P$ has zero mean, 

$$
\mathbb E[\eta_i\eta_j^T]=\mathbb E[\sum_k^d \eta_i^{(k)}\eta_j^{(k)}]\\
=\sum_k^d \mathbb E[\eta_i^{(k)}]\mathbb E[\eta_j^{(k)}]\\
=0\mbox{, }i\neq j
$$

Similarly, we can evaluate the diagonal values. Since the distribution $\mathcal P$ has a finite covariance, the diagonal values are the trace of its covariance matrix. 

$$
\mathbb E[\eta_i\eta_i^T]=\mathbb E[\sum_k {\eta_i^{(k)}}^2]\\
=\sum_k^d \mathbb E[{\eta_i^{(k)}}^2]\\
=\sum_k^d Var[\eta^{(k)}]\\
=tr[\Sigma(\mathcal P)]
$$

Without loss of generality, we can assume $tr[\Sigma(\mathcal P)]=1$, by just rescaling $x$.  Thus we have 

$$
\mathbb E[HH^T]=tr[\Sigma(\mathcal P)]I=I
$$


What does this tell us? Geometrically this means, when we sample from a zero mean, finite variance distribution, the vectors are **expected** to be **orthogonal** to each other, with the **norm of each vector equal to the trace of the covariance matrix**. This is necessarily true for all dimension $d$. However, the magic is, when $d$ gets high, the empirical covariance $HH^T$ converged arbitrarily close to the expected value $I$. Thus we have, at high dimension, randomly sampled step vectors are orthogonal to each other with high probability. 

$$
HH^T\to I\mbox{, with d high}
$$

With this approximation, the covariance matrix becomes a constant $T$-by-$T$ matrix. 

$$
\Sigma[x]=CS^{-1}S^{-T}C
$$

From this we can already see, the **covariance structure** of high dimensional random walk is **universal**, independent of the distribution $\mathcal P$ where steps are sampled from [^2], even independent of the dimension $d$. All random walk of $T$ steps in high dimension will have the same covariance structure up to scaling, thus they shall all have the same PCA structure. 

We noticed that 

$$
S^{-1}S^{-T}=\begin{bmatrix}
 1 & 1 & 1 & ... & 1 & 1\\
 1 & 2 & 2 & ... & 2 & 2\\
 1 & 2 & 3 & ... & 3 & 3\\
 1 & 2 & 3 &... \\
 1 & 2 & 3 &...  & T-1 & T-1\\
 1 & 2 & 3 & ... & T-1 & T
\end{bmatrix}
$$

Then the total variance or the trace of the covariance matrix is 
$$
\begin{align}
tr[\Sigma[x]]&=tr[CS^{-1}S^{-T}C]\\
&=tr[CCS^{-1}S^{-T}]\\
&=tr[CS^{-1}S^{-T}]\\
&=tr[(I-\frac 1T 11^T)S^{-1}S^{-T}]\\
&=tr[S^{-1}S^{-T}-\frac 1T 11^TS^{-1}S^{-T}]\\
&=tr[S^{-1}S^{-T}]-\frac 1T tr[1^TS^{-1}S^{-T}1]\\
\end{align}
$$
The second term is the summation of all entries in the $T$-by-$T$ matrix $S^{-1}S^{-T}$. We find this matrix could be viewed as the sum of $T$ matrices, each of them filled with $k$-by-$k$ submatrix full of $1$. 
$$
\begin{align}
&tr[1^TS^{-1}S^{-T}1]\\
=&\sum_{k=1}^T k^2\\
=&\frac{[T(T + 1)(2T + 1)]}{6}
\end{align}
$$
Thus the original trace of the covariance matrix reads 
$$
\begin{align}
tr[\Sigma[x]]&=tr[S^{-1}S^{-T}]-\frac 1T tr[1^TS^{-1}S^{-T}1]\\
&=\sum_{i=1}^T k -\frac{T(T + 1)(2T + 1)}{6T}\\
&=\frac{T(T + 1)}{2} -\frac{(T + 1)(2T + 1)}{6}\\
&=\frac{(T+1)(T-1)}{6}\\
&=\frac{T^2-1}{6}
\end{align}
$$
This is the sum of variance in all dimensions in the random walk. (which should be the correct denominator in Eq. 12 of [^1]) 

[^1]: Antognini, J., & Sohl-Dickstein, J. (2018). [PCA of high dimensional random walks with comparison to neural network training](https://proceedings.neurips.cc/paper/2018/hash/7a576629fef88f3e636afd33b09e8289-Abstract.html). *Advances in Neural Information Processing Systems*, *31*.

[^2]: Note that this is the $T$-by-$T$ covariance matrix, it's structured is independent of $\mathcal P$, thus the projected trajectories are independent of $\mathcal P$. However, this does not mean the PC axes i.e. the right singular vectors of $\hat X$ in $n$ dimensional space is independent of $\mathcal P$.

## Eigen Structures 

Finally let's analyze the eigen structure of $CS^{-1}S^{-T}C$. Since $S^TS$ is a real symmetric matrix, its eigenvalue and eigenvectors are real, and $(S^TS)^{-1}$ will share the same eigenvectors with inverted eigenvalues. 

By calculation or intuition ($S$ as row differentiation operator ), $S^TS$ manifests itself as a center difference (2nd order differentiation) matrix on a grid formed by $T$ points, with a difference of $1$ in lower right corner.  

$$
S^TS=\begin{bmatrix}
 1 & -1 & 0 & ... & 0 & 0\\
 0 & 1 & -1 & ... & 0 & 0\\
 0 & 0 & 1 & ... & 0 & 0\\
 & & &... \\
 & & &...& 1 & -1\\
 0 & 0 & 0 & ... & 0 & 1
\end{bmatrix}
\begin{bmatrix}
 1 & 0 & 0 & ... & 0 & 0\\
-1 & 1 & 0 & ... & 0 & 0\\
 0 &-1 & 1 & ... & 0 & 0\\
 & & &... \\
 & & &...& 1 & 0\\
 0 & 0 & 0 & ... & -1 & 1
\end{bmatrix}\\
=\begin{bmatrix}
 2 & -1 & 0 & ... & 0 & 0\\
-1 & 2 & -2 & ... & 0 & 0\\
 0 & -1 & 2 & ... & 0 & 0\\
 & & &... \\
 & & &...& 2 & -1\\
 0 & 0 & 0 & ... & -1 & 1
\end{bmatrix}
$$

This matrix is different from a circulant matrix by only three elements ( $-1$ at upper-right and lower left and $1$ at bottom), and it's provable that its eigen structure converge to the eigenstructure of the [circulant matrix](https://en.wikipedia.org/wiki/Circulant_matrix)[^3] when $T\to\infty$. We denote the exact circulant matrix as $Q$, and we denote the tridiagonal matrix without upper-right and lower left $-1$ as $P$, notice the 1 element difference between $P$ and $S^TS$ 

$$
Q=\begin{bmatrix}
 2 & -1 & 0 & ... & 0 & -1\\
-1 & 2 & -2 & ... & 0 & 0\\
 0 & -1 & 2 & ... & 0 & 0\\
 & & &... \\
 & & &...& 2 & -1\\
 -1 & 0 & 0 & ... & -1 & 2
\end{bmatrix}\\
P=\begin{bmatrix}
 2 & -1 & 0 & ... & 0 & 0\\
-1 & 2 & -2 & ... & 0 & 0\\
 0 & -1 & 2 & ... & 0 & 0\\
 & & &... \\
 & & &...& 2 & -1\\
 0 & 0 & 0 & ... & -1 & 2
\end{bmatrix}
$$

### Digression: Relation to diffusion operator

From physics to engineering, these matrix appears everywhere. What do we know about the eigenstructure of these matrices? As we know from the theory of 2nd order Partial Differential Equations (e.g. diffusion / heat equation and wave equation as below), the 2nd order derivative, or Laplacian operator has its distinct eigenfunctions -- Fourier series. As a side note, actually, analyzing heat conduction was the exact reason Fourier discovered Fourier decomposition. These eigen functions of Laplacian are the reason we see sinusoidal waves on strings and on the surface of water! 

$$
\frac{\partial u}{\partial t}=\frac{\partial^2 u}{\partial x^2}=\Delta u\\
\frac{\partial^2 u}{\partial t^2}=\frac{\partial^2 u}{\partial x^2}=\Delta u
$$

Recall from Quantum mechanics and Wave equation. An important lesson we learnt from PDE is that, the specific Fourier mode that goes into the solution depend on the boundary condition: $u(t,0)=0$ or $\partial_x u=0$  or  $\partial_t u=0$. For example when one side of rope is fixed when you perturbing it, then only $\sin$ waves mode could be in the solution. This subtle point is important as we shall see below, since the different elements between $SS^T$ and a circulant matrix $Q$ is tightly related to boundary condition. The exact circulant matrix $Q$ is the 2nd order differentiation operator on a **circular boundary condition**. 



### Eigenstructure of Circulant $Q$ 

Back to our matrix, let's translate this intuition for continuous space to discrete spaces. We will expect the eigenvectors of $S^TS$ to be also cosine and sine waves. Indeed, it's known that the [eigenvectors for circulant matrices](https://en.wikipedia.org/wiki/Circulant_matrix#Eigenvectors_and_eigenvalues) are the Fourier modes. For $T$ length sequence, the normalized complex eigenvectors and eigenvalues are as following (numbering starts from $0$. )

$$
v_k=\frac{1}{\sqrt T}[1,\omega^k,\omega^{2k},\omega^{3k},...,\omega^{(T-1)k}],\mbox{ with }\omega=\exp(\frac{2\pi i}{T})\\
\lambda_k = c_0+c_{T-1}\omega^{k}+c_{T-2}\omega^{2k}+...c_1\omega^{(T-1)k}\mbox{, with }k=0,...T-1 
$$

In our case, there are only three non-zero element in each column $c_0=2,c_1=c_{T-1}=-1$ the other terms are $0$. Thus it's easy to obtain the real eigenvalues 

$$
\begin{align}
\lambda_k(Q)&=2-\exp(2\pi i\frac{k}{T})-\exp(2\pi i\frac{(T-1)k)}{T})\\
&=2-2\cos(\frac{2\pi k}{T}),\;\; k=1,2...T\\
\end{align}
$$

We note that $\lambda_k=\lambda_{T-k}\mbox{  for  } k\neq0$ , each eigenvalue has a 2d eigenspace. This is intuitive since the matrix $Q$ is the laplacian on a circular space, we expect the eigenmodes to be rotational symmetric, thus it has two eigenvectors corresponding to $\sin$ and $\cos$ for each eigenvalue, weighted combining these two eigenvectors admit eigen functions of any phase. 

### Eigenstructure of Tridiagonal $P$ 

Next, let us consider the eigenstructure of the tridiagonal matrix $P$, its eigenvalues are less straightforward to calculate. We need to solve the eigenpolynomial directly. 

However, we are still saved, mathematicians have derived close form solution to the eigenvalues of a tri-diagonal Toeplitz matrix [^4]. For a derivation of this solution, see [my note]({{< relref "Spectrum-of-Tri-Toeplitz-matrix.md" >}})!

$$
\lambda_k(P) =2-2\cos \frac{k\pi}{T+1},k=1,...T
$$

Notice the difference from the eigenvalues of $Q$ above? There are no more repeating eigenvalues, and $\lambda=0$ is no longer a eigenvalue to this matrix, so this matrix. 

### Eigenstructure of $S^TS$  and  $CS^{-1}S^{-T}C$

Per the paper[^1], and numerical simulation we found that the eigenvalues of the matrix $CS^{-1}S^{-T}C$ also has **analytical solution**, with finite $T$ values. 

$$
\begin{align}
\lambda_k(CS^{-1}S^{-T}C) &=(2-2\cos \frac{k\pi}{T})^{-1},k=1,...T-1\\
\lambda_T(CS^{-1}S^{-T}C) &=0
\end{align}
$$


## Relating Back to PCA

So, we have talked enough about eigenvalues, how this have to do with the PCA of random walk? 

Just to recap, performing PCA to a random walk in high dimension is just performing eigen-decomposition to the covariance matrix $\Sigma[x]=CS^{-1}S^{-T}C$ . The eigenvectors are the projected coefficient on to each PC, and eigenvalues correspond to the explained variance of that PC. 

From the section above we knew the eigenvalues of the matrix $CS^{-1}S^{-T}C$ are 

$$
\begin{align}
\lambda_k =&(2-2\cos \frac{k\pi}{T})^{-1},\;\;k=1,...T-1\\
\lambda_T=&0
\end{align}
$$

Thus the explained variance of each PCs will be the following, which corrects the error version in the paper[^1] Eq.12. 

$$
\begin{align}
\rho(k)&=\frac{\lambda_k}{tr[\Sigma[x]]}\\
&=\frac{(2-2\cos\frac{k\pi}{T+1})^{-1}}{\frac16(T^2-1)}\\
&=\frac{(1-\cos\frac{k\pi}{T+1})^{-1}}{\frac13(T^2-1)}\\
\end{align}
$$

[^3]: Physical intuition is this $S^TS$​ represents the 2nd derivative operator of length $T$​ signal with zero padding or constant boundary condition; while the circulant matrix represents the 2nd derivative operator of a cyclic signal of length $T$​. This difference in boundary condition vanish for long enough $T$​.
[^4]: Borowska, J., & Łacińska, L. (2015). [Eigenvalues of 2-tridiagonal Toeplitz matrix](https://yadda.icm.edu.pl/yadda/element/bwmeta1.element.baztech-1455d930-653b-4f23-a7ad-6c9431dc8f96/c/2015_Borowska_4-art_02.pdf)  *Journal of Applied Mathematics and Computational Mechanics*, *14*(4).  See Eq. 17. 

