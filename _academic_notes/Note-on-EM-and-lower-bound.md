---
layout: post
title: Note on EM algorithm and likelihood lower bound
author: Binxu Wang
date: May 13th, 2022
use_math: true
comments: true
categories: [algorithm, machine learning]
tags: [tech note, Bayesian, Statistical Learning, MLE]
---

## Motivation

How to understand EM algorithm from a theoretical perspective? This post tries to understand EM as a form of alternative ascent of a lower bound of likelihood. 

## The Key Trick of EM

The key trick we need to remember is the usage of **Jensen Inequality** on logarithm. So we could swap Expectation and logarithm and obtain a lower bound on likelihood. Generally, we have such inequality, given a positive function $q(z)$ that sums to $1$ (probability density), 
$$
\log \sum_z p(z)=\log \sum_zq(z)\frac{p(z)}{q(z)}\geq \sum_zq(z) (\log p(z)-\log q(z))
$$
This form is particularly useful when we have a latent variable model. Since we are interested in the likelihood of data itself $\log p(x)$ the latent variable part needs to be integrated out. 
$$
\log \int_zp(x|z)p(z) \geq \int_z q(z)\log\frac{p(x|z)p(z)}{q(z)}\\
=\mathbb E_{z\sim q(z)} [\log p(x|z) + \log p(z) - \log q(z)]
$$
This tricky is the foundation of variational inference. However, this still feels distant from the common formulation of EM. The distinctive feature of EM is that it could optimize $q(z)$ in one step: by setting $q(z)=p(z|x)$ , then without any optimization iteration, you could tighten the bound and optimize the probe distribution $q$ . 

## Example: Gaussian Mixture

To make it concrete, let's take a simple example, Gaussian mixture models let observed variable $X$, discrete latent variable $Z$ and parameters $\Theta$. 

$$
P(Z=k;\Theta)=\pi_k\\
P(X\mid Z=k;\Theta)=\mathcal N(\mu_k,\Sigma_k)
$$

Then the likelihood function is the summation over dataset $x\in D$

$$
\log\mathcal L(\Theta)=\sum_i \log P(x_i;\Theta)=\sum_i \log \sum_k P(x_i\mid z=k;\Theta)P(z=k;\Theta)
$$

As a trick, we use an arbitrary distribution over latent variables $q(z)$ to probe it 

$$
\log\mathcal L(\Theta)=\sum_i \log \sum_k q(z=k)\frac{ P(x_i\mid z=k;\Theta)P(z=k;\Theta)}{q(z=k)}\\
\geq\sum_i \sum_k q(z=k) \log \frac{ P(x_i\mid z=k;\Theta)P(z=k;\Theta)}{q(z=k)}
$$

In the 2nd line, the swap of $\log$ and $\sum$ comes from Jensen Inequality, with $\log$ a concave function and $q(z)$ probability summing to $1$. Since $z$ is discrete, function $q(z)$ is just a vector $q$. 

Let's call the lower bound $J(q,\theta)$, then the EM algorithm is maximizing it alternatively, 

* E step $q^{(t)}\gets \arg\max_q J(q,\Theta^{(t)})$
* M step $\Theta^{(t+1)}\gets \arg\max_\Theta J(q^{(t)},\Theta)$

In classic formulation, E step estimate the posterior of $Z$ given $X$ and current $\Theta$. To see the connection, I claim, $q(z)=p(z\mid x;\Theta^{(t)})$ solve the maximization problem $\arg\max_q J(q,\Theta^{(t)})$. 

To prove this, we show that the posterior makes the aforementioned bound tight. When $q(z)=p(z\mid x;\Theta)\\$

$$
\log p(x;\Theta) = \log \sum_z p(x,z;\Theta) \\
\geq \sum_z q(z)\log \frac{p(x,z;\Theta)}{q(z)}\\
=\sum_z p(z\mid x;\Theta) \log \frac{p(x,z;\Theta)}{p(z\mid x;\Theta)} \\
=\sum_z p(z\mid x;\Theta) \log p(x;\Theta)\\
=\log p(x;\Theta)
$$

which is tight. This shows that $p(z\mid x;\Theta)=\arg\max_q J(q,\Theta^{(t)})$. As we said, this maximization could be done in closed form without iteration. 

Similarly in M step, retaining only terms related to $\Theta$

$$
J(q^{(t)},\Theta)\\
=\sum_i \sum_k q_i(z=k) (\log P(x_i\mid z=k;\Theta)+\log P(z=k;\Theta)-\log q_i(z=k))\\
=\sum_i \sum_k q_i(z=k) (\log P(x_i\mid z=k;\Theta)+\log P(z=k;\Theta))+const 
$$

Which is a weighted MLE, for basic distributions like Gaussian it's also solvable in one step in closed form. 

Using Gaussian as example, abreviating $q_i(z_k)=q_{ik}$

$$
LHS=\sum_i \sum_k q_{ik}(-\frac 12\log \det\Sigma_k  -\frac 12(x_i-\mu_k)^T\Sigma_k^{-1}(x_i-\mu_k) + \log \pi_k)+const
$$

Optimizing w.r.t. $\Sigma_k,\mu_k,\pi_k$ all have closed form solution. No gradient iteration is needed. 

All in all, EM solve subproblem of part of variables alternatively, but each subproblem could be maximized to global maxima without iteration.  

## Compare EM and Gradient Descent

* One way to think of the EM algorithm is that it's doing coordinate ascent/descent on a surrogate, i.e. a **lower bound of likelihood**. (your textbook also showed this point on P396) It optimizes one set of variables and then the other set of variables, alternatively. However, **for each set of variables the optimization problem has a closed-form global maximum**, which could be optimized without iteration. 
* In contrast, gradient descent optimizes the likelihood directly. It optimizes all variables jointly but always takes local optimization steps. Even for part of the quadratic problem grad descent could be slow to converge, not to mention hard multi-modal problems.

----

## Issues of EM

That being said, EM has its own problem
* Note that, EM directly optimizes the lower bound of $\mathcal L(\Theta)$. the bound is tight only when $q(z)=P(z\mid x;\Theta)$, so when $z$ itself has a complex posterior distribution (not a simple discrete distr.), then parametrizing it and optimizing it becomes tricky. For example, one could use a Gaussian distribution to approximate the posterior, but when this approximation is not exact, EM iteration is not guaranteed to increase the data likelihood. 

**Reference**
* [Short Lecture note from Princeton](https://www.cs.princeton.edu/courses/archive/spring08/cos424/scribe_notes/0311b) which I found most illuminating!
* [Lecture slides from U Toronto](https://www.cs.toronto.edu/~jlucas/teaching/csc411/lectures/lec15_16_handout.pdf) longer but quite hand holding
* [EM and variational inference](https://chrischoy.github.io/research/Expectation-Maximization-and-Variational-Inference/)
* Bishop's [PRML](https://www.microsoft.com/en-us/research/people/cmbishop/prml-book/) 

* This post is adapted from [my answer in math exchange](https://math.stackexchange.com/questions/4444592/em-algorithm-vs-gradient-descent/4450007#4450007)

