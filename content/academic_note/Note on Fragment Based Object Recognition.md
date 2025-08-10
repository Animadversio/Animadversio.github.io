---
layout: post
title: Note on Fragment Based Object Recognition
author: Binxu Wang
date: 2019-09-25
comments: true
# use_math: true
math: true
categories: [neuroscience]
tags: [academic note, Visual Neuroscience,Computation, Object Recognition, Computer Vision]
---

# Informative Fragment Approach to Object Recognition

It's intuitive that some basic features in the image of objects are  informative to the category of the object. Thus, even for occluded images, the revealed fragments can also provide such information, so that we could recognize the object from few patches. 



## Method: How to Find the Informative Fragment

Obviously, if a image fragment can help the subject to classify the image, the image fragment should present in some category of images but not all of them. Thus, there must be mutual information between the label and the presence of patches! 

To set up the problem, conceive all the images as a set $\mathcal I$ , i.e. so-called image manifold. The classes is a discrete output map defined on the image space $\mathcal C:\mathcal I\mapsto C$, $C$ is the set of all possible labels. On the other hand, the presence of a fragment $F$ is also a function defined on image space, $in_F:\mathcal I\mapsto [0,1]$ . If we binarize the output $in_F>t$, then the result $in_F(I)\in\{0,1\}$ will be binary! 

The problem is to calculate the information that a patch can provide to the category of image. Mutual information means the expected reduction of entropy in $X$ if we know the value of $Y$, ($X,Y$ are random variables). 
$$
I(X,Y)=H(X)-H(X|Y)\\
=H(X)-\sum_yH(X|Y=y)p(Y=y)
$$
To set up MI calculation, we make the images random variables distributed in the images space with density $p(I)$. Thus, category and presence of fragment $F$ are also random variable defined on image space. We want to calculate the mutual information between $\mathcal C$ and $in_F$. Using binarized version of $in_F$, 
$$
I(\mathcal C, in_F)=H(\mathcal C)-H(\mathcal C|in_F(I)=0)p(in_F(I)=0)-H(\mathcal C|in_F(I)=1)p(in_F(I)=1)\\
$$
For the ease of computation, we use an empirical sample from $\mathcal I$ , i.e. finite image set $J$ as the substrate of distribution (distribution can be defined uniformly on this finite set). To write out the computation, the equation reads
$$
I(\mathcal C,in_F)=\sum_i -p(c_i)log(p(c_i)) +p(c_i|F)log(p(c_i|F))p(F)+p(c_i|\bar F)log(p(c_i|\bar F))p(\bar F)\\
$$
We use $p(F)=p(I|in_F(I)=1)$, $p(\bar F)=p(I|in_F(I)=0)$ for abbreviation. 

This calculation can be done in a similar fashion for a single category $C=c_i$ or for multiple fragments, to quantize the information a specific fragment provide to a specific category or a group of fragments provides to images. 

### Implementation in Ullman 2002

In this ancient implementation, they use the following method to define the image includes a fragment $in_F(I)$ .

> "The fragment-to-image comparison used a weighted sum of gray-level gradient and orientation differences. We also tested normalized cross-correlation and the ordinal measure "

It's majorly comparing some convoluted version of image and fragment and calculate that across different positions. 

The candidate fragments are sub-image of predefined size $(p,q)$, cropped from the images. 



Note that in this framework, although there is no backpropagation happening, it still needs labels or categories $C$ to calculate the mutual information, thus it's still supervised. 

## Unsupervised Discovery of Mid-Level Discriminative Patches



Derry 





## Remark 

Middle level feature or patches are behaviorally well founded, form as a mechanism for object recognition in different scenarios and it's highly interpretable.

However, discover features are 



Just as the feature patches carry information about the categories, the informative patches depend on the category they want to discriminate. 

## Neural Correlate 

