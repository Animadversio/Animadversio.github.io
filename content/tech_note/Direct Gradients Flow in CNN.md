---
layout: post
title: Direct Gradient Flow in a CNN
author: Binxu Wang
date: 2019-07-01
# use_math: true
math: true
comments: true
# # published: false
draft: true
draft: true
categories: [machine learning]
tags: [tech note, Machine Learning,  coding]

---

# Caffe 

> By convention, Caffe layer types with the suffix `Loss` contribute to the loss function, but other layers are assumed to be purely used for intermediate computations. However, any layer can be used as a loss by adding a field `loss_weight: <float>` to a layer definition for each `top` blob produced by the layer. Layers with the suffix `Loss` have an implicit `loss_weight: 1` for the first `top` blob (and `loss_weight: 0` for any additional `top`s); other layers have an implicit `loss_weight: 0` for all `top`s.



https://github.com/BVLC/caffe/issues/583

https://stackoverflow.com/questions/31324739/finding-gradient-of-a-caffe-conv-filter-with-regards-to-input



# PyTorch

Pytorch support autograd now but before it's using the computational graph, for which each `module` has its own `forward` and `backward` function, and these will be called in sequence to compute the total gradient. 

