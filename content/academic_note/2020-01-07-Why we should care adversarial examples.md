---
layout: post
title: Understanding of Adversarial Attack
author: Binxu Wang
date: '2020-01-07'
# published: true
draft: false
use_math: true
comments: true
categories: [machine learning]
tags: [Computer Vision, Adversarial Example, Neural Networks]
---

# Understanding of Adversarial Attack

Why we should care adversarial examples? Why they are surprising? 

Adversarial example and feature visualization are related intrinsically. Basic algorithm underlying both is to generate image that activate a unit most. For Adversarial attack, the point is to change the image in an in-perceptible way but change the network output dramatically. On the other hand the feature visualization is to generate a perceptually meaningful pattern that represent a natural image that the unit like. 

To put it formally, denote an output unit as a function over image space $f_i(.)$, $i\in\{1:n\}$, $i$ correspond to the class number. So for adversarial attack the point is to 
$$
\mbox{Find $I$ such that, }
\|f_i(I+\delta I)-f_i(I)\| \mbox{ is significant}\\
d(I+\delta I,I) \mbox{ is small.}
$$
With $d(.,.)$ as any **perceptual similarity metric** [^0].

[^0]: For example, this pytorch repo [PerceptualSimilarity](https://github.com/richzhang/PerceptualSimilarity) . 

For feature visualization, it strives for 
$$
\mbox{Find $I$ such that, } 
p(I) \mbox{ is high for natural image prior}\\
f_i(I) \mbox{ is high.}
$$
with $p(.)$ a **natural image prior** [^1].

[^1]: For example the DAE (denoising auto-encoding) prior, smooth prior or GAN "prior". 

And the key difference and one that connect the two topic together is the condition under which they do optimization. One of the key to the adversarial example is its im-perceptibility to human visual system. 

## Connection from Feature Visualization to Adversarial Attack

A well known **artifact** for feature visualization is the high frequency artifact[^2]. If you  $\arg\max_I\ f_i(I)$ by backpropagtion through the composite function $f_i$. The resulting image $I^*$ will be filled with high frequency artifacts. And the essential work of feature visualization is use regularization to counteract these artifacts[^2]. 

The mechanistic reason is, back propagation through CNN to image introduce enhancement to certain frequency. Mathematically, back-propagation through conv layers are the same as deconvolution. As the convolutional kernal size and strides are usually not integer multiplier of each other, there will be checkerboard like artifacts due to overlap[^3]. 

It has been speculated that these checkerboard / high frequency artifacts are closely related to adversarial attacks. Denoting the high frequency pattern as $\epsilon F$, then it's possible that $f_j(\epsilon F)$ is high. With a approximately linear function $f_j$, $f_j(\epsilon F+I)$ is high as well. It's easy to imagine this high activation cause a false classification at last. However, though we may perceive $\epsilon F$ *per se*, i.e. $d(\epsilon F,0)>\delta$ . The perturbation to image is not perceptible $d(I,I+\epsilon F)<\delta$ . 

From this viewpoint we know the adversarial attack has a deep root in the difference of perceptual similarity metric between human and CNN. 

[^2]: https://distill.pub/2017/feature-visualization/
[^3]: https://distill.pub/2016/deconv-checkerboard/

## Interpretation of Adversarial Attack

There have been an abundance of work trying to understand adversarial attack phenomenon. One interesting work is "Adversarial examples are not bug, but features"[^adv]. Their thesis is the adversarial patterns can be useful features to classify images, but not perceptible to human eye and / or non-robust. (specific to limited image samples.) 

Thus in their experiment, when they use adversarially perturbed cat image (classified as dog) and dog image as sample to train CNN, 

[^adv]: Adversarial Examples Are Not Bugs, They Are Features http://gradientscience.org/adv/

https://distill.pub/2019/advex-bugs-discussion/