---
layout: post
title: Note on S4-Efficiently Modeling Long Sequences with Structured State Spaces
author: Binxu Wang
date: July  17th, 2022 
comments: true
use_math: true
published: true
categories: [algorithm, machine learning]
tags: [tech note, Algorithm, Statistical Learning, linear algebra, Dynamic System, Sequence Model]
---

![](https://github.com/HazyResearch/state-spaces/raw/main/assets/s4.png)

[TOC]



## Motivation

S4 sequence model is rising in the sequence modelling field. It dominates on long sequence modelling over RNN, LSTM and transformers. It's both mathematically elegant and useful, and it's trending, so why not write about it. 

## General State Space Model for Sequence Modeling 

To start, for neuroscientists and applied mathematicians, state space model has been a classic tool in sequence modelling. Basically, we hypothesize there is an underlying dynamic system with input that generates the observed trajectory. State space model is the case where the system is a linear dynamic system. 

The classic form is this $A,B,C,D$ formulation:

*  $x$ is the latent dynamics veriable, $u$ is the input drive, $y$ is the readout from $x$ 
* $A$ governs dynamics, $B$ transform input drive. $C,D$ specify the read out from hidden state $x$ and input $u$ 

$$
\dot x(t)=Ax(t)+Bu(t)\\
y(t)=Cx(t)+Du(t)
$$

### State space model as RNN

It's intuitve that continuous time state space model could be discretized to a discrete time dynamic system (SSM). The conversion rule from the continuous to discrete matrices could be found in appendix of HiPPO paper[^1]. 

$$
x_k=\bar A x_{k-1}+\bar Bu_k\\
y_k = \bar C x_k
$$

Basically, this discrete SSM is an iterative map or RNN. As you can imagine, iteratively applying a matrix $A$ can be slow in computation and also detrimental for gradient computation. 

### RNN as Convolution

Let's take a different view on state space model. First assume $u$ a 1-d input, and $y$ also a 1-d readout. What's the relationship between input $u$ and output $y$ ?   In this perspective, it starts to feel like a neural network layer (like transformer layer) that transforms a input signal to an output. 

In fact, the relation between $u$ and $y$ is a convolution. Assuming the latent state starts from origin $x_{-1}=0$, then we have 

$$
\begin{align}
x_0&=\bar B u_0, &y_0=&\bar C\bar B u_0\\
x_1&=\bar A\bar B u_0 + \bar B u_1,& y_1=&\bar C\bar A\bar B u_0+\bar C\bar B u_1\\
x_2&=\bar A^2\bar Bu_0 + \bar A \bar B u_1+\bar B u_2,& y_2=&\bar C\bar A^2\bar B u_0+\bar C\bar A\bar B u_1+\bar C\bar B u_2\\
\end{align}
$$

Thus the output $y$ is a convolution on the input signal $u$ with a $L$ long kernel $K=[\bar C\bar B,\bar C\bar A\bar B,\bar C\bar A^2\bar B,\bar C\bar A^3\bar B,...]$, which involves the matrix exponents from 0 to $L-1$ order of $\bar A$. 

Further, this convolution could be done in the frequency domain by FFT on $K$, using the convolution theorem for circular convolution. 



## HiPPO: Special Initialization and Parametrization for SSM

Here a special kind of state space model that found to perform extremely well, called HiPPO. 

The hidden states $x(t)$ keep track of the coefficients **when projecting the signal onto Legendre polynomial basis**. The optimal projection coefficients follow a certain dynamics, which is the ODE in the SSM model. This ODE could be discretized and the magic $A$ matrix comes from this ODE for updating projection coefficients onto some basis. 





## Efficient SSM with structured matrix $A$  

To compute the kernel for convolution, the limiting step involves raising matrix $A$ or $\bar A$ to exponent as high as the sequence length $L-1$. 

**Generating function**  First note that to compute FFT of the large Kernel $K$ we need to evaluate the generator function, which sums the values by the exponents of $z$
$$
f(z)= \bar C\bar B+z\bar C\bar A\bar B+z^2\bar C\bar A^2\bar B+z^3\bar C\bar A^3\bar B...\\
=\bar C(\sum_{i=0}^{L-1}(z\bar A)^i)\bar B\\
$$

To evaluate the $k$ th element of the FFT of the kernel, we input $\omega^k$ to the generator function. $\omega$ is the $L$ th root of unit. 

$$
\tilde K_k=f(\omega^k)=F_k^TK
$$

Thus naively to compute FFT, we need to evaluate the generator function for $F_k^T K=f(\omega^k)$ for $k=0...L$. This is a $L^2$ complexity. 

One trick to accelerate is that the sum of exponent series could be expressed by this matrix inversion. Then we can evaluate $I-\bar A^L$ once and evaluate the matrix inversion $(I-\bar A\bar z)^{-1}$ $L$ times. 

$$
\sum_{i=0}^{L-1}(z\bar A)^i=(I-\bar A^Lz^L)(I-\bar A z)^{-1}
=(I-\bar A^L)(I-\bar A z)^{-1}
$$

Thus the generating function can be abbreviated as 

$$
f(z)=\bar C\sum_{i=0}^{L-1}(z\bar A)^i \bar B=\tilde C(I-\bar A z)^{-1} \bar B
$$

Note the discrete version $\bar A,\bar B$ are

$$
\bar A =(I-\Delta A/2)^{-1}(I+\Delta A/2)\\
\bar B = (I-\Delta A/2)^{-1}\Delta B
$$

We can rewrite $f(z)$ using the original matrices $A,B$ and step size $\Delta$

$$
f(z)=2\Delta\tilde C\left(2(1-z)I-\Delta (1+z)A\right)^{-1}B
$$

> Note in the end this is a learning system with matrices to be learned. As these are different parametrizations of the same system, we don't have a ground truth value for $A,B,C$ . We can absorb complex terms to be learned instead of computed.  
> Here we can choose to learn $\tilde C$ instead of $C$ to save the matrix exponent computation. 



### Efficient Inversion with matrix structure

If the $A$ matrix has diagonal + low rank structure, we can use Woodbery identity to compute exponent and inversion easier. 

**Diagonal case** Let's first assume $A$ is diagonal matrix, then the generator function is just a dot product of the diagonal elements shifted by $z$. 

$$
f(z)=2\Delta(1+z)\tilde C\left(2\frac{1-z}{1+z}I-\Delta A\right)^{-1}B\\
f(z)=2\Delta(1+z)\sum_i\frac{\tilde C_iB_i}{2\frac{1-z}{1+z}-\Delta \Lambda_i}
$$

**Diagonal plus low rank**  Next, let's assume $A$ is a diagonal matrix plus rank 1 modification

$$
A = \Lambda - PQ^*
$$

With this modification we basically get 

$$
f(z)=2\Delta(1+z)\tilde C\left(2\frac{1-z}{1+z}I-\Delta \Lambda+\Delta PQ^*\right)^{-1}B\\
f(z)=2 (1+z)\tilde C\left(\frac 2\Delta \frac{1-z}{1+z}I-\Lambda+PQ^*\right)^{-1}B\\
$$

Using Woodbery identity, 

$$
(D+PQ^*)^{-1} = D^{-1}-\frac{D^{-1}PQ^*D^{-1}}{1+Q^*D^{-1}P}
$$

Then the scalar product 

$$
\tilde C(D+PQ^*)^{-1}B=\tilde CD^{-1}B-\frac{(\tilde CD^{-1}P)(Q^*D^{-1}B)}{1+Q^*D^{-1}P}
$$

You see, actually there is a common motif in this formula which is we called "cauchy dot product"

$$
AD^{-1}B=\sum_i\frac{A_iB_i}{D_i}
$$

In our case the cauchy dot product can be written as this 

$$
D=\frac 2\Delta \frac{1-z}{1+z}I-\Lambda = diag(\frac 2\Delta \frac{1-z}{1+z}-\lambda_i,...)
$$

Thus we define the cauchy dot operator

$$
K_{z,\Lambda}(A,B)=\sum_i\frac{A_iB_i}{\frac 2\Delta \frac{1-z}{1+z}-\lambda_i}
$$

We have 

$$
f(z)=2 (1+z)\left[K_{z,\Lambda}(\tilde C,B)-\frac{K_{z,\Lambda}(\tilde C,P)K_{z,\Lambda}(Q^*,B)}{1+K_{z,\Lambda}(Q^*,P)}\right]
$$

Note that for each $z$, the output of $K_{z,\Lambda}$ is a scalar, and $f(z)$ is a scalar. So this computation could be actually vectorized across a huge numebr of $z$ . (this could be easily done by `jax.vmap`) 

### Put it together

So to summarize the working of a S4 is like  

1. Given $z,\Lambda,P,Q,B,\tilde C,\Delta$ ,
2. Create the $K_{z,\Lambda}$ function which is used to create $f(z)$ function. 
3. Evaluate $f(z)$ at $z=\omega^i,i=0,...L-1$ to form kernel $K=[f(1),f(\omega),f(\omega^2),...]$
4. Use kernel $K$ to causal convolve input signal $y=K*u$ 
5. Use backprop to learn the parameters $\Lambda,P,Q,B,\tilde C,\Delta$ 

### RNN mode

Note that above we used a series of tricks to compute the convolution kernel for S4, this is useful in training since sequence exists. 

But in generation RNN mode is more useful, we can turn the $A,B$ paramters in to $\bar A,\bar B,C$ for generation.
$$

$$







## Reference 

* [The Annotated S4 (srush.github.io)](https://srush.github.io/annotated-s4/)

* [2008.07669 HiPPO: Recurrent Memory with Optimal Polynomial Projections ](https://arxiv.org/abs/2008.07669)



[^1]: The HiPPO paper empirically tested different discretization scheme. **Ablation: comparison between different discretization methods**, Figure 4. And bilinear discretization is much better than forward or backward Euler rule. 



