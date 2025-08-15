---
layout: post
title: Note on Hopfield Network
author: Binxu Wang
date: 2021-11-15
# use_math: true
math: true
comments: true
categories: [algorithm, machine learning]
tags: [tech note, Unsupervised Learning, Statistical Learning, ML, RNN]
typora-copy-images-to: ..\assets\img\notes\hopfield
---

## Rationale 

* Hopfield Network can be viewed an energy based model: deriving all properties from it. 

* General RNN has many complex behaviors, but setting symmetric connections can prohibit it! No oscillation is possible in a symmetric matrix. 
* Symmetric matrix allows a global energy to be defined, and the dynamics go down hill of the energy. As long as the memories are stored in local minimum of energy function, it should be good. 
  * **Hopfield**: Store patterns at energy minimum. (similar idea to the natural process of protein folding.)

> I.A.Richards *Principles of Literary Criticism*



> Before google, content addressable memory this is quite amazing. 



## Learning Rules

**Prescription Rule** We can prescribe the weights by the patterns we want to store 
$$
W = XX^T=\sum_{p=1}^{K}x_px_p^T\\
W = (X-1/2)(X^T-1/2)
$$

* In this way, 0.15N memory can be stored well. 
* $N^2$ weights only store $0.15N$ patterns. 



### Error Driven Rules 

> Can we derive a cost function or loss, such that minimize that loss lead to the model learn the data? 

<!--rid of spurious memory by unlearning. --> 

* Don't try to learn all memory at one shot, but learn one memory pattern at a time. (akin to stochastic gradient)

* Regard each neuron as a perceptron, let it predict its own value. Perceptron learning rule for each neuron 
  * akin to "Pseudo likelihood. " in statistics




## Reference

* [Note of hopfield network (nyu.edu)](http://www.cns.nyu.edu/~eorhan/notes/hopfield.pdf) 
* [Hinton's lecture on Hopfield Network](https://youtu.be/DS6k0PhBjpI)

Extension [Modern Hopfield Network]({{< relref "Note-on-Modern-Hopfield-Net-Transformer.md" >}})

