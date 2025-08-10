---
layout: post
title: Note on Automatic 3D Instance Segmentation Pipeline 
author: Binxu Wang
date: 2018-12-09
comments: true
# use_math: true
math: true
categories: [Neuroscience, machine learning]
tags: [tech note, Image Analysis, Machine Learning, Connectomics]
---
# Note on Automatic 3D Instance Segmentation Pipeline 

In this note I try to summarize several recent works on Automatic 3D Instance Segmentation, with most direct application to **saturated reconstruction** of neural morphology in an imaging volume (mostly scanning Electral Microscopy, but seems it can be generalized into other imaging modality), which is one of the most important method of **high-throughput connectomics**[^1]. 

[^1]: Without the constraint of large scale / high throughput, one may use manual annotation or various virus tracing technique to map the connectome. But to really reveal and reconstruct "everything" in a volume the only method we have is imaging esp. EM. 

This note is majorly based on the reading of the [Flood Fill Network](https://ai.google/research/pubs/pub46992) from Google Connectomics research, [Cross-Classification Clustering (3C)](https://arxiv.org/abs/1812.01157) from MIT computational connectomics group and the [Flexible Learning-free Reconstruction of Imaged Neural volumes pipeline (FLoRIN)](https://www.nature.com/articles/s41598-018-32628-3) from Notro Dame and Allen Institute. (One thing is, there is a much smaller community of Connectomics even across America, so the code online and packages are not so well documented than the deep learning ones, in some "pipelines" the pipes have not been connected yet, so there is a bit work to convert the file and make the interface. ) 

## Challenge



## Tools


### FLoRIN
Learning-free framework! 


### Flood Fill Network

* Needs training to make inference on new volume
* As stated in the paper, it's Computationally Expensive!! 
* 

### 3C pipeline and MaxExtend
* 




## Workflow



## Result Analysis (post-processing)




