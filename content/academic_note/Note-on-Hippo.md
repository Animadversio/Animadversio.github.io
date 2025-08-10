---
layout: post
title: Note on Hippo- Recurrent Memory with Optimal Polynomial Projection
author: Binxu Wang
date: 2022-07-25 
comments: true
# use_math: true
math: true
# published: true
draft: false
categories: [algorithm, machine learning]
tags: [tech note, Algorithm, RNN, Recurrent, Memory, linear algebra, Dynamic System, Sequence Model]
---

## Hippo: Recurrent Memory with Optimal Polynomial Projection

## Motivation

Hidden state in RNN represents a form of memory of the past. For a sequence, a natural way to represent the past sequence is to project it onto an orthonormal basis set. Here depending on the different emphasis of the past, we could define different measures on the time axis and define the basis set based on this measure. Then we can keep track of the projection coefficient on this basis when observing new data points. 

## Problem setup

Given a measure in the time domain $\mu_t$ that changes through time, and a optimal polynomial $\{g_n\},n=1...t$ defined with respect to this measure $\mu_t$ . What's the dynamics for online updates for the projections?

$$
\lang f_{\leq t},g_n^{(t)}\rang_{\mu^{(t)}}
$$

## Example: Legendre Polynomial

Legendre polynomial $P_n(x)$ is defined w.r.t. a uniform measure on the domain $[-1,1]$. The normalization is 

$$
\frac{2n+1}{2}\int_{-1}^1P_n(x)P_m(x)dx=\delta_{mn}
$$

By simply shifting and scaling it we can obtain an orthogonal polynomial on $[0,t]$

$$
(2n+1)\int_{0}^1P_n(2x-1)P_m(2x-1)dx=\delta_{mn}\\
(2n+1)\int_{0}^tP_n(\frac{2x}{t}-1)P_m(\frac{2x}{t}-1)\frac 1tdx=\delta_{mn}\\
$$

Thus we have the normalized Legendre basis set for $[0,t]$

$$
g_n^{(t)}(x)=(2n+1)^{1/2}P_n(\frac{2x}{t}-1)
$$

Assume our measure a uniform measure over $[0,t]$

$$
\mu^{(t)}(x)=\frac 1 t(\theta_t(x)-\theta_0(x))
$$

$\theta_t$ is the step function at $t$, then we have 

$$
\lang g_n^{(t)},g_m^{(t)}\rang_{\mu^{(t)}}=\delta_{mn}
$$


## Dynamics of Coefficients

$$
c_n(t)=\lang g_n^{(t)},f\rang_{\mu^{(t)}}\\
=\int f(x)g_n^{(t)}(x)\mu^{(t)}(x)dx
$$

With differentiation 

$$
\frac {dc_n(t)}{dt}=\int f(x)\frac {d }{dt}g_n^{(t)}(x)\mu^{(t)}(x)dx\\
+\int f(x)g_n^{(t)}(x)\frac {d }{dt}\mu^{(t)}(x)dx\\
$$

$$
\frac {dc_n(t)}{dt}=(2n+1)^{1/2}[\int_0^t \frac 1t f(x)\frac {d }{dt}P_n(\frac{2x}t-1)dx \\
+\int f(x)P_n(\frac{2x}t-1)\frac {d }{dt}(\frac 1t(\theta_t-\theta_0))dx] \\
$$

Evaluating the derivatives, then 

$$
(2n+1)^{-1/2}\frac {dc_n(t)}{dt}=\int_0^t \frac 1t f(x)\frac {-2x}{t^2}P_n'(\frac{2x}t-1)dx \\
+\int f(x)P_n(\frac{2x}t-1)\frac {-1}{t^2}(\theta_t-\theta_0))dx \\
+\int f(x)P_n(\frac{2x}t-1)(\frac 1t \delta_t)dx \\
$$

$$
LHS=
\frac {-1}{t^2}\int_0^t f(x)\left(P_n(\frac{2x}t-1)+\frac {2x}t P_n'(\frac{2x}t-1)\right)dx \\
+\frac 1t f(t)P_n(1) \\
$$

We can use the recursion relationship of Legendre polynomial

$$
(z+1)P'_n(z)=nP_n+(2n-1)P_{n-1}+(2n-3)P_{n-2}
$$

Then let $z=2x/t-1$

$$
P_n(\frac{2x}t-1)+\frac {2x}t P_n'(\frac{2x}t-1)\\
=P_n(z)+(z+1)P'_n(z)\\
=(n+1)P_n+(2n-1)P_{n-1}+(2n-3)P_{n-2}+...\\
=(n+1)(2n+1)^{-1/2}P_n+(2n-1)^{1/2}g_{n-1}+(2n-3)^{1/2}g_{n-2}+...\\
$$

Putting the recursion back to LHS, 

$$
LHS=\frac 1t f(t)\\
-\frac 1t \lang f,(n+1)P_n+(2n-1)P_{n-1}+(2n-3)P_{n-2}+...\rang
$$

Since the inner product is the projection coefficients $c_n(t)$ at current time $t$ 

$$
LHS=\frac 1t f(t)\\
-\frac 1t \left((2n+1)^{-1/2}(n+1)c_n(t)+(2n-1)^{1/2}c_{n-1}(t)+(2n-3)^{1/2}c_{n-2}(t)+...\right)
$$

Putting it all together we have the linear dynamic equation of the coefficient vector $c(t)$ .

$$
\frac {dc(t)}{dt}=-\frac 1tAc(t)+\frac 1tBf(t)
$$

In which 

$$
A_{nk}=\begin{cases}
      \sqrt{(2n+1)(2k+1)}, & \text{if}\ n>k \\
      n+1, & \text{if}\ n=k \\
      0, & \text{if}\ n<k \\
    \end{cases}\\
 B_n=(2n+1)^{1/2}
$$
