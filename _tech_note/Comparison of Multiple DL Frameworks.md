---
layout: post
title: Comparison of Deep Learning Frameworks (Updating)
author: Binxu Wang
date: Dec 18th, 2019
comments: true
categories: [machine learning]
tags: [tech note, Machine Learning, Deep Learning]
---

# Objective

Here I want to compare several common deep learning frameworks and make sense of their workflow. 



# Core Logic

## Tensorflow

Generally TF is more like a library, in which many operations are low level and programs are long. 

TF is designed for static graph. Design the computational graph first, and then put in data, and operate really. 

Actually `Keras` which uses `tensorflow`  backend has the similar level of abstraction as `PyTorch` which is easier to use. 

* Data Structure
  * 



## PyTorch 

Logic of pytorch is quite intuitive. PyTorch is designed for dynamics computational graph, very useful for debugging, try out things and for RNN training. 

Generally, `PyTorch` is a great tool for general purpose differentiable computing, not just deep learning. 

* Data Structure
  * `torch.tensor` is the basic data type, which is quite similar to `np.array` format in `numpy`
    * `tensor` behave much like `numpy` so many basic visualization tool can still work with tensor! 
    * But `tensor` only interact with `tensor` don't add `np.array` with `tensor`
    * (For ancient `PyTorch` versions, Tensors could be wrapped up as `Variable`, and for `Variable`  you can set the `requires_grad` flag as `True` to enable gradient computation, [now tensor also support gradient computation](https://www.quora.com/What-is-the-difference-between-a-Tensor-and-a-Variable-in-Pytorch). )
    * `tmp = torch.tensor([1.0,2,3], requires_grad=True)`
  * Just as `numpy` there are different datatypes of data in `tensor` like `torch.float` 
    * `tsr.type(dtype)` will returns you a copy of tensor in the given format. 
  * `tensor` can live in different devices, and only tensor on the same device could operate with each other. 
    * `tsr.device` show you the device it lives in. 
    * `tsr.cpu()` and `tsr.cuda()` returns you the same object if it's already on that device. It will returns you copy if it's not! 
      * `tsr=tsr.cuda()` will transfer data to gpu, but  `tsr.cuda()` itself will not. 

* Gradients computation

  * `requires_grad` could be set for `tensor` (and `Variable`) to enable gradient flow. 
    * This flag will propagate automatically when other variables are constructed depending on a `Variable` that requires gradient. 
    * i.e. Computational graph is generated while performing operation. 
  * `detach` gives you a tensor detached from the computational graph! `.detach()` gives you a copy, and `.detach_()` just modifies the target tensor. 

  * `tensor` s could be put into `torch.autograd` machinery or `torch.optim` optimizers to compute gradients and optimize! 
    * `optimizer = torch.optim.Adam([img_tensor], lr=0.1, weight_decay=1e-6)`
    * `torch.autograd.grad(loss,img_tsr)`

* Neural Networks

  * Basic component of PyTorch is `module` , it normally implements a `forward` and a `backward` function. 
    * Note, as `autograd` is available, you don't always need to write a `backward` function explicitly. You can `loss.backward()` then the gradient just flow back on the graph constructed during `forward` pass. 
  * `module`s could be chained or constructed together to make `models` which we usually call networks. 
  * Flags
    * `model.cuda()` returns you a copy of model with all parameters living on gpu
    * `model.eval()` set the flag into evaluation mode instead of training mode. 

* Conventions 

  * Axis convention `B,C,H,W` same as caffe, but the channel is in `RGB` order. 


## Caffe

* Data Structure 
  * Basic datastructure in Caffe is just `numpy.array` nothing special. 
  * The input and output to layers are `blob` s 
* Neural Networks
  * [Net Layer Blobs](https://caffe.berkeleyvision.org/tutorial/net_layer_blob.html)
  * Neural Network structure could be specified in [`caffe.proto`](https://github.com/BVLC/caffe/blob/master/src/caffe/proto/caffe.proto) format, which is a form of google `protobuf` 
* Conventions 
  * Axis convention `B,C,H,W`  and also the channel direction for images are flipped, so the `[0,1,2]` channel is `BGR` 

## Matlab

* Data Structure
  * Basic data structure in matlab deep learning toolbox is `dlarray` . You have to wrap your normal matrix into `dlarray` to use as input to models. 
  * `dlarray` has a labelled version and a un-labelled version. Labels will tell the framework whats the meaning of each axis. 
  * Some operation requires a un-labelled `dlarray` some requires a labelled `dlarray`
* Neural Networks
  * Neural Networks have `Layers` and a `graph` 


# Peripheral Functionalities

##  Tensorflow

* `Tensorboard`  awesome visualization for the training phase! 
* `Lucid`  awesome infrastruture to visualize and interpret deep neural networks. 

## PyTorch

* `torch.nn.DataParallel` is a great tool, makes parallelized training at almost no cost! 
* 



## See also

[Pytorch vs Tensorflow](https://towardsdatascience.com/pytorch-vs-tensorflow-spotting-the-difference-25c75777377b)