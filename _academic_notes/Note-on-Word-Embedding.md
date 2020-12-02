---
layout: post
title: Note on Word2Vec 
author: Binxu Wang
date: Nov 27th, 2020
comments: true
use_math: true
published: true
categories: [algorithm, machine learning]
tags: [tech note, Unsupervised Learning, Statistical Learning, ML, Representation Learning, Language, NLP]
typora-copy-images-to: ..\assets\img\notes\nlp
---


## Motivation

`Word2Vec`  is a very famous method that I heard of since the freshman year in college (yeah it comes out in 2013). Recently, some reviewer reminds us of the similarity of the "analogy" learnt by the vector representation of words and the vector analogy of image space in GAN or VAE. 

In this note, I'm going to introduce the objective and methods for Word2Vec and discuss some basic observations using their method. 

## Word2Vec

The objective for the method is to find a **good** vector representation of words, which is easier to use than a one hot encoding! 

However, good is a vague word. To find a proxy for this final goal, they defined this quantifiable objective: **predictability of the words in the context given a center word** . 

As a sketch, their model learns two vector, input vector and output vector for each token $v_w,u_w$. Note they choose to have different representations of a word when they are in the context vs they are in the center, which could be a design choice.


$$
\mathcal L=\frac 1T\sum_{t\leq T}\sum_{-c\leq j\leq c,j\neq0}\log p_\theta(w_{t+j}\mid w_{t})\\
p_\theta(w_O\mid w_I) = \frac{\exp{u_{w_O}^Tv_{w_I}}}{\sum^W_{w}\exp{u^T_wv_{w_I}}}
$$


**Comments on Efficiency**: The model looks really simple, and it doesn't even requires a deep NN for `SkipGram` model, it only needs to store two large matrix. As there is no expansion of neural activation, the batch size can be insanely huge > 5000 center, surround batch can well fit on a modest GPU. In the original paper's C implementation, they could train on 10 Billion + words in a PC in a day. 

![Schematics for CBOW and SkipGram](https://github.com/jojonki/word2vec-pytorch/raw/master/word2vec.PNG)



Just to mention, a related method **Continuous Bag-of-Word** used the predictability of the central word given the context as their training objective.

As shown above, its model is to average the embedding of the context words in the window, and use NN to transform this "Continuous Bag of Word" vector to predict the identity of center word using classification. 

$$
\mathcal L=\frac 1T\sum_{t\leq T}\log p_\theta(w_{t}\mid w_{t-c:t+c,\neg t})\\
p(w_t\mid w_{t-c:t+c,\neg t})=SoftMax(NN(\frac 1{2c}\sum_{-c\leq j\leq c,j\neq 0} v_{w_{t+j}}),w_t)
$$

## Training Tricks

The biggest issue is the normalization factor or partition function $Z$, which is a summation over $W$ exponentials of inner product. This is costly and easy to explode, when $W$ is huge (~.5M), while it's major function is to regularize the overall amplitude of vectors. Thus we have ways to achieve this function without incurring huge computational cost.

Techniques to circumvent this is 

* Avoid normalization completely, only maximize the numerator
* Use Hierarchical SoftMax and reduce the time for approximate partition function to $\log W$ 
* Use Negative Sampling, turn the probability maximization problem into a binary classification problem. 
  * This trick has a precursor called Negative Contrastive Estimation here is a [note for comparison](https://arxiv.org/pdf/1410.8251.pdf)



### Hierarchical SoftMax

This is a relatively hard way to implement softmax, and requires some human knowledge about how to construct the tree / hierarchy.

[Intro to Hierarchical SoftMax](https://leimao.github.io/article/Hierarchical-Softmax/) 

[Hierarchical SoftMax in PyTorch Discussion](https://discuss.pytorch.org/t/feedback-on-manually-implemented-hierarchical-softmax/82478)

[Hierarchical SoftMax Implementation in PyTorch](https://github.com/leimao/Two_Layer_Hierarchical_Softmax_PyTorch/blob/master/utils.py#L98) 



### Negative Sampling

Note that, the original probability maximization problem is a $W$ class classification problem for each of the $T$ vectors, ($W$ is the size of vocabulary) with the correct outcome being a one hot vector of the real word in this context, this is the same as cross-entropy loss.

Negative Sampling reframes this multi-classification problem into a binary classification problem, i.e. combining all the classes that are not true words to be false labels. Specifically, given a center word, the context could be classified as positive examples, while some random random other words should be classified as negative samples. The equation for this is simple


$$
\log \sigma(u_{w_c}v_{w_I})+\sum_{w_r\sim P(w)}\log (1-\sigma(u_{w_r}v_{w_I}))
$$


## Evaluation and Property

What property should a **good** embedding have?

In the original paper, it has these features: the similar words are clustered together with cosine similarity. While there is also a analogy structure, where $vec(Man)-vec(woman)+vec(King)\approx vec(Queen)$. Thus these become commonly used benchmark properties for a word embedding. 

## Emergence of these Properties

The authors gave 





## Reference

* [Tutorial on Implementing Word2vec in Pytorch](https://towardsdatascience.com/implementing-word2vec-in-pytorch-skip-gram-model-e6bae040d2fb) 
* [Implementing Word2Vec in Pytorch (CBOW), SamaelChen](https://samaelchen.github.io/word2vec_pytorch/) 

* [Lilian Weng's Post on Word Embedding](https://lilianweng.github.io/lil-log/2017/10/15/learning-word-embedding.html) which has a great discussion about NCE ang Negative Sampling



* Original CBOW paper [Efficient Estimation of Word Representations in Vector Space](https://arxiv.org/pdf/1301.3781.pdf) 
* Original SkipGram paper [Distributed Representations of Words and Phrases and their Compositionality](https://papers.nips.cc/paper/2013/file/9aa42b31882ec039965f3c4923ce901b-Paper.pdf) 