---
layout: post
title: Probabilistic Models of Neural Population
author: Binxu Wang
date: 2022-04-16
# use_math: true
math: true
comments: true
categories: [algorithm, mathematics, neuroscience]
tags: [statistics, EM, neuro-model, Bayesian, Statistical Learning]
typora-copy-images-to: ..\assets\img\notes\probmodel

---

## Motivation

Here we summarize a few common probabilistic neural population models. Adapted from reading notes and class presentations from Neuro QC316 taught by Jan Drugowitsch. 



## LNP, GLM

These are the simplist models of neurons. 

$$
z= \exp(k^Tx)\\
y\sim Poisson(z)
$$

To fit these model, we use maximum likelihood (MLE), or maximum a posteriori (MAP) given a prior of $k$. 

$$
\arg\max_k\mathcal L(k|y,x)
$$

**Remarks**

* This Generalized linear model has convex likelihood function with unique solutions.
* If the $x$ is distributed isotropically, then this MLE estimate of $k$ will align with spike triggered average $\sum_i y_ix_i$ 



## Latent Variable Models

In the next few sections, the models will all have a similar format $x\to z\to y$ or $z\to y$ , namely there will be some latent variables that are not input and not output -- not observed. 

For these models, a common strategy is to use Expectation Maximization. It's a way to perform MLE over the latent states $z$ and the parameter of the model $\theta$ jointly. The optimization is performed alternatively, aka coordinate descent or maximization-maximization procedure . 

### Formal Procedure

Consider model $z\to y$, we have a parametric generative model given any $z$, $p(y\mid z)$ with $\theta$. 

**Expectation** : Then given an observation $y$, we can estimate the distribution of the latent assuming a fixed paramter $\theta$ 

$$
p(z\mid y)=\frac{p_\theta(y\mid z)p_\theta(z)}{p(y)}
$$

**Maximization** : Using this distribution $p(z\mid y)$, we can estimate the parameters by MLE, this step is as if we know the input data to $y$ then we can use the normal method to estimate $\theta$. 

Formally, this is maximizing the "expected" likelihood function. 

$$
\mathbb E_{p(z\mid y)} [\log\mathcal L(\theta;y,z)]
$$

### Remark

* Exact EM algorithm will increase the marginal likelihood of observed data $p(y)$ so it will converge, but not necessarily to global maxima. Thus multiple restart is needed; and a nice initialization could help! 
* Approximate EM algorithm is not guanranteed to converge! If you use gaussian approximation or other approximations for $p(z\mid y)$ etc. 



<!--## HMM-->

<!--**Latent state**: Markov chain-->

<!--**Observation**: Linear readout--> 





## State Space Model 

**Latent state**: a $p$ dimension linear dynamic system 

**Observation**: a linear readout and Generalized linear model with Poisson 





## GPFA

**Latent state**: gaussian processes 

* $p$ independent GPs with different time scales

**Observation**: a linear readout $C$ with a indevidual neuron based variance $R$



Thus the whole model is a joint multivariate Gaussian. 

To learn these models, we use **Expectation Maximization** . 





## LFADS

**Latent state**: Recurrent neural network

**Observation**: Linear readout 



To learn these models, we use gradient descent training on datasets. 
