---
layout: post
title: Note on Deep Unsupervised Learning
author: Binxu Wang
date: 2019-09-13
comments: true
# use_math: true
math: true
categories: [machine learning]
tags: [academic note, computer vision, computer science, machine learning]
typora-copy-images-to: ../assets/img/notes/DUL/

---

Deep Unsupervised Learning
======

Lecture notes from Berkeley-cs294  https://sites.google.com/view/berkeley-cs294-158-sp19/home

# Lec 1 

**Category**

* Generative Model
* Non-generative representation learning

## Motivation for Unsupervised Learning



**Application**

* Generate/predict fancy samples
* Detect Anomaly / deviation from distribution
  * Which human can do quite well without training
* Data Compression (because of predictability)
* Use the inner representation to do other tasks! 
* Pre-training

## Type of Question

**Core Question**: Modeling a Distribution

* **Density estimation**: Given $x$ Be able to speak out $p(x)$
* **Sampling**: Generate new $x$ according to $p(x)$

## Where classic statistics fail

**Naïve method of density estimation**: Histogram



**Lesson from failure of Histogram**

* In high dimension, histogram model means **model = input dataset**
* **Curse of dimensionality** 
  * If each density function $p(x)$ is a independent variable at each point, then parameter dim is too high! 
  * If each data point only contributes to the estimation of one parameter, we will never have enough data points! 
* So we need to model distribution as a parametrized function $p(x;\theta)$  $\theta$ will be lower dimen than the continuous space
* Data should be reused as much as possible to estimate $\theta$  