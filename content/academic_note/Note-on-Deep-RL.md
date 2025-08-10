---
layout: post
title: Note on Deep Reinforcement Learning
author: Binxu Wang
date: 2020-03-20
comments: true
# use_math: true
math: true
categories: [machine learning]
tags: [academic note, reinforcment learning, machine learning, deep learning]
typora-copy-images-to: ../assets/img/notes/RL/
---





Reinforcement Learning deals with environment and rewards. 

Agents have a set of actions to interact with environment (state $s_i$), and the environment will be changed by these actions $a_j$, from time to time, there will be reward coming from environment! 

Fundamentally, you don't have reward for your every single action, and for your understanding of environment. But how can you solve these problems?

# Overview and Concepts

> How to frame reinforcement learning into a general optimization framework? What's the objective. 

**Markov Decision Process**

* 

**State Trajectory** 

* The game process can be seen as a stochastic process, with some parameter of the agent $\theta$ deciding policy $\pi_\theta(a\mid s)$ and some parameter of the environment determining the transition of states $p_\lambda(s_{t+1},r_{t+1}\mid s_t,a)$ 
* If the policy and environment parameters are set, then this is a fixed stochastic process. You can define the expected reward $\mathbb E_{\pi_\theta} \sum^n_{t=1} r_t$ over this stochastic process, i.e. over the ensemble of trajectories. 
  * As you can only change your principle of behavior (policy), you are maximizing expected reward over $\theta$ 

**Temporal Structure**

* RL has a clear temporal structure, you are facing the future, trying to maximize the reward in the future (don't care reward that has been collected)
* You are reviewing your past experience to learn the strategy. 

# Method Taxonomy

**Model based vs Model free**

* If you have a model of the world, you can play with it and simulate response and on and on in your "imagination", without taking any action. 

**On-line vs Off-line policy**

* Can you learn from recording of games, or have to interact with environment to learn? 

**Continuous vs Discrete Action Space**

* If continuous, your can not evaluate every possible action, but output some distribution over it. 
* If discrete, you can put value on every one of it and find max easily. 
  * *I feel this distinction is superficial, but seems they have different names, probability based and value based learning.*



## Policy Gradient

You want to directly learn a map from observed states to action $p(a_i\mid s_i)$ (*see sth, do sth*) 

* Your source of feedback is reward, but it's sparse. 
* Simplest thing is to recall all the $(a_i, s_i)$ pairs during an episode, and use reward to reinforce these connections! 
  * However, as not all the actions in an episode contribute to the final reward, we should assign different credits to different action state pair. 
  * Like assign credits only to action happen before reward events. And emphasize the actions closer to the reward? 

**Comments**: 

* Actually the credit assignment problem is really related to causal inference! 
* You have to figure out the real causal relationship instead of just statistical contingency to get reward! 

**Tricks**

* Shift the Baseline so that small reward will be seen as punishment. 
* 





https://lilianweng.github.io/lil-log/2018/04/08/policy-gradient-algorithms.html

https://towardsdatascience.com/policy-gradients-in-a-nutshell-8b72f9743c5d

## Actor Critic





## Q-Learning

Core is the Q function, the expected current reward and the $\gamma$ discounted future reward for a given $(s_i, a_j)$ pair. 

If you have a good Q model function, then you can use some simple policy to choose from them.

* Greedy: Maximize Q function
* Epsilon greedy: Maximize Q function at $1-\epsilon$  times, but do random things at $\epsilon$ probability. 



Deep Q Learning is to substitute the big $(s_i, a_j)$ table for a complex function approximator DNN, and to learn Q functions by backprop. 

DQN could be done by batch learning, record the $s_i,s',a_i,r_i$ pair for a few trials, and then revive these memory and learn from them. 

**Tricks**
