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
Thus the Structure Tensor discribe the local intensity landscape in a differential geometry manner! 

* Trace of Structure tensor gives you the strength of gradient locally. 
* The difference of 2 eigen vector gives you the anisotropy of the local area. 
* If one eigenvalue is 0 (degenerate), then the local image will be stripe like.

[wiki](https://en.wikipedia.org/wiki/Structure_tensor)

## Harris Corner Detector 

Using the Structure Matrix, it finds spot where both of the eigen values are large. Some approximate computation method includes

* $\min(\lambda_1,\lambda_2)$ 
* $M=\lambda_1\lambda_2-\kappa(\lambda_1+\lambda_2)^2 =\det(S)-\kappa tr(S)$ 



[Harris Detector](https://en.wikipedia.org/wiki/Corner_detection#The_Harris_&_Stephens_/_Plessey_/_Shi–Tomasi_corner_detection_algorithms)
<!-- [https://en.wikipedia.org/wiki/Corner_detection#The_Harris_&_Stephens_/_Plessey_/_Shi%E2%80%93Tomasi_corner_detection_algorithms] -->

## HoG (Histogram of Oriented Gradient)

HoG is actually a simplified version of SIFT descriptor. 

[Histogram of Oriented Gradient](https://en.wikipedia.org/wiki/Histogram_of_oriented_gradients)

## SIFT (Scale Invariant Feature Transform)



SIFT is the pipeline of a bunch of operations, which finds keypoints in an image and build scale+orientation invariant descriptors for them. 

Widely used in correspondence matching. 

**Reference** 

* [Doc from OpenCV2](https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_feature2d/py_sift_intro/py_sift_intro.html)

  [Elementary Chinese Blog](https://blog.csdn.net/zddblog/article/details/7521424) 

  [SIFT theory and practice](http://aishack.in/tutorials/sift-scale-invariant-feature-transform-introduction/) 

  [SIFT on Towards DataScience](https://towardsdatascience.com/sift-scale-invariant-feature-transform-c7233dc60f37)

  [VL_feat library]( http://www.vlfeat.org/api/sift.html )