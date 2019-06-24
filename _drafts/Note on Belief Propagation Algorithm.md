---
layout: post
title: Note on Belief Propagation Algorithm
author: Binxu Wang
date: May 18th, 2019
comments: true
use_math: true
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Graph Model]
---

* TOC
{:toc}


最近在阅读，是以为记。

## Objective of Algorithm 目标
Belief Propagation算法想解决的是Markov随机场，Bayes网络等图模型的边缘概率估计，以及求解最可能的状态的问题。

有许多名字称呼这一General的算法，如sum-product (Message Passing)等，属于更general的Message Passing算法范畴。
同时这一算法可以说是一种通用框架或者philosophy，因此在不同结构的模型中有许多著名的特例，这些具体算法也有各自的名字(如前向后向算法...)

对于统计学习问题，通常会区分模型与算法，模型设定一些假设，抽象现实的某个方面，建立问题的结构；而算法求解问题(很多时候是转化为优化问题来求解)。在这个post中将要介绍的Belief Propagation算法，属于后者，但为了理解他，我们首先需要理解他对应的模型，即概率图模型。


## Graphical Models： What relates graph to probability?
第一次接触概率图模型的人（像我）都会问，概率和图这两者有什么关系呢？ 我们知道图是一种直观的表征事物之间二元关系的方法通常由$(\mathcal V, \mathcal E)$定点和边组成。在概率图模型中，顶点通常代表随机变量，而边代表随机变量之间的关系。

> **Graph is a concise way to visualize the relationship (dependency / factorization) between the random variables of a probability distribution!**

There are many graphical models appears in different names, but intrinsically very similar things. 

**Definitions**: 

* **Bayes Network** Bayes Network这种模型模拟的是变量间的条件概率关系，即有向边$A\to B$代表一种条件概率/变量间的依赖关系$P(B|A)$。因而这一模型经常伴随着因果关系的解释(Causal Interpretation). 见[示例](https://en.wikipedia.org/wiki/Bayesian_network#Example). 因而对应的图，就是有向无环图(Directed Acyclic Graph)。
* **Markov Random Field** MRF。
	* 使得变量间满足条件独立性的图即马尔科夫随机场。
* **Conditional Random Field** Similar to MRF. 

* **Graph Model**: When there is only unary, binary relationship, then it is a **graph model**

 对于图模型，一些常见的问题就是

* 最大化(Maximization): 寻找对于整个分布，最可能的状态(Most probable configuration) 
* 边缘化(Marginalization)： 求某个随机变量的边缘分布
	* 这两个问题都与EM算法的状态估计(E)一步紧密相关。

而本文中的Belief Propagation算法就是求解这些问题的一个主要方法。

## Basic Framework / Concepts

To 

### Factor Graph

## Derivation 推导



## Intuition 算法的直观理解



## Convergence / Exactness 收敛性、精确性
收敛性以及精确性决定于图的结构。

当整个图的结构是树时，整个算法是




## Belief Propagation in HMM: Forward Backward Algorithm 


## Belief Propagation in Restricted Bolzmann Machine (RBM) 

## Appliction

* Stereo vision (disparity estimate)
* Estimate the inner state of the neural network model, from observed data.

[^1]: 从零学习Belief Propagation算法（一） https://blog.csdn.net/qq_23947237/article/details/78385110
[^2]: 从零学习Belief Propagation算法（二） https://blog.csdn.net/qq_23947237/article/details/78387894
[^3]: 从零学习Belief Propagation算法（三） https://blog.csdn.net/qq_23947237/article/details/78389188