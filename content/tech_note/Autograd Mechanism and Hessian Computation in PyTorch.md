---
layout: post
title: Autograd Mechanism and Hessian Computation in PyTorch
author: Binxu Wang
date: 2019-12-09
comments: true
use_math: true
categories: [machine learning, algorithm]
tags: [tech note, Machine Learning, Algorithm, Linear Algebra]
---

## Motivation

Sometimes we want to examine the Hessian or Jacobian of a function w.r.t some variables. For that purpose, autogradient algorithm can help us. 

## Autograd mechanism 

In Essence, `Autograd` requires a computational graph. (*Directed Acyclic Graph*) For each computational node (e.g. $z=f(x,y)$), we define a forward computation $(x,y)\mapsto z,\ z=f(x,y)$ mapping bottom to top, and a backward computation mapping the partial derivative to top to the partial derivative to bottom. $\partial_z\mapsto (\partial_x,\partial_y); (gx,gy)=g(gz;x,y)$ .  

Note that, the backward computation $g$ is *not a function*. In the sense that, it depends on inner variables, same $gz$ can be mapped to different $(gx,gy)$, depending on $x,y$. As a simplest example, for a linear operation[^1] (like convolution), 
$$
z=f(x,y)=x^Ty\\
g(\partial_z)=(\frac{\partial z}{\partial x}\partial_z,\ \frac{\partial z}{\partial y}\partial_z)=(y\partial_z, x\partial_z)
$$
Thus, the node has to store the operand $(x,y)$ in the latest forward pass, which is part of the computational graph. Thus keep track of the operands or output can take up a large amount of memory. 

Note for some nodes, the backward operation only depends on output, like for $y=Relu(x)$, $\partial_x=\partial_y\ if\ y>0 \ else\ 0$. and for sigmoid function $y=s(x),\ \partial_x=y(1-y)\partial_y$. 

So some important things are 

* when to create the computational graph
* what to keep track of (if some part doesn't need gradient discard that subgraph)
* when to let go and compute a new graph

[^1]:*Note*, this credit assignment computation of linear operation is educational, in that the larger argument in $(x,y)$ will get less gradient, and smaller argument will get more! 

Note from the [official documentation]( https://pytorch.org/docs/master/notes/autograd.html ), we know the default behavior is, 

> An important thing to note is that the graph is recreated from scratch at every iteration, and this is exactly what allows for using arbitrary Python control flow statements, that can change the overall shape and size of the graph at every iteration. You don’t have to encode all possible paths before you launch the training - what you run is what you differentiate. 

And there are some flags that we can add to control what to keep. 

* `create_graph` 
* `retain_graph`

## Hessian Vector Product





## Higher Order Gradient Computation

For a function $y=f(x)$, we can easily compute $\partial_x y=g_x$. If we would like to use auto-grad to compute higher order gradient, we need a computational graph from $x$ to $g_x$.  This is a key idea! The gradient is also a function of input $x$ and weights $w$. 

```python
torch.autograd.backward(tensors, grad_tensors=None, retain_graph=None, create_graph=False, grad_variables=None)
torch.autograd.grad(outputs, inputs, grad_outputs=None, retain_graph=None, create_graph=False, only_inputs=True, allow_unused=False)
```

In current `pytorch` release version, create graph to gradient is explicitly supported! So what we need is to `create_graph` when creating the first order gradient, and send each element in the gradient vector back to `torch.autograd.grad`, but set `create_graph=False` since we don't need 3rd order gradient anymore. 

Sample code from this repository (See package [hessian]())



## Memory Efficiency in Back Propagation

For a deep and large network, keeping track of all the internal states, input and output in order to backprop smoothly, will cost a tons of memory. 

So if we are limited in memory, we can recompute some of the internal states because all we needs is some former internal states. 

And by selecting which nodes to recompute and which node to keep, we can achieve a large memory saving and lose a little in speed. This is exactly what [gradient checkpointing](https://github.com/cybertronai/gradient-checkpointing) is doing! 

https://hub.packtpub.com/openais-gradient-checkpointing-package-makes-huge-neural-nets-fit-memory/ 

## Forward Autograd 

Connected to the last point, forward differencing has the great benefit of saving memory since the intermediate states are irrelevant. And it's suitable for few input, numerous output case. 



