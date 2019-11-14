---
layout: post
title: Note on ShapeCollage and Patch Based Shape Interpretation
author: Binxu Wang
date: Nov. 2nd, 2019
comments: true
use_math: true
categories: [computer science]
tags: [academic note, computer vision, computer science, machine learning, visual neuroscience]
typora-copy-images-to: ../assets/img/notes/cv/

---

Note on Patch Based Shape Interpretation
========

These are 2 related papers both employ a **patch based approach** to tackle **shape from shading** problem.

Typically patches have simpler appearance, thus they are easier to collect the statistics on or fit a model on. The spirit is to find a local explanation for patches in an image. However, as there will be ambiguity in local patches, the algorithm should not **over-commiting** to any one of the explanation and keep the distribution of possible shapes. And then take these local shape proposals and see which can stitch together and make sense globally.  

Following this spirit, both of the algorithm has similar general plan. The final optimization goal both comprise of an unary term $D$ and a binary term $\delta$, i.e. the goodness of a local shape interpretation and how compatible are 2 close-by shape interpretation. It's similar to many labeling problem in Computer Vision.
$$
C=\lambda \sum_p D(L_p)+\sum_{(p_i,p_j)\in E}\delta(L_{p_i},L_{p_j})
$$
While sharing the same spirit, in the following aspects, 2 algorithms make very different decisions, thus result in very different algorithms.

* **Extent of local shape candidates**: What are the possible proposals? Can they express natural shapes? How does natural shape prior come into play?
* **Shape representation**: How to represent the shape underlying a local patch? Parametric or non-parametric Good choice makes it easy for patch comparison (similarity, compatibility calculation) and searching (local inference)?
* **Local inference method**: How to find candidates and define the unary cost $D$ (i.e. likelihood of an interpretation.)
* **Compatibility Scoring**: How to score the compatibility of 2 nearby patch? In terms of normal vector or depth?



## Shape Collage

[ShapeCollage: occlusion-aware, example-based shape interpretation](http://people.csail.mit.edu/fcole/shapecollage/index.html)

Forrester Cole, Phillip Isola, William T. Freeman, Fredo Durand, Edward H. Adelson **Shapecollage: Occlusion-aware, example-based shape interpretation.** *European Conference on Computer Vision (ECCV)*, 2012. [[Paper](http://people.csail.mit.edu/fcole/shapecollage/shapecollage.pdf)]

This work doesn't follow a parametrized model of local shape, like [quadratic model](#Theory: Uniqueness of Quadratic Shape), however it follows the empirical rule, try to learn the statistics from the natural distributions of patches.

### Patch Selection

As we know some points are more informative of shape than others, so choose which patch to learn from is an important decision. In this paper, they use a key-point and network based method to select the patches to learn and the patches to do inference.



### Patch Representation

Apparent image is directly useful for comparison, the internal representation used for local shape is a multi-channel one,

* Normal vector field
* Depth field
* Contour
* Ownership mask (object mask)

### Local Inference Method

First, generate interest point graph, by the method above.

1. They match the SIFT descriptor of all the extracted patches and the stored patches. Using criterion for Euclidean distance in feature space to find the most similar patches.
2. Do PCA to dimension-reduce the patches and find the most dominant directions (20-30)
3. Find the most diverse $D$ patches as candidates.

### Globalization

Use standard Max-Mean Loopy belief propagation on a Markov Random Field Network.



### Some Basic Techniques

* [Thin Plate Spline](https://en.wikipedia.org/wiki/Thin_plate_spline)
* [Loopy Belief Propagation]() of Markov Random Field
* Random 3d shape generation.

### Limitation

* The framework is trained on a set of artificially generated blobs. (by finding the isosurface in the filtered white noise.) Thus it learn more about the gradual change of shading than the corner and angles. So it may not be directly applicable to artificial objects which has more sharp corners. 

## Quadratic Shape from Shading: Local Shape based interpretation

[From Shading to Local Shape](http://vision.seas.harvard.edu/qsfs/)

Ying Xiong, Ayan Chakrabarti, Ronen Basri, Steven J. Gortler, David W. Jacobs, and Todd Zickler, "From Shading to Local Shape", *IEEE Transactions on Pattern Analysis and Machine Intelligence,* 2014 (accepted). [[arXiv preprint\]](http://arxiv.org/abs/1310.2916).



### Spirit

Understand shape by local patches, find the explanation of local patch  by fitting a quadratic model on it. Output multiple explanation, and resolve the ambiguity when globalization.

Here the patches are not selected from cropping an images database of  pre-existing shape-image pair, but generated parametricly from the 5 parameter quadratic function model.

### Theory: Uniqueness of Quadratic Shape

Graph of a quadratic function is
$$
z(x,y;a)=a_1x^2+a_2y^2+a_3xy+a_4x+a_5y
$$


The un-normalized normal vector is
$$
n(x,y;a)=[-2a_1x-a_3y-a_4,\ -a_3x-2a_2y-a_5,\ 1]^T=A\bar x
$$
Which is linear to the augmented coordinate $\bar x=[x,y,1]^T$ , transformation matrix is $A$.

If we assume diffuse light imaging with light vector $l$, $\|l\|$ represent the product of albedo and light intensity. The rendering equation goes
$$
I(x,y)=\frac{l^Tn(x,y)}{\|n(x,y)\|}\\
I(x,y)^2=\frac{\bar x^TA^Tll^TA\bar x}{\bar x^TA^TA\bar x}
$$




### Patch Representation

Represented as a 5 entry parameter vector $a$.

But as the theory suggests, if the light source is known, the plausible surface normal lies on a cone, thus could be parametrized $a(\theta)$ by one parameter $\theta$. When doing local inference the patch proposal, $\theta$ is discrietized to $J$ distinct labels for the ease of globalization.

### Local Inference Method

As the local inference is quite simple, the patch can be sampled densely.

Note this local inference can be very dense and be parallelized very well. Very different from the sparser method in ShapeCollage.

### Globalization

Different from shape collage, they jointly optimize the local shape proposal and depth map $Z$, in iterative manner.



### Limitation

* Doesn't consider occluding contour, texture and gloss light.
  * If there is specularity, albedo variation and shadow, it may fail.
* Using quadratic function as the model of local shape, it assume a symmetry and continuity in the $x,y$ plane.
  * Assumption can be violated if there is sharp edge or depth discontinutiy



### Application: Shape Reconstruction

In the condition of

* Textureless, diffuse light imaging,
* Light source and direction is known.
