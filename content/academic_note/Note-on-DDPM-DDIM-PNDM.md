---
layout: post
title: Note on Variants of Diffusion Scheduler, DDPM DDIM PNDM
author: Binxu Wang
date: 2023-01-16
comments: true
# use_math: true
math: true
# published: true
draft: false
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

In this formulation[^2], we start from a **discrete Markov chain model**, with discrete time point, then design a process to reverse the Markov Chain. We call them the forward / inference process and the reverse / generative process. 

In the forward process, 
$$
q(x_t\mid x_{t-1})=\mathcal N(\sqrt\frac{\alpha_t}{\alpha_{t-1}} x_{t-1}+,(1-\frac{\alpha_t}{\alpha_{t-1}})I)\\
x_t=\sqrt\frac{\alpha_t}{\alpha_{t-1}} x_{t-1}+\sqrt{1-\frac{\alpha_t}{\alpha_{t-1}}} \xi,\;\xi\sim\mathcal N(0,I)
$$
We also have the marginal distribution of each time point given the initial sample $x_0$. (In other word, this forward process is analytical solution.)
$$
q(x_t\mid x_{0})=\mathcal N(\sqrt{\alpha_t} x_{0},(1-\alpha_t)I))\\
x_t=\sqrt{\alpha_t} x_{0}+\sqrt{1-\alpha_t}\xi, \;\xi\sim\mathcal N(0,I)
$$




The generative / reverse process is also a Markov Chain, with the samples at intermediate time points as latent variables. 
$$

$$




For DDPM, as the model is effectively a latent variable model, the parameter inference will be done via a variational inference lower bound (ELBO). 



* The rationale of the ELBO is different from the score matching, but they arrived at the same simple training objective in the end. 
* They also acknowledged that their training objective is similar to denoising score matching, and the sampling scheme is a annealed Langevin dynamics. 
  * This ELBO is different from the derivation of the score from the SDE formulation. But xxx. 





## DDIM

One motivation DDIM got is, the training objective of DDPM or score matching only depends on the marginal distribution at any given $t$, (*time dependent score function*) and it doesn't depend on the joint of joint of the variables. Thus the authors are motivated to design other processes with the same marginal, but different conditional or joint. 



From this motivation, they designed an alternative forward (noising) process that is no longer Markovian, i.e. not just dependent on the last time steps. 





Comparing to DDPM the insights afforded by DDIM is, 

* The sampling could be totally deterministic, and the sampling schedule could be changed without affecting the score function learning. 

$$
x_{t-1}=\sqrt{\alpha_{t-1}} \left( \frac{x_t-\sqrt{1-\alpha_{t}}\epsilon(x_t,t)}{\sqrt{\alpha_{t}}}\right)
+\sqrt{1-\alpha_{t-1}-\sigma_t^2} \epsilon(x_t,t)
+\sigma_t \epsilon(x_t,t)
$$

* In the deterministic case, all the $\sigma_t$ are set as 0, then the sampling dynamics could be written as 
  $$
  x_{t-1}=\sqrt{\alpha_{t-1}} f_t(x_t,\epsilon(x_t,t))
  +\sqrt{1-\alpha_{t-1}} \epsilon(x_t,t)\\
  f_t(x_t,\epsilon)=\frac{x_t-\sqrt{1-\alpha_{t}}\epsilon(x_t,t)}{\sqrt{\alpha_{t}}}\approx \hat x_0
  $$

  * Thus, if the score function is somewhat exact, then by this design, the states $x_t$ should travel on the two dimensional plane, spanned by the initial state and the potential end state. 

* Another insight is the weights $\gamma$ in the score matching objective has a connection to the $\sigma$ parameter in this Non-markovian model. (Theorem 1), there exist $\gamma$ for every $\sigma$ choice and a constant value $C$ such that the ELBO for DDIM is a shifted version of DDPM. 

  * This provides a interpretation for the $\gamma$ weights and made it less arbitrary during training. 









## PNDM

As a step forward the paper PNDM summarize the progresses in the DDPM and DDIM, and embraced the ODE / deterministic formulation. It incorporates a higher order solver for the ODE, using linear multi-step methods (RK4 is also a choice) to estimate the real "gradient" and use it to solve the ODE in time. 

It's similar to DDIM in that they both used a nonlinear transport part, but differ in they used different gradient estimation method: DDIM used the score estimate directly, PNDM used the score estimates from last few steps to construct a better linear estimate of the current score. 

 

