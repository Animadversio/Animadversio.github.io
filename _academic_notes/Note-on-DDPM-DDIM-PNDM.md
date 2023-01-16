---
layout: post
title: Note on Variants of Diffusion Scheduler: DDPM DDIM PNDM
author: Binxu Wang
date: Jan. 16th, 2023
comments: true
use_math: true
published: true
categories: [algorithm, machine learning]
tags: [tech note, Algorithm, ODE, SDE, Dynamic System, Generative Model, Diffusion model]
---

## Motivation

Given the popularity and power of diffusion models, the theoretical formulation of these models are not in unison. Because multiple groups have derived these models from different background, there exist multiple formulations, SDE, ODE, Markov Chain, Non-markov chain etc. 

In this note, we hope to simplify then and provide a unified framework and show their correspondence. 

## Stochastic Differential Equation framework

In this formulation[^1], theoretically we have a continuous time SDE, i.e. noising process, then we can define the corresponding reverse time SDE, i.e denoising process. In the most general form, the forward noising process is the following 
$$
dx =f(x,t)dt +g(t)dw
$$
The reverse time SDE is, 



As we can see, the key component required to construct a reverse process is the score function $\nabla_x \log p(x,t)$, esp. it's a time dependent one. 



To approximate it, we used a neural network  $\epsilon_\theta(x,t)$ to learn this function from samples. 



There exist a corresponding ODE with the same marginal distribution, thus in principle, the sampling process could be totally determinisitic. 
$$
\frac{dx}{dt}=[f(x,t)-g^2(t)\nabla p(x,t)]
$$
The insights obvious from the SDE framework

* There exist an exact reverse process given any forward process, as long as we know the score field. 
* The reverse process and forward process both exist in continuous time, and the discretized time steps is just an approximation to it. So, given enough regularity, it's theoretically feasible to change the time steps (schedules). 
  * The learning of score function and the sampling process could be decoupled. (UNet & scheduler) 
* Given the diffusion SDE, the flow should generally conform to Fokker Planck equation. 



## DDPM

In this formulation[^2], we start from a **discrete Markov chain model**, with discrete time point, then design a process to reverse the Markov Chain. 





## DDIM

Comparing to DDPM the insights afforded by DDIM is, 

* The sampling could be totally deterministic, and the sampling schedule could be changed without affecting the score function learning. 





## PNDM

As a step forward the paper PNDM summarize the progress in the DDPM and DDIM, and embraced the ODE formulation. It incorporates a higher order solver for the ODE, using linear multi-step methods (RK4 is also a choice) to estimate the real "gradient" and use it to solve the ODE in time. 

It's similar to DDIM in that they both used a nonlinear transport part, but differ in they used different gradient estimation method: DDIM used the score estimate directly, PNDM used the score estimates from last few steps to construct a better linear estimate of the current score. 

 

