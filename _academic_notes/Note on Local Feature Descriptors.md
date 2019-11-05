---
layout: post
title: Note on Local Feature Descriptors
author: Binxu Wang
date: Nov. 4th, 2019
comments: true
use_math: true
categories: [computer science]
tags: [academic note, computer vision, computer science, machine learning]
typora-copy-images-to: ../assets/img/notes/cv/
---

Note on Local Feature Descriptors
========

Before the advent of convolutional neural network, many techniques to represent and detect local features has been invented. As lower level feature detector, many of them are strongly mathematically motivated. Some are still used in some Computer Vision tasks as preprocessing step. 

For a total catalogue, see the table on wiki page [Feature Detection](https://en.wikipedia.org/wiki/Feature_detection_(computer_vision)) . 



## Structure Tensor

Considering the Image intensity as a surface over the $(x,y)$ coordinate chart. Then, the structural tensor is just **the first fundamental form** of this surface, and we can convolve each entry with a filtering weight matrix $w$ to summarize local gradient information. 
$$
S_0[p]=\begin{pmatrix}I_x[p]^2 & I_x[p]I_y[p]\\
						I_x[p]I_y[p] & I_y[p]^2\end{pmatrix}\\
S_w[p]=w*S_0
$$

* Trace of Structure tensor gives you the strength of gradient locally. 
* The difference of 2 eigen vector gives you the anisotropy of the local area. 
* If one eigenvalue is 0 (degenerate), then the local image will be stripe like.



## HOG (Histogram of Gradient)





## SIFT (Scale Invariant Feature Transform)

https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_feature2d/py_sift_intro/py_sift_intro.html

https://blog.csdn.net/zddblog/article/details/7521424

SIFT is the pipeline of a bunch of operations. 