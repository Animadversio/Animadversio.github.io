---
layout: post
title: Note on Diffusion Generative Models
author: Binxu Wang
date: 2022-05-09 
comments: true
# use_math: true
math: true
# published: true
draft: false
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Generative Model]
---

* TOC
{:toc}


## Motivation

Recently, a line of research emerged in generative image models, diffusion models, which showed a competitive performance with GAN [^1]. More recently, a larger scale version of it gave rise to the ground breaking model DALL-E 2 and its precursor GLIDE. 

These tremendous success in generative modelling motivates me to write about them to understand this new type of models. This post devotes to introducing the formula underlying these models and organize the relation between different variants. 

## Practical consideration

From a user perspective, comparing to GAN, diffusion models are slower in sampling: they requires iterative denoising improvement compared to a single pass processing of GAN. Thus in a fraction of a second you could sample a batch of images (5-40) from GAN easily, but the diffusion models need at least 7-10 sec on a high end GPU to sample a batch (1-4) of images. 

However, the benefit of diffusion model is its flexibility. Usually, GANs model a fixed distribution or condition distribution. After training, one is stuck with that image distribution. Though attempts have been made to condition GAN output after training (\cite{}). 

As for diffusion models, after training, one could modulate the image output with different conditioning function (detailed below). Moreover, one could initialize diffusion from an existing image, or just modify part of an image , these features make it a flexible tool for creative art generation and iterative editing. 

# Diffusion models

## Intuition of denoising diffusion

As is eloquently put in one of Yang Song's paper opening

> Creating noise from data is easy; creating data from noise is generative modeling.  - Yang Song 2021. 

Given any sample $x$, if you iteratively adding noise to it, while properly scale down signal, then finally signal will be overwhelmed by noise and you will get Gaussian white noise. We call this noising (diffusion) process

$$
x_0\to x_1\to ...x_T
$$

However, we could revert this process, starting from a sample $x_T$ from white noise and revert the process step by step back $p(x_{t-1}\mid x_t)$ , this is called the denoising process. 

$$
x_T\to x_{T-1}\to ...x_0
$$

Thus if we properly model the conditional distribution $p(x_{t-1}\mid  x_t)$ we could define a **Markov chain**, by iteratively sample from $x_{t-1}\sim p(x_{t-1}\mid x_t)$ , and finally sample from $p(x_0)$. 

Why denoising process could model any data distribution? This notion has emerged in CV for a while. Previously, it is known that denoising autoencoder (DAE) $f(x): x+\epsilon \mapsto x$  is a form of image prior. Intuitively, you need to "know" what is noise versus signal to properly denoise. 

## Variants

**[Denoising Diffusion Probabilistic Models (DDPM)](https://arxiv.org/abs/2006.11239)** This is the fundamental paper introduced the in this recent wave. 

**[Denoising Diffusion Implicit Models (DDIM)](https://arxiv.org/abs/2010.02502)** This is a follow up version of DDPM, which is deterministic. It's used in many recent models (e.g. OpenAI [guided-diffusion](https://github.com/openai/guided-diffusion)).  

## DDPM formulation

DDPM formulate the model in a Bayesion, graphic model style, with some variational trick. 

In this formulation, we deal with the aforementioned markov chain $x_0\to x_1\to... x_T$ . Then all $x_{1:T}$ become latent variables. Consider the joint probability, which could be decomposed in forward or reverse direction. 

$$
p(x_{0:T})=q(x_0)\prod_t q(x_t\mid x_{t-1})\\
= p(x_T)\prod_t p(x_{t-1}|x_t)
$$

How to learn such a latent variable model? The key to generate data is the reverse diffusion model $p_\theta(x_{t-1}\mid x_t)$ , so we parametrize it with $\theta$ a neural network. Just like all latent variable models, we could form the lower bound of the log likelihood of the data

$$
\log p(x_0) \geq \mathbb E_q \log \frac{p(x_{0:T})}{q(x_{1:T}\mid x_0)}
$$

Then decomposing the chain with markov property we get the following. 

$$
\log p(x_0) \geq L\\ :=\mathbb E_q [\log p(x_T) +\sum_t \log p_\theta(x_{t-1}\mid x_t)-\sum_t \log q(x_t \mid x_{t-1})]
$$

Now we expressed a bound $L$ on the data log likelihood with the expectation over three terms.

* $\log p(x_T)$ which is the log density of final stage Gaussian distribution. 
* $-\sum_t \log q(x_t \mid x_{t-1})$ log density of generating this trajectory given $x_0$. Using the forward diffusion model. No neural network within. 
* $\sum_t \log p_\theta(x_{t-1}\mid x_t)$ the log density of inverse model, this requires the iterative application of the reverse diffusion model -- the neural network. 

* Finally for the expectation over $q(x_{1:T}\mid x_0)$ ,  we can sample multiple trajectories for each sample $x_0$ to Monte Carlo estimate this loss. 

To be more concrete, we control the forward diffusion process to be a gaussian with a variance schedule; and the reverse diffusion to be a Gaussian with mean controlled by a neural network $\mu_\theta$ and an isotropic variance with decaying schedule $\sigma_t^2$. 

$$
q(x_t\mid x_{t-1})=\mathcal N(x_t;\sqrt{1-\beta_t} x_{t-1},\beta_t I)\\
p(x_{t-1}\mid x_t)=\mathcal N(x_{t-1};\mu_\theta(x_t),\sigma_t^2 I)\\
$$

Note that in this formulation, the conditional distribution of $x_t$ has a closed form. To abbreviate the notation, introduce $\alpha_t =1-\beta_t,\bar \alpha_t = \prod_{s=1}^t \alpha_s$. As we can see $\bar \alpha_t$ gradually approaches $0$ and noise dominates. 

$$
q(x_t\mid x_0)=\mathcal N(x_t\mid \sqrt{\bar \alpha_t}x_t,(1-\bar \alpha_t)I)
$$


## Score-based model and Langevin dynamics 

An alternative, more theoretical and more geometrical formulation is the score based modelling approach. 

Let's think about the data distribution to be modelled as $p(x)$. We focus on its score, i.e. gradient to the log likelihood function $\nabla_x \log p(x)$. In plain language, the score function described, locally **how you shall modify $x$ to make the likelihood higher**. 

So, if we have this gradient information in hand, we could create samples with high likelihood by gradient ascent. 

$$
x=\arg\max_x\log p(x)
$$

Specifically, to implement the optimization, we use **Langevin dynamics**, which could be called **noisy gradient ascent** or **diffusion process under the guidance by an energy landscape**. 

$$
x\gets x+\epsilon \nabla_x\log p(x)+\sqrt{2\epsilon} z\\
z\sim \mathcal N(0,I)
$$

The noise term shall be tuned to reduce over time for convergence (annealing). 

In practise, since the exact score function is missing, what we need is to approximate the score function with a model $s_\theta (x)$, then do Langevin dynamics with it. This Langevin dynamics is the *de facto* reverse diffusion process. 

### How to train score-based models?

So how to train score model? It seems insanely hard! we only have access to a discrete set of points $\{x_i\}$ how to get gradient information.

One way to deal with it is the gradual noising method (NCSM)





Given an unconditional dataset $\{x_i\}$ sampled from distribution $p(x)$ , how to train this denoising model?

Usually this denoising score-matching objective is used
$$
\int_{t=0}^1\mathbb E_{x\sim p(x)} \mathbb E_{x'\sim p(x_t|x_0=x)}
\lambda(t) \|\nabla_{x'}\log p_{0t}(x'|x)-s(x',t)\|
$$
This denoising score matching objective could be derived for any distribution with any noising kernel. Here with Gaussian Kernel, the formulation becomes more explicit. 

See  [equivalence of score matching objective](Note-on-Equiv-Score-Matching-Objective.md) for the derivation. 

# Related Models

## Relation to score-based model

Basically, score-based model using a sequence of decreasing noising scale, and denoising diffusion probabilistic models are both discretizations of a family of SDEs. 

These two lines are developed independently and in the end pointed at the same underlying model, which is remarkable.  	

> Collectively, these latest developments seem to indicate that both score-based generative modeling with multiple noise perturbations and diffusion probabilistic models are different perspectives of the same model family, much like how [wave mechanics](https://en.wikipedia.org/wiki/Wave_mechanics) and [matrix mechanics](https://en.wikipedia.org/wiki/Matrix_mechanics) are equivalent formulations of quantum mechanics in the history of physics.
> The perspective of score matching and score-based models allows one to calculate log-likelihoods exactly, solve inverse problems naturally, and is directly connected to energy-based models, Schrödinger bridges and optimal transport. The perspective of diffusion models is naturally connected to VAEs, lossy compression, and can be directly incorporated with variational probabilistic inference. 
>
> -- yang song blog. 

## Relation to flow and neural ODE.

The SDE could be re-written as an ODE, which retains the same marginal distribution at each step. With the score network, this is an instance of Neural ODE. 



## Relation to Activation Maximization

This framework is really reminiscent of the activation maximization framework frequently used to do feature visualization. What's the relation between these two lines of thoughts? 





## Reference

* The great [Blogpost](https://yang-song.github.io/blog/2021/score/) by one main author Yang Song, walk through the development from the score-based model / score matching, SDE perspective. More theoretically motivated. 
* The other great blog post by Lili Weng, introduced the matter from the diffusion model perspective: [What are Diffusion Models?  Lil'Log](https://lilianweng.github.io/posts/2021-07-11-diffusion-models/)
* Details for deriving the reverse time diffusion equation (the basis of generative models): [REVERSE TIME STOCHASTIC DIFFERENTIAL EQUATIONS [FOR GENERATIVE MODELLING]](https://ludwigwinkler.github.io/blog/ReverseTimeAnderson/)
  * This the detailed derivation of the     
    Anderson, B. D. (1982). [Reverse-time diffusion equation models](https://www.sciencedirect.com/science/article/pii/0304414982900515). *Stochastic Processes and their Applications*, *12*(3), 313-326. 

