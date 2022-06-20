---
layout: post
title: Note on Equivalent Score Matching Objective
author: Binxu Wang
date: June 20th, 2022 
comments: true
use_math: true
published: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Generative Model, probability]
---

* TOC
{:toc}




## Motivation

Consider a distribution $p(x)$, we could "convolve" it with a kernel $p(\tilde x|x)=q(\tilde x-x)$. Note the distribution of $\tilde x$ as $p_\sigma(\tilde x)$

Then we would like to prove the equivalence of the two objectives in the sense of they share the same optimality with respect to $\psi_\theta$ 

## Formulation

The score-model $\psi_\theta$ with the following objective  **"Explicit Score matching objective"**
$$
J(\theta)=\mathbb E_{\tilde x\sim p_\sigma(\tilde x)}\frac 12\|\psi_\theta(\tilde x)-\nabla_\tilde x\log p_\sigma(\tilde x)\|^2
$$
and the following **"Denoising Score matching objective"** 
$$
J(\theta)=\mathbb E_{\tilde x,x\sim p_\sigma(\tilde x,x)}\frac 12\|\psi_\theta(\tilde x)-\nabla_\tilde x\log p_\sigma(\tilde x|x)\|^2
$$
The key to prove this equivalence is to see the interaction term are the same 
$$
\begin{align}
&\mathbb E_{\tilde x,x\sim p_\sigma(\tilde x,x)}   \lang \psi_\theta(\tilde x),\nabla_\tilde x\log p_\sigma(\tilde x|x)\rang\\
=&\int dx\int d\tilde x p_\sigma(\tilde x|x)p(x)   \lang \psi_\theta(\tilde x),\nabla_\tilde x\log p_\sigma(\tilde x|x)\rang\\
=&\int dx\int d\tilde x p(x)   \lang \psi_\theta(\tilde x),\nabla_\tilde x  p_\sigma(\tilde x|x)\rang\\
=&\int d\tilde x   \lang \psi_\theta(\tilde x),\nabla_\tilde x  \int dx p(x)p_\sigma(\tilde x|x)\rang\\
=&\int d\tilde x   \lang \psi_\theta(\tilde x),\nabla_\tilde x  p_\sigma(\tilde x)\rang\\
=&\int d\tilde x  p_\sigma(\tilde x) \lang \psi_\theta(\tilde x),\nabla_\tilde x  \log p_\sigma(\tilde x)\rang\\
=&\mathbb E_{\tilde x\sim p_\sigma(\tilde x)}\lang \psi_\theta(\tilde x),\nabla_\tilde x  \log p_\sigma(\tilde x)\rang\\
\end{align}
$$
To put it in human words, if we want to fit the score of $p_\sigma(\tilde x)$ , instead of directly evaluating $\nabla \log p_\sigma(\tilde x)$, we could equivalently use the denoising objective which draw sample pairs from the noised, and pure distribution $(x,\tilde x)$. 

In the special case of Gaussian kernel $q(z)=\mathcal N(0,\sigma^2 I)$ , the denoising objective is explicitly 
$$
\begin{align}
J(\theta)=&\mathbb E_{\tilde x,x\sim p_\sigma(\tilde x,x)}\frac 12\|\psi_\theta(\tilde x)-\nabla_\tilde x\log p_\sigma(\tilde x|x)\|^2\\
=&\mathbb E_{x\sim p(x)} \mathbb E_{\Delta x\sim \mathcal N(0,\sigma^2 I)}\frac 12\|\psi_\theta(x+\Delta x) +\frac 1{\sigma^2}\Delta x\|^2\\
=&\mathbb E_{x\sim p(x)} \mathbb E_{z\sim \mathcal N(0,I)}\frac 12\|\psi_\theta(x+\sigma z) +\frac 1{\sigma}z\|^2\\
\end{align}
$$

## Significance

This objective can be easily evaluated: using the sample dataset to evaluate the expectation over $p(x)$, then sample as much "noise" $z$ as possible. 

In diffusion model / score-based model, this learning objective is the key to learn the "time-dependent" score and to the subsequent generation process. 

This is the sense that Denoising Auto Encoder is optimizing the same objective as the "denoising" score matching objective. 



## Reference 

* [Maximum Likelihood Training of Score-Based Diffusion Models](https://arxiv.org/abs/2101.09258) NeurIPS 2021
* [A Connection Between Score Matching and Denoising Autoencoders](https://www.iro.umontreal.ca/~vincentp/Publications/DenoisingScoreMatching_NeuralComp2011.pdf) Neural Computation 2011 

