

## Motivation 

When you think about random walks, what shape do you think about? 

Is it like this? Or this? 

These are good examples of random walks in two or three dimensions. But what about random walks in higher dimensions? 

## Formulation

We first define the simplest case, a random walk in a $d$ dimensional space $\mathbb R^d$, i.e. continuous space, discrete time. For each time step, it took a step $\eta_i$ i.i.d. sampled from a "zero-mean and finite covariance" distribution $\mathcal P$, with $x_i,\eta_i\in \mathbb R^d$

$$
x_{i+1}=x_i+\eta_i\;, \eta_i\sim\mathcal P
$$

Now we consider the trajectory $\{x_1,x_2...x_T\}$ formed by the random walk of $T$ step. We could compute the PCA of this trajectory based on its covariance matrix $C_{i,j}=cov(x_i,x_j)$.  

As a convention, we use row vectors for $x_i,\eta_i$ then we form the $T$-by-$d$ data matrix $X=[x_1;x_2;x_3...x_T]$. 

How to compute this covariance matrix? The paper [^1] found a trick to compute the covariance matrix. First it noticed that 

$$
SX=\Eta\\
S=\begin{bmatrix}
 1 & 0 & 0 & ... & 0 & 0\\
-1 & 1 & 0 & ... & 0 & 0\\
 0 &-1 & 1 & ... & 0 & 0\\
 ... \\
 ... \\
 0 & 0 & 0 & ... & -1 & 1
 
\end{bmatrix}
$$