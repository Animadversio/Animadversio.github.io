---
layout: post
title: Note on Belief Propagation Algorithm (Updating)
author: Binxu Wang
date: May 18th, 2019
comments: true
use_math: true
published: true
categories: [algorithm]
tags: [tech note, Algorithm, Machine Learning, Statistical Learning, Graph Model]
---

* TOC
{:toc}


最近在阅读[^0]，是以为记。

[^0]: This MIT course [MIT Course Algorithm for Inference](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-438-algorithms-for-inference-fall-2014/lecture-notes/) organizes the relevant knowledge and material really well, and I will add my note for that course to this. 

## Objective of Algorithm 目标
Belief Propagation算法想解决的是Markov随机场，Bayes网络等图模型的边缘概率估计，以及求解最可能的状态的问题。

有许多名字称呼这一General的算法，如sum-product, max-product, min-sum, Message Passing等，属于更general的Message Passing算法范畴。

同时这一算法可以说是一种通用框架或者philosophy，因此在不同结构的模型中有许多著名的特例，这些具体算法也有各自的名字(如前向后向算法，Kalman Filter等等)

对于统计学习问题，通常会区分模型与算法，模型设定一些假设，抽象现实的某个方面，建立问题的结构；而算法求解问题(很多时候是转化为优化问题来求解)。在这个post中将要介绍的Belief Propagation算法，属于后者，但为了理解他，我们首先需要理解他对应的模型，即概率图模型。


## Graphical Models： What relates graph to probability?
第一次接触概率图模型的人（像我）都会问，概率和图这两者有什么关系呢？ 我们知道图是一种直观的表征事物之间二元关系的方法通常由$(\mathcal V, \mathcal E)$定点和边组成。在概率图模型中，顶点通常代表随机变量，而边代表随机变量之间的关系。

> Graph is a concise way to visualize the relationship (dependency / factorization) between the random variables of a probability distribution!

There are many graphical models appearing in different names, but intrinsically very similar things. 

**Definitions**: 

* **Bayes Network** Bayes Network这种模型模拟的是变量间的条件概率关系，即有向边$A\to B$代表一种条件概率/变量间的依赖关系$P(B\mid A)$。因而这一模型经常伴随着因果关系的解释(Causal Interpretation). 见[示例](https://en.wikipedia.org/wiki/Bayesian_network#Example). 因而对应的图，就是有向无环图(Directed Acyclic Graph)。
* **Markov Random Field** MRF。
	* 使得变量间满足条件独立性的图即马尔科夫随机场。
* **Conditional Random Field** Similar to MRF. 

* **Graph Model**: When there is only unary, binary relationship, then it is a **graph model**. (if there is dependency that include more than 2 variables than it will be a hypergraph.)

 对于图模型，一些常见的问题就是

* 最大化(Maximization): 寻找对于整个分布，最可能的状态(Most probable configuration) 
* 边缘化(Marginalization)： 求某个或某几个随机变量的边缘分布
	* 这两个问题都与EM算法的状态估计(E)一步紧密相关。

而本文中的Belief Propagation算法就是求解这些问题的一个主要方法。

<!-- ## Basic Framework / Concepts-->



<!-- ### Factor Graph-->



## Energy Formalism 

Note that the algorithm can be written in terms of joint probability maximization, or in terms of cost minimization. The 2 formulisms can be connected by a **Statistical Physics** point of view. 

In statistical physics models like Ising Model, the probability of a state happening is subject to the Bolztmann Distribution, which is exponentiating the negative energy. 
$$
p(\{s_i\})\propto\exp(-\beta H(\{s_i\}))\\
H(\{s_i\})=\sum_iD(s_i)+\sum_{(i,j)\in \mathcal E}V(s_i,s_j)\\
p(\{s_i\})\propto\prod_i\exp(-\beta D(s_i))\prod_{(i,j)\in \mathcal E}\exp(-\beta V(s_i,s_j))
$$
Thus the task of finding highest probability configuration is the same as finding the lowest energy configuration (ground state). 
$$
\arg\max_{\{s_i\}}p(\{s_i\}) = \arg\min_{\{s_i\}}H(\{s_i\})
$$
And in fact the dependency structure presented in the joint distribution $p(\{s_i\})$, is also presented in the dependency structure of energy term $H(\{s_i\})$. 

Thus, even for a pure Probabilistic Graph Model, we can take the $-\log(p)$ as energy and formulate the problem as a energy minimization problem. 

For the maximize probability case, the belief propagation is also termed as *Max-Product* algorithm. For the minimize energy case, the belief propagation is termed as *Min-Sum* Algorithm. 

Refer to [Stanford Belief Propagation Note](http://stanford.edu/~montanar/TEACHING/Stat375/handouts/bp_book2.pdf)  

## Algorithm 算法形式

**Min-Sum Algorithm** for solving ground state configuration problem. 
$$
m^t_{pq}(f_q)=\min_{f_p} (V(f_p,f_q)+D(f_p)+\sum_{s\in\mathcal N(p)/q} m^{t-1}_{sp}(f_p))\\
b^t_q(f_q)=D_q(f_q)+\sum_{p\in\mathcal N(q)}m^t_{pq}(f_q)
$$
**Max-Product Algorithm** for solving the most probable state (mode state) problem. If we have a model like 
$$
p(\{x_i\})\propto\prod_i\exp(\phi_i(x_i))\prod_{(i,j)\in\mathcal E}\exp(\psi_{ij}(x_i,x_j))\\
$$
Then the algorithm reads. 
$$
m^t_{ij}(x_j)\propto\max_{x_i}\exp(\phi_i(x_i))\exp(\psi_{ij}(x_i,x_j))\prod_{k\in \mathcal N(i)/j}m^{t-1}_{ki}(x_i)\\
\sum_{x_j} m^t_{ij}(x_j)=1\\
b^t_i(x_i)\propto \exp(\phi_i(x_i))\prod_{k\in \mathcal N(i)}m^{t}_{ki}(x_i)\\
b^t_i(x_i,x_j)\propto \exp(\phi_i(x_i)+\phi_j(x_j)+\psi_{ij}(x_i,x_j))\prod_{k\in \mathcal N(i)/j}m^{t-1}_{ki}(x_i)\prod_{k\in \mathcal N(j)/i}m^{t}_{kj}(x_j)
$$


## Derivation 推导

For tree structured graph, message passing algorithm can be derived from principle, which is the **sum-product** or **max-product** algorithm. 

When you try to marginalize / maximize a joint probability distribution, you can rearrange and commute the summation / maximization over some parameters to make it more efficient. 

For example, 
$$
p(x_{1:5})=\psi_{13}(x_1,x_3)\psi_{12}(x_1,x_2)\psi_{24}(x_2,x_4)\psi_{25}(x_2,x_5)\prod_i\phi_i(x_i)
$$
Marginalize to $p(x_1)$ requires summation over $x_{2:5}$. It could be done by passing messages from the leaves to the root which is $x_1$. 





Finding mode requires maximization over $x_{1:5}$. And it can be done by passing messages as well. 





When it is parallelized and generalized to Cyclic graph, it can still work fine, which becomes the **loopy belief propagation algorithm**. 

## Intuition 算法的直观理解

The intuition behind Belief Propagation / message passing algorithm is quite clear. 

The message $m^t_{pq}$ is what node $p$ 'think' node $q$ should be like, given node $p$ 's unary cost $D(f_p)$ and $pq$ 's interaction cost $V(f_p,f_q)$. 

The belief $b_q(f_q)$ is what node $q$ believes its state will be, given all the message passed from neighbors and its own cost $D_q(f_q)$. 



## Convergence / Exactness 收敛性、精确性
收敛性以及精确性决定于图的结构。

当整个图的结构是树时，整个算法是解析上精确的。可以采用任意节点作为根节点并用到根节点距离作为次序，先从根节点开始message passing到叶子节点，再从叶子节点message passing返回。

这个算法可以被并行化为parallel message passing algorithm, 每个节点单独计算message. 

当图中带有环(loop)时, 并没有统一的顺序可以进行message passing，整个算法也成为了近似估计，被称为Loopy Belief Propagation. 每个时刻每个节点sum up上个时刻周围节点的信息并生成新的message pass给周围节点。

这一算法看似缺乏理论保证但许多实际问题中的表现很好，偶尔会奇妙的失败。更多关于Loopy Belief Propagation理论属性的解释可以参见[MIT Note](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-438-algorithms-for-inference-fall-2014/lecture-notes/MIT6_438F14_Lec15-16.pdf) . 

对于Loopy Belief Propagation, 一般实现所需要的时间复杂度是$O(Ek^2T)$, $n$ 是节点数量, $E$ 是边的数量, $k$ 是可能状态的数量，$T$是message passing的迭代次数。若网络不是非常稠密(如图片网格)，$E\sim O(n)$ 边的数量线性正比于节点数目。则复杂度是$O(nk^2T)$. 不过在许多实现中存在加速的办法不必显示计算$k^2$ 

注意到Message propagation的速度是每个iteration只走一步，因此对于grid网络，需要足够长的时间$\sim n^{1/2}$才能使一个信息传遍整个网络，使得收敛速度可能很慢。 增加长距离连接以及multi-scale的网络可以帮助解决这一问题。

## Belief Propagation in HMM: Forward Backward Algorithm 

Note that Markov Chain and HMM are basic and common graph models. And as the graph topology is a tree, belief propagation is exact on HMM and Markov Chain. Sequential belief propagation in Markov Chain is usually called *Forward-Backward* or *Viterbi* algorithm. 



## Belief Propagation in Restricted Bolzmann Machine (RBM) 



## Appliction

* Estimation in many early vision tasks, Stereo vision (disparity estimate), Segmentation, Optic Flow etc. 
* Estimate the inner state of the neural network model, from observed data.

[^1]: 从零学习Belief Propagation算法（一） https://blog.csdn.net/qq_23947237/article/details/78385110
[^2]: 从零学习Belief Propagation算法（二） https://blog.csdn.net/qq_23947237/article/details/78387894
[^3]: 从零学习Belief Propagation算法（三） https://blog.csdn.net/qq_23947237/article/details/78389188





