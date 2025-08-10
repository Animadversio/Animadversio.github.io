---
layout: post
title: Note on Image Prior-Markov Random Field Modelling
author: Binxu Wang
date: Jan 28th, 2020
comments: true
use_math: true
categories: [computer science]
tags: [academic note, computer vision, computer science, machine learning]
typora-copy-images-to: ../assets/img/notes/cv2
---

* TOC
{:toc}
Continuing [Image Prior and Generative Model](Note-on-Image-Prior.md) .

**Probabilistic Graphic Model** comes into scene, when we want to model and deal with some **complex distribution over many variables**. When we start to add structure into the model, not everything depend on everything, then the dependency relationship among variables emerges as a graph structure. 

# Markov Random Field

**Basic idea**: Use undirected graph to represent joint distribution of random variables. 

* Nodes are variables
* Edges depict direct dependency
  * No edge, means conditional independency! 

**Benefit**:

* As long as you map the problem to MRF structure, then you have a bunch of **inference algorithms available**! You don't need to think about optimization algorithm. 
* Majorly dealling with discrete variable, continuous variables can be discretized. 
* Can be combined with CNN, and formulate as RNN (unroled belief propagation. ) 

## MRF Basic 

**Markov Blanket**: the minimal set of variables $\{y_i\}$, that you need to observe, so that the other variables will be independent to the node $x$. 

* For MRF, it's the **neighbor** set of $x$. $M(x)=\mathcal N(x)$

**Clique**: Fully connected subgraph 

**Maximal Clique**: Adding any other nodes will disrupt the cliqueness.

**Property**: Joint distribution could be factorized into functions over each Clique
$$
P(V)=\frac 1Z \prod_i\Psi_i(C_i)
$$

* $\Psi_i$ are potential functions, not necessarily normalized
* $Z$ is the partition function, a *constant* depending on the potential function forms. 
  * Note $Z$ is **very expensive to compute, extremely hard**. 
  * But you don't need it for **inference** if you MAP
  * But you do need it when you are doing training! When you are learning $\Psi_i$ from data, because the $Z$ is a function over your parameter! 

$$
P(\{x_i\in V\})=\frac 1{Z(\Theta)}\prod_i\Psi_i(\{x\in C_i\};\theta_i)
$$

For example, doing MLE for a gaussian model without adding the $Z$ i.e. normalizing factor, you will get infinite covariance! The insight here is without normalizing factor, the **potential function could grow uniformly over the space**, which is undesirable. 
$$
\Psi(x)=\exp(-(x-\mu)^T\Sigma^{-1}(x-\mu))\\
Z(\mu,\Sigma)=\sqrt{(2\pi)^k\det\Sigma}\\
\arg\min_\Sigma-\log\Psi(x)=(x-\mu)^T\Sigma^{-1}(x-\mu)\mapsto \inf
$$
This hardship for normalization seems universal and fundamental. See [notes on deep unsupervised learning](Note-on-Deep-Unsupervised-Learning.md). 

## Training Example: Fields of Experts Image

[CVPR 2005 Roth Black](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.186.1293&rep=rep1&type=pdf) Fields of Experts Image

**Single patch prior**: student t distribution prior over different filters $J_i$. 
$$
p(x)\propto\prod_i(1+\frac12(J_ix_p)^2)^{-\alpha_i}
$$
Before, when we learn the filters and regularizers for patches, we assume them as independent! However, when applying them, they become entangled, i.e. patches overlap, thus not independent. The total image prior is like, 
$$
p(X)={1\over Z(\{J_i,\alpha_i\})}\prod_p(\prod_i(1+\frac12(J_ix_p)^2)^{-\alpha_i}))
$$
Can we learn the patch parameters from whole images? 

**Training Issue**

* You cannot evaluate likelihood as you don't have $Z(\Theta)$

* Because of this, you cannot maximum likelihood estimate directly! Gradient descent / ascent is not working!! 

The authors reformulated the problem. Set $p(X)=p'(X)/Z(\Theta)$, then they can maximize the log-unnormalized likelihood. However to prevent the potential $p'$ from going up uniformly, 
$$
\mathcal L=\frac 1T\sum_1^T\log p'(X_t)-\int p(X)\log p'(X)dX
$$
Note that, if you have an unnormalized distribution, you can still draw samples from it! (MCMC). So you have $p'(X)$, you can draw samples from it, $X_p\propto p'(X)$ 
$$
\mathcal L=\frac 1T\sum_1^T\log p'(X_t)-\int p(X)\log p'(X)dX\\
\to\; \frac 1T\sum_1^T\log p'(X_t)-\frac 1P\sum_1^P \log p'(X_p)
$$
$X_p$ are drawn from the potential funcion $p'(X_p)$ .i.e. using 
$$
\frac 1P\sum_1^P \log p'(X_p)\approx\int p(X)\log p'(X)dX
$$
Sometimes, it's called **Bayesian quadrature**, i.e. using current unnormalized distribution for sampling to estimate some integral under such distribution! 

> Partition function / normalization is what make MRF hard! 

For SOTA see [Structred-SVM](https://en.wikipedia.org/wiki/Structured_support_vector_machine), CRF! 

## Pairwise MRF

A special case of MRF. 
$$
P(V)=\frac 1Z\prod_{(i,j)\in E}\psi_{i,j}(x_i,x_j)
$$

> Note any distribution could be write in pairwise fashion, using nodes representing clique, and the nodes within clique connected to it. 

Unitary term could be added. 
$$
P(V)=\frac 1Z\prod_{i\in V}\phi_{i}(x_i)\prod_{(i,j)\in E}\psi_{i,j}(x_i,x_j)
$$
Usually, we assume each variable can choose from $L$ discrete labels

## Inference problems

Normally 2 kinds of inference

* MAP problem: $\arg\max_{x_i} P(V)$ 
* Marginalize problem: $p(x_i)=\sum_{V/x_i}P(V)$, $\hat x_i=\arg\max_{x_i}p(x_i)$

[Note on Belief Propagation](Note-on-Belief-Propagation-Algorithm.md)



**Note** for different Loss function, either MAP or Max Marginal can be better! So depending on your objective, you should choose different Inference problem. 

* If the loss for different variables are independent, MM can be better
* If loss of variables are entangled, MAP can be better. 

**Note**: Energy formulation 
$$
E_i=-\log\phi_i(x_i)\\
E_{i,j}=-\log\psi_{i,j}(x_i,x_j)
$$
Then you will have a sum version energy minimization problem. 
$$
\arg\min\mathcal L(V)=\sum_iE_i(x_i)+\sum_{(i,j)\in\mathcal E} E_{i,j}(x_i,x_j)
$$

### Belief Propagation Max Marginal

Marginalization is just summation over a bunch of variables, and you can commute the summation with product. 

[Note on Belief Propagation](Note-on-Belief-Propagation-Algorithm.md) 

**Max-Product Equation** 
$$
m_{i\to j}(x_j)=\sum_{x_i}\phi(x_i)\psi(x_i,x_j)\prod_{k\in N(i)}m_{k\to i}(x_i)
$$

**Remark**

* Note this is a **recursive definition**, so if there is loops, the definition doesn't work. 
* But for **chain**, you can go from left to right and back you will get all the messages. 
* For **tree**, it's still easy, you can schedule the propagation s.t. the 
  * Pick root, propagate from all the leaves to root. 
  * Then root back to leaves.

**Tree Belief Propagation**

1. Pick a root, maintain a queue of edges. 
2. Select all the leaves, 
   1. Compute messages on the edges connected to these leaves, record these messages. 
   2. Ignore these leaves and edges, select the new leaves, iterate! 
3. Go reverse order through the list of messages. 

### Loopy Belief Propagation

1. Initialize message as all 1. 
2. Each time update a set of messages. 
3. Iterate multiple times, travel through all the edge 2 times is one epoch, do multiple epochs. 


$$
m^T_{i\to j}(x_j)=\sum_{x_i}\phi(x_i)\psi(x_i,x_j)\prod_{k\in N(i)/j}m^{T-1}_{k\to i}(x_i)\\
P(x_i)=\prod_{j\in N(i)} m^T_{j\to i}(x_i)
$$

**Remark**

* It will converge to correct answer with in a tree! 
* For Cyclic graphs it's not guaranteed.
* Renormalize message for each edge will not affect you! 

**Schedule is Important**

* When updating multiple messages, it's better each message is not directly dependent on each other. 

Probability of Pairwise MRF is a table

### Belief Propagation MAP

**Maximum and product** commute, so you can reorder the maximum equation. 

**Max-Product Equation**
$$
m_{i\to j}(x_j)=\max_{x_i}\phi_i(x_i)\psi_{i,j}(x_i,x_j)\prod_{k\in N(i)/j}m_{k\to i}(x_i)\\
x_j=\arg\max_{x_j}\phi(x_j)\prod_{i\in N(j)} m_{i\to j}(x_j)
$$


Note, **Log and Max** commute, you can compose log function to get the same result

**Max-Sum Equation**
$$
m_{i\to j}(x_j)=\max_{x_i}\log\phi_i(x_i)+\log\psi_{i,j}(x_i,x_j)+\sum_{k\in N(i)/j}m_{k\to i}(x_i)\\
x_j=\arg\max_{x_j}\log\phi(x_j)+\sum_{i\in N(j)} m_{i\to j}(x_j)
$$

* 



## Related methods

### How to handle non-binary relationship

**Belief Propagation for Factor Graph**

For non-pairwise MRF, for each clique, set a Factor, connecting to all the nodes within clique, thus remove the non-binary dependency! (4-way relationship)

**Factor graph** is bipartite network, one part is nodes, one part is factor

* Unary term 

### How to handle continuous distribution?

**Gaussian Belief Propagation**

* For continuous variable distribution, all summation becomes integration. 
* For GBP, record message by just record mean and cov. 
  * Assume Unary and Binary terms are Gaussian.
  * Then everything will stay Gaussian! 

**Sampling Based Belief Propagation**

* Use a sample set to represent each message not distribution. 
* Not integrating out $x_i$ but sample from it's current marginal estiamte. And draw samples from $x_{i,S}$ 
* Particle Belief Propagation



## Design of Pairwise Term 

Pairwise term 
$$
E_{ij}(x_i,x_j)=\mu_{ij}V(x_i,x_j)
$$
Factorize into a edge specific weight and node value specific term. 

* Value specific form can be like $\delta(x_i,x_j)$ for labels. (Depending on Topology and Geometry of the label space.)



* The weight term can be a function of spatial distance, or feature space similarity (bilateral filter)

$$
\mu_{ij}=\exp(-\|p_i-p_j\|^2/\sigma^2)\\
\mu_{ij}=\exp(-\|p_i-p_j\|^2/\sigma^2-\|I_i-I_j\|^2/\sigma_I^2)\\
$$

* Weight function is more important for large neighborhood! Not all your neighbors are equal. (Fully connected graph esp.)
* Fully connected MRF is used! 

**Comparing Sparsely connected MRF and Fully connected MRF**: 

* Fully connected MRF express long range relationships more directly! Better result. 



## MRF: Mean Field Algorithm

> Esp. useful for Dense MRF! Much faster than BP. 

**Motivation**: Use a factorized functional form on each variable to approximate joint distribution $P(\{x_i\in V\})=\prod_iQ(x_i)$ And optimize those $Q$ separately. 

* $Q(x_i)$ is not marginal, it's more like an expected conditional, over the expected conditional of other variables. 



**Remark**: 

* This is used, similar to Belief propagation, it's a kind of message passing!
* Can approximate some NN. 


$$
Q_i'^0(x_i)=\phi_i(x_i)\\
Q_i'^{t+1}(x_i)=\phi_i(x_i)\prod_{j\in N(i)} \exp(\sum_{x_j\in L_j}Q_j^t(x_j)\log\psi_{ij}(x_i,x_j) )
$$

*Note*, do normalization for $Q^t_i(x)$ for each iteration. 

Understand the summation as approxiate expectation. 
$$
\sum_{x_j\in L_j}Q_j^t(x_j)\log\psi_{ij}(x_i,x_j)\approx \mathbb E_{x_j\sim Q_j^t} \log\psi_{ij}(x_i,x_j)
$$
In Log energy formulation: 
$$
\log Q'^{t+1}_i(x_i)=-E_{ii}(x_i)-\sum_{j\in N(i)}\sum_{x_j\in L_j}Q_j^t(x_j)E_{ij}(x_i,x_j)
$$
**Comparison with BP**

* The message passing around is not the ......



### Efficient Computation of Mean Field

Note this is super simple if the $\mu_{ij}$ is a translational invariant spatial kernel. 
$$
\log Q'^{t+1}_i(x_i)=-E_{ii}(x_i)-\sum_{j\in N(i)}\sum_{l\in L_j}Q_j^t(l)V(x_i,l)\mu_{ij}
$$
Note that the last part $\sum_{j\in N(i)}\sum_{l\in L_j}Q_j^t(l)V(x_i,l)\mu_{ij}$ it can be computed by a channel wise matmul with $V$ and a convolution with $\mu$. (Both are linear and commutes. )

Super efficient, just a convolution +  Channel wise matrix mul + normalization. Message update is simultaneous. 
$$
Q^{t+1}[n]=\exp(-U[n]-(Q^t*k)[n]\times V^T)
$$
Bilateral filtering based $\mu_{ij}$ can also be efficient using some advanced data structure. 



Krahenbuhl Koltun 2011 Efficient CRF inference 

Note, this is the MRF used in Deep Lab segmentation algorithm. (Feed CNN result into MRF). 



### CNN + MRF

Train a CNN to output `U[H,W,C]` per class probability at each pixel. This tensor can be used as an input to MRF

**Algorithm**

```python
U = CNN(I)
Q = U / U.sum(axis=2) # Normalize over labels
for i in range(T):
  # 
  Q = Depthwise_Conv(Q, k)
  Q = Conv(Q, mu)
  # 
```



**Training**

* Separate Training (DeepLab type)
  * Train CNN to output the `U[H,W,C]` with  cross entropy loss with True labels. `CrossEntropy(U,L)` And then use MRF to fine-tune this result. 
  * Note the MRF part has parameters $\mu,k$ i.e. the label distance matrix and spatial kernel. You have to hand crafted (manual optimize the MRF parameters. )
  * *Doesn't give MRF enough work to do, CNN worked too heavy*

* End to end training (CNN-RNN type) 
  * Regard the MRF part as an RNN, which can unroll into a T-layer **shared-weight CNN**. 
  * Thus you can backpropagation through pipeline! 
    * **Benefit**: Joint learning, co-design, Auto-optimize, can do more in inference than training
* **Remark on weight sharing**: 
  * Training needs backprop, need to store intermediate tensor! So unroll can be memory taxing! You cannot train large $T$ ($T\sim5$)
  * But if it's an RNN (sharing weights), you can do more iterations during inference! Using small $T$ in training, large $T$ when deployment 
  * You cannot do this if different layer has different weights. 

**ICCV 2015 Conditional Random Field as RNN**





**Remark: Why MRF do better than some CNN**

* CNN expressive power needs learning, not enough data / training cannot support a deep network. 
* For RNN or MRF, shared weights with iterative computation gives you more than just single pass mapping!  



> A general idea is that you can take a traditional CV algorithm, map the computation to sth. like RNN, and autograd to learn the parameters automatically! Differentiable computing 



## MRF: Graph Cuts Algorithm

This a general technique for MRF inference. 

> Map the loss of MRF into a Weighted Graph Cut problem, and solve it with standard Min-Cut algorithms! 

**Cuts**: a set of edges, deleting which the nodes will be separated into 2 populations. 

For [Min cut problem](https://en.wikipedia.org/wiki/Cut_(graph_theory)), we are partitioning the nodes into 2 groups, and the edge across the 2 groups adds to your loss. In MRF language, each edge essentially has a 2 by 2 symmetric matrix (0 on diagonal), denoting the cost of 2 side with different labels. 

* Easy to see the correspondence to image segmentation. (Binary)

Min-Cut can be solved in polynomial time, and exact global optimum is guanranteed in polynomial time. [Note on graph cut](Note-on-Graph-Cut.md) 

### Binary Label

**Binary label case**: Embed the MRF graph into a weighted graph

* Add 2 extra nodes $\alpha,\beta$ corresponding to 2 labels
* Add 2 edge to each nodes $(i,\alpha),(i,\beta)$ 

Then you can assign a scaler loss to each edge on the new graph, so that the loss the cutting edge correspond to the energy of MRF. 
$$
\arg\min \sum_i E_{ii}(x_i)+\sum_{i,j}E_{ij}(x_i,x_j)
$$

* 

[Note on graph cut](Note-on-Graph-Cut.md)

> GraphCut algorithms really yield promising result of image segmentation, and enables interactive segmentation. 



### Multi-label

**Multi Label Case** it's NP hard. there is only some approximate solutions. 

* It's majorly doing binary graph cut iteratively. 
* Using 2 kinds of steps: alpha-beta swap, alpha expansion. 

**Goal**: Make the improvement in Graph Cut correspond to the cost improvement in the original MRF. Solve part of the problem one at a time. 

$\alpha, \beta$  swap 

$\alpha$ expansion : 

* Those already assigned to $\alpha$ cannot be assigned to others. Only flip $\bar \alpha$ to $\alpha$. 
* Assign weight to edge and edge to label. 
  * 

*Note*: Why alpha can only expand? 

* if alpha shrink, $\bar\alpha$ is not a specific label, so cannot write it's loss function, but $\alpha$ expansion has a definite loss.

>  Sometimes, expand base on one label at a time, will not reach global optimum. There can be oscillating solutions, A,B,C expanding into each other iteratively. 

**Overall Algorithm**

* Initialization
* For $\alpha$ in all the labels
  * Do a alpha expansion graph cut / a Binary label optimizaiton
  * If there decay in energy, accept
  * Or stay put
* Stop if no label changes any more. 



**Comments**: For semantic segmentation, graph cut can work better than belief propagation. 

Tools:

* http://cmp.felk.cvut.cz/~smidm/python-packages-for-graph-cuts-on-images.html



## MRF: Getting Diverse Solutions 

**Motivation**

* Single most likely solution may not be best
* We want multiple solution, usage
  * **Interactive Processing**: Give multiple options, let the user to choose!
  * As a distribution to next stage of processing

> This is also a general technique that could be applied to segmentation, tracking etc. As long as there is MRF. 

### Diverse Solution Formalism

2012 ECCV " Diverse M best solution for MRF! " [Lecture](http://videolectures.net/eccv2012_batra_markov/) 

Diverse solution can be formulate simply: Design a **difference metric**, find the optimal solution for $X$ for $\Delta(X_0,X)>C$. 
$$
X_1=\arg\min_X \sum_iE_i(x_i)+\sum_{ij}E_{ij}(x_i,x_j)\\
s.t. \Delta(X,X_0)=\sum_i\delta(x_i,x_{0i})>C
$$
Assume $\Delta$ to be a pixelwise difference metric.

Traditional constraint optimization can be formulated in Lagrangian Multipliers, the dualized form is 
$$
X_1=\arg\min_X \sum_iE_i(x_i)+\sum_{ij}E_{ij}(x_i,x_j)-\lambda \sum_i\delta(x_i,x_{0i})\\
Find\ \lambda,s.t. \sum_i\delta(x_i,x_{0i})>C
$$
This Lagrangian multiplier can be absorbed into unary term $E_i(x_i)$ , i.e. encourage $x_i$ to take other value than $x_{0i}$,. 

**Comment**: How to determine $\lambda$

* Do a line search on $\lambda$ and find the value that suits the $C$ inequality. 

* **Note**: Actually you don't really care $C$, so you can just tune the $\lambda$ Parameter for best appearance equivalently! 

* Essentially you are imposing a cost for being similar to a solution before, and this cost is imposed through unitary term. 
  * Cost based on multiple pixels will be harder to translate. 



A distribution of solution may give you an interesting array of solutions, some of them may be super good! (M best **diverse** solution is much much better than a single one, using the same base model!)

