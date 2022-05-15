---
layout: post
title: Note on Diffusion Generative Models
author: Binxu Wang
date: May 9th, 2022 
comments: true
use_math: true
published: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Generative Model]
---

* TOC
{:toc}


## Motivation

Recently, a line of research in generative image models, diffusion models, emerged, which showed a competitive performance with GAN [^1]. Moreover, a modern version gave rise to the ground breaking model DALL E 2 and its precursor GLIDE. 

These tremendous success in generative modelling motivates me to write about them to understand this new type of models. This post devotes to introduce the formula underlying these models and organize the relation between different variants. 

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
Thus if we properly model the conditional distribution $p(x_{t-1}\mid  x_t)$ we could define a **Markov chain**, by iteratively sample from $x_{t-1}\sim p(x_{t-1}\mid x_t)$ and one could sample from $p(x_0)$. 

In some sense this is using a sequence of maps to transform a Gaussian distribution to any distribution you'd like to model. 

## Formalism

**[Denoising Diffusion Probabilistic Models (DDPM)](https://arxiv.org/abs/2006.11239)** This is the fundamental paper introduced the in this recent wave. 





**[Denoising Diffusion Implicit Models (DDIM)](https://arxiv.org/abs/2010.02502)** This is a follow up version of DDPM, which is deterministic. It's used in many recent models (e.g. OpenAI [guided-diffusion](https://github.com/openai/guided-diffusion)).  







## How to train thee

Given an unconditional dataset $\{x_i\}$ sampled from distribution $p(x)$ , how to train this denoising model?



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

