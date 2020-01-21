---
layout: post
title: Note on Hessian Aware Zeroth Order Optimization Framework
author: Binxu Wang
date: Jan. 21th, 2020
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Optimization, Adversarial Example]
---

Motivation
---

[Major Reference ](https://arxiv.org/abs/1812.11377)

Zeroth order optimization, or derivative free optimization is also known as **the oracle problem**. It's nothing new to optimization community. 

Interest in ZOO algorithm resurges partly because it could be used in black box adversarial attack, if the softmax probability is given; and it could also be used in optimization of experimental output; and it could also be used for many design problem as the result has a non-analytical relationship with the parameters. 

> When we give up analytical gradients, there are so many things we could do! 

## Background

To give Zeroth Order Optimization a theoretical foundation, people want to map the constructs into normal gradient based optimization. 

For an optimization problem 
$$
\arg\max_xf(x)
$$


For normal optimizations, we have gradients

For an example of quasi-newton method, please see , <!--[Note on LBFGS](Note on LBFGS.md)--> . 

 <!--[Note on LBFGS]({{ site.baseurl }}{% link _academic_notes/Note on LBFGS.md %})--> 



