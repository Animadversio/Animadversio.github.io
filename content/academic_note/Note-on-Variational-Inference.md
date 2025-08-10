---
layout: post
title: Note on Variational Inference (Updating)
author: Binxu Wang
date: July 27th, 2020
comments: true
use_math: true
published: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Graph Model, Bayesian, Variational, Probabilistic Programming]

---

* TOC
{:toc}


# Philosophy

The spirit of Variational Inference is to solve Bayesian inference problem with optimization. 

In the scenario of latent factor 

It's not trying to use Bayes rule directly, but to fit this distribution within a class of distributions $q(z;\nu)$, by minimizing the KL-divergence between the 2 models. 
$$
p(z\mid x)=\frac{p(z,x)}{\sum_z p(z,x)}\\
\nu^*=\arg\min_\nu KL(q(z;\nu)\|p(z\mid x))\\
p^*(z) = q(z;\nu^*)
$$
In the modern case, the $q(z;\nu)$ can be a properly normalized neural network. And one key task is to make the optimization stochastic (i.e. solvable by stochastic gradient descent) thus distributable at large scale. 



Note, many of the work using Variational Inference can be interpreted and stated in other language, like geometry or algebra. But bayesian statistics is also an important interpretation that can provide orthogonal intuition to other methods. 

# Mean Field VI

## Example: Latent Dirichlet Allocation, LDA

Problem: Find a . (it's a mixed membership model.)

You want to know the posterior distribution of $p(topic\mid document)$  however, computing the marginal distribution is intractable. 
$$
p(topic\mid document) =\frac{p(topic,doc)}{\sum_z p(topic,doc)}
$$
We can represent the model as a graphic model. 



Here we use exponential family as the space of distribution to search in. 

## Evidence Lower Bound

Note that the exact KL requires knowledge of $p(z\mid x)$ but we don't have it, so we optimize a lower bound of evidence. ELMO. 
$$
KL(q(z;\nu)\|p(z\mid x))=\mathbb E_q \log\frac{q(z;\nu)}{p(z\mid x)}=\mathbb E_q \log q(z;\nu) -\mathbb E_q \log p(z\mid x)
$$

$$
\mathbb E_q \log p(z\mid x) =\mathbb E_q\log\frac{p(z,x)}{p(x)} =-\log p(x)+\mathbb E_q \log p(z,x)
$$

$$
\log p(x)=\mathbb E_q \{\log p(z,x) -\log q(z;\nu)\} + KL(q(z;\nu)\|p(z\mid x))
$$

Note taking Expectation using $q$ distribution means $\mathbb E_q\phi(z)=\int_zq(z;\nu)\phi(z)$  . 

Thus the actual thing being maximized is this. First term maximizing the mass on the observed $p(z;x)$, second term optimize the entropy of $q$ to make it broader. 
$$
\mathcal L(\nu) =\mathbb E_{q(.;\nu)} \{\log p(z,x) -\log q(z;\nu)\}
$$
Note without gradient trick this can still work for many classical models with conjugacy in mind. 



The next trick is for gradient, (log expectation trick)
$$
\nabla_\nu \mathcal L(\nu)=\nabla_\nu\mathbb E_{q(.;\nu)} \{\log p(z,x) -\log q(z;\nu)\}\\
=\mathbb E_q\nabla_\nu \log q(z;\nu)\{\log p(z,x) -\log q(z;\nu)+1\}
$$
Using this trick we can switch gradient inside expectation, thus we can sample $z$ and compute gradient and estimate gradient in a batch, this allows VI to be applicable to complex modern models. 

Refer to a great [Tutorial in EdwardLib](http://edwardlib.org/tutorials/klqp). 



Note that Variational Information Maximization has a similar method. 



## Mean Field Simplification

Limit the family of distribution to the case that are "conditionally" independent.

In this LDA problem,  $\beta$ is the global variable to be inferred, and $z_i$ are the local hidden variables. So mean field assumption is the local variables are independent to each other after conditioning on $\beta$ 
$$
p(\beta,z,x)=p(z)\prod_i p(z_i,x_i\mid\beta)
$$


## Stochastic VI

> It's just using SGD to solve VI. 

* Use cheap, estimates of gradient instead of accurate one. 
  * But the estimate should be unbiased.
  * Sampling from the dataset distribution suffices this. 
* Decrease the step size gradually to converge. 
  * Adam, RMS etc. 

## Reference

* [Tutorial on NIPS 2016](https://www.youtube.com/watch?v=ogdv_6dbvVQ&t=1674s) 
* [InfoGAN](https://arxiv.org/abs/1606.03657): Apply Variational Information Maximization to unsupervised GAN learning 
* [VIME](https://arxiv.org/abs/1605.09674): Apply Variational Information Maximization to exploration in RL agent learning. Cf. Curiosity driven learning
* Edward Tutorials http://edwardlib.org/tutorials/