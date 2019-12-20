---
layout: post
title: Linux Working Environment Build Up (Updating)
author: Binxu Wang
date: July 25th, 2019
comments: true
categories: [machine learning]
tags: [tech note, coding, Linux, environment, Computation, Machine Learning]
---
* TOC
{:toc}




# Deep Learning Environment

Currently we find that multiple version of CUDA could be installed on windows. And different frameworks could use different CUDA version nicely together. 

## PyTorch Tensorflow Co-environment

Currently, we can have 

* `pytorch 1.3` `torchvision 0.4.2`and `tensorflow 1.15` live together, 
* with 
  * Python 3.7
  * CUDA 10.0 and CUDA 10.1 both installed. 
  * NVIDIA Driver Version: 432.00. 
  * `numpy` version 1.16.4

## PyTorch Caffe Co-environment

