---
layout: post
title: Note on Deep Reinforcement Learning
author: Binxu Wang
date: Mar 18th, 2020
comments: true
use_math: true
categories: [machine learning]
tags: [academic note, reinforcment learning, machine learning, deep learning]
typora-copy-images-to: ../assets/img/notes/RL/
---





Reinforcement Learning deals with environment and rewards. 

Agents have a set of actions to interact with environment (state $s_i$), and the environment will be changed by these actions $a_j$, from time to time, there will be reward coming from environment! 

Fundamentally, you don't have reward for your every single action, and for your understanding of environment. But how can you solve these problems?

# Overview and Taxonomy

**Model based vs Model free**

* If you have a model of the world, you can play with it and simulate response and on and on in your "imagination", without taking any action. 

**On-line vs Off-line policy**

* Can you learn from recording of games, or have to interact with environment to learn? 

**Continuous vs Discrete Action Space**

* If continuous, your can not evaluate every possible action, but output some distribution over it. 
* If discrete, you can put value on every one of it and find max easily. 
  * *I feel this distinction is superficial, but seems they have different names, probability based and value based learning.*

## Policy Gradient



## Q-Learning

Core is the Q function, the expected current reward and the discounted future reward for a given $(s_i, a_j)$ pair. 

If you have a good Q model function, then you can use some policy to choose from them

* Greedy: Maximize Q function
* Epsilon greedy: Maximize Q function at 1-eps times, but do random things at eps probability





Deep Q Learning is to substitute the big $(s_i, a_j)$ table for a complex function approximator DNN, and to learn by backprop. 

DQN could be done by batch learning, record the $s_i,s',a_i,r_i$ pair for a few trials, and then revive these memory and learn from them. 