

## Motivation 

When you think about random walks, what shape do you think about? 

Is it like this? Or this? 

These are good examples of random walks in two or three dimensions. But what about random walks in higher dimensions? 

## Formulation

We first define the simplest case, a random walk in a $d$ dimensional space $\mathbb R^d$, i.e. continuous space, discrete time. For each time step, it took a step $\eta_i$ i.i.d. sampled from a "zero-mean and finite covariance" distribution $\mathcal P$, with $x_i,\eta_i\in \mathbb R^d$

$$
x_{i}=x_{i-1}+\eta_i\;, \eta_i\sim\mathcal P
$$

Now we consider the trajectory $\{x_1,x_2...x_T\}$ formed by the random walk of $T$ step. We could compute the PCA of this trajectory based on its covariance matrix $C_{i,j}=cov(x_i,x_j)$.  

As a convention, we represent $x_i,\eta_i$ as row vectors, then we form the $T$-by-$d$ data matrix $X=[x_1;x_2;x_3...x_T]$, further we set $x_0=[0,0,...0]$, s.t. $x_1=\eta_1$. Similarly we could form a $T$-by-$d$ matrix of steps $\Eta=[\eta_1;\eta_2;\eta_3...\eta_T]$

### Reduce Data Matrix to Stetps

How to compute this covariance matrix? The paper [^1] noticed that it was easier to tackle $\Eta$ than $X$. First they noticed the relationship between the data matrix $X$ and the matrix, where $S$ is the matrix of "differentiation" between rows. 
$$
SX=\Eta\\
S=\begin{bmatrix}
 1 & 0 & 0 & ... & 0 & 0\\
-1 & 1 & 0 & ... & 0 & 0\\
 0 &-1 & 1 & ... & 0 & 0\\
 & & &... \\
 & & &...& 1 & 0\\
 0 & 0 & 0 & ... & -1 & 1
\end{bmatrix}
$$

Then we know the inverse of this, $S^{-1}$ is the matrix of "accumulation" rows, i.e. the lower triangular matrix filled with $1$.  
$$
X=S^{-1}\Eta\\
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
\Sigma[x]=\mathbb E[\hat X \hat X^T]=\mathbb E[CS^{-1}\Eta\Eta^TS^{-T}C]
$$
Note that $C,S$ are constant matrix, and $C$ is symmetric, the only random variables are $\Eta$. Thus we only need to compute the expectation for $\Eta \Eta^T$. 

### Covariance of Steps $\Eta $

Since we assumed the steps $\eta_i$ were taken i.id. from the same distribution $\mathcal P$, then it's simple to compute elements of $\Eta\Eta^T$, using the linearity of inner product and independence. ($\eta_i^{(k)}$ represent the $k$th component of the row vector $\eta_i$). The expectation of each component vanish, since we assume the distribution $\mathcal P$ has zero mean, 
$$
\mathbb E[\eta_i\eta_j^T]=\mathbb E[\sum_k^d \eta_i^{(k)}\eta_j^{(k)}]\\
=\sum_k^d \mathbb E[\eta_i^{(k)}]\mathbb E[\eta_j^{(k)}]\\
=0\mbox{, }i\neq j
$$
Similarly, we can evaluate the diagonal values. Since the distribution $\mathcal P$ has a finite covariance, the diagonal values are the trace of its covariance matrix. Without loss of generality, we can assume $\tr[\Sigma(\mathcal P)]=1$, by just rescaling $x$.  
$$
\mathbb E[\eta_i\eta_i^T]=\mathbb E[\sum_k {\eta_i^{(k)}}^2]\\
=\sum_k^d \mathbb E[{\eta_i^{(k)}}^2]\\
=\sum_k^d Var[\eta^{(k)}]\\
=\tr[\Sigma(\mathcal P)]
$$
Thus we have 
$$
\mathbb E[\Eta\Eta^T]=\tr[\Sigma(\mathcal P)]I=I
$$


What does this tell us? Geometrically this means, when we sample from a zero mean, finite variance distribution, the vectors are **expected** to be orthogonal to each other, with the norm of each vector equal to the trace of the covariance matrix. This is necessarily true for all dimension $d$. However, the magic is, when $d$ gets high, the empirical covariance $\Eta\Eta^T$ converged arbitrarily close to the expected value $I$. Thus we have, at high dimension, randomly sampled step vectors are orthogonal to each other with high probability. 
$$
\Eta\Eta^T\to I\mbox{, with d high}
$$
With this approximation, the covariance matrix becomes a constant $T$-by-$T$ matrix. 
$$
\Sigma[x]=CS^{-1}S^{-T}C
$$
From this we can already see, the covariance structure of high dimensional random walk is **universal**, independent of the distribution $\mathcal P$ where steps are sampled from [^2], even independent of the dimension $d$.  

[^2]: Note that this is the $T$-by-$T$ covariance matrix, it's structured is independent of $\mathcal P$, thus the projected trajectories are independent of $\mathcal P$. However, this does not mean the PC axes i.e. the right singular vectors of $\hat X$ in $n$ dimensional space is independent of $\mathcal P$.

### Eigen Structure of Circulant Matrix 

Finally let's analyze the eigen structure of $CS^{-1}S^{-T}C$. Since $S^TS$ is a real symmetric matrix, we can analyze it's eigenvalue and eigenvectors, and $(S^TS)^{-1}$ will share the same eigenvectors with inverted eigenvalues. 

By calculation or intuition ($S$ as row differentiation operator ), $S^TS$ manifests itself as a center difference (2nd order differentiation) matrix on a grid formed by $T$ points. From physics and engineering these matrix appears everywhere 
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
\end{bmatrix}
=\begin{bmatrix}
 2 & -1 & 0 & ... & 0 & 0\\
-1 & 2 & -2 & ... & 0 & 0\\
 0 & -1 & 2 & ... & 0 & 0\\
 & & &... \\
 & & &...& 2 & -1\\
 0 & 0 & 0 & ... & -1 & 2
\end{bmatrix}
$$
This matrix is different from circulant matrix by only two elements ( $-1$ at upper-right and lower left), and it's provable that its eigen structure converge to the eigenstructure of the [circulant matrix](https://en.wikipedia.org/wiki/Circulant_matrix)[^3]. 

What do we know about the eigenstructure of these matrices? As we know from the theory of Partial Differential Equations (e.g. diffusion / heat equation and wave equation as below), the 2nd order derivative, or Laplacian operator has its distinct eigenfunctions -- Fourier series. 
$$
\frac{\partial u}{\partial t}=\frac{\partial^2 u}{\partial x^2}=\Delta u\\
\frac{\partial^2 u}{\partial t^2}=\frac{\partial^2 u}{\partial x^2}=\Delta u
$$
Actually, analyzing heat conduction was the exact reason Fourier discovered Fourier decomposition. These eigen functions of Laplacian are also the exact reason we see sinusoidal waves on strings and on the surface of water. 

Back to our matrix, if this intuition for continuous space holds for discrete spaces, we will expect the eigenvectors of $S^TS$ are also cosine and sine waves. Indeed, it's known that the [eigenvectors for circulant matrices](https://en.wikipedia.org/wiki/Circulant_matrix#Eigenvectors_and_eigenvalues) are the Fourier modes. For $T$ length sequence, the normalized complex eigenvectors and eigen values are as following (numbering starts from $0$. )
$$
v_j=\frac{1}{\sqrt T}[1,\omega^j,\omega^{2j},\omega^{3j},...,\omega^{(T-1)j}],\mbox{ with }\omega=\exp(\frac{2\pi i}{T})\\
\lambda_j = c_0+c_{T-1}\omega^{j}+c_{T-2}\omega^{2j}+...c_1\omega^{(T-1)j}
$$
In our case, $c_0=2,c_1=c_{T-1}=-1$ the other terms are $0$. Thus it's easy to obtain the real eigenvalues 
$$
\lambda_j=2-\exp(2\pi i\frac{j}{T})-\exp(2\pi i\frac{(T-1)j)}{T})\\=2-2\cos(\frac{2\pi j}{T})\\
$$
Similarly, the real eigenvectors are 





[^3]: Physical intuition is this $S^TS$ represents the 2nd derivative operator of length $T$ signal with zero padding or constant boundary condition; while the circulant matrix represents the 2nd derivative operator of a cyclic signal of length $T$. This difference in boundary condition vanish for long enough $T$.

