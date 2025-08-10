---
layout: post
title: Note on Neural Tuning and Information
author: Binxu Wang
date: 2020-08-24
comments: true
categories: [neuroscience]
tags: [academic note, Neuroscience, Statistics, Neural Tuning, Sensory Neuroscience, Information Theory]
---

# Note on Neural Tuning and Information

Given a stimuli with $D$ intrinsic dimensions, we consider how one neuron or a population of neurons is informative about this stimulus space. 

## Specific Information (Mutual Information)

Setup for specific information computation is easy given a certain response  $r$ , compute the reduction of entropy of stimuli $\mathbb s$ . 
$$
I_{sp}(r) = H(\mathbf s) - H(\mathbf s\mid r)\\
I_{ssi}(\mathbf s) = \int_r I_{sp}(r)p(r\mid\mathbf s)=\mathbb E I_{sp}(r)
$$
Note the specific information depend on the prior distribution of $\mathbf s$. So during task settings when only 2 or a few stimuli could occur (e.g. discrimination task), this could affect the information. 

Also note that the conditional distribution $p(r\mid s)$ depends on the noise scheme, and noise level as a free parameter could affect the encoding scheme. 





## Fisher Information

> Fisher information is 2nd order approximation to the landscape of log likelihood around its peak. You can think of it as an expected Hessian or curvature matrix. 

Firstly, given a bunch of response or data $r$, and a model $p(r\mid s)$ there is a log likelihood landscape $\mathcal L(s;r)=\ln p(r\mid s)$ over all the possible stimuli $s$ that result in this set of response $r$ . Note, use log likelohood instead of likelihood is because quadratic approximation to log probability is usually better. 

Thus for this landscape function, we can compute its gradient and Hessian w.r.t. the parameter of stimuli $s$. 
$$
\partial_s\mathcal L(s;r) = \partial_s\ln p(r\mid s)\\
\partial_s\partial_s\mathcal L(s;r) = \partial_s\partial_s\ln p(r\mid s)
$$
Note that the landscape is depending on the data $r$ Sometimes, without having the data, we can hypothetically take an expectation over all possible $r$ conditional on the real parameter $s^*$ of stimuli. 
$$
\mathbb E_r\partial_s\mathcal L(s;r)=\int_rp(r\mid s^*)\partial_s \ln p(r\mid s)\\
\mathbb E_r\partial_s\partial_s\mathcal L(s;r)=\int_rp(r\mid s^*)\partial_s\partial_s \ln p(r\mid s)
$$
It's intuitive that the expectation of likelihood function should peak at the real stimuli parameter. That is, the 1st order derivative should vanish and the 2nd order derivative or Hessian describe how fast the likelihood decay when the changing the stimuli parameter. 
$$
\mathbb E_r\partial_s\mathcal L(s;r)|_{s^*}=\int_rp(r\mid s^*)\frac{\partial_s p(r\mid s)|_{s^*}}{p(r\mid s^*)}=\partial_s \int_r p(r\mid s)|_{s^*}=0
$$
And as the Hessian Matrix should be negative definite. Thus we define the negative of the Hessian matrix around the true stimuli parameter. 
$$
J(s)=-\mathbb E_{p(r|s)}[\partial_s\partial_s\mathcal L(s;r)]= \mathbb E_{p(r|s)}[(\partial_s\mathcal L(s;r))(\partial_s\mathcal L(s;r))^T]
$$
So Fisher information is assuming your input stimuli parameter is $s$, compute the expected (over response data) log likelihood landscape around this real parameter $s$, then get the Hessian for quadratic approximation of the peak. That is, given a certain stimuli / theory $s$, how fast will the log likelihood of the stimuli / the theory drop, when the stimuli  deviates from the real one ($s$) a little bit. 

Thus when the eigenvalues of Fisher information Matrix is generally small, it means the response mechanism is really sensitive to this input. 

When the eigenvalues for certain stimuli dimension is zero, it means the response is unable to discriminate this input dimension at this location, since changing it will not affect the likelihood of the stimuli parameter. 







## Comparison



* Fisher information is quite local measurement of information. 
* Entropy is a more global measurement of information, although it also has some local component. 



What is the relevant notion of information in our case? 











