



## Motivation

`Word2Vec`  is a very famous method that I heard of from the freshman year in college (yeah it comes out in 2013). Recently, some reviewer reminds us of the similarity of the "analogy" learnt by the vector representation of words and the vector representation of image space in GAN or VAE. 

In this note, I'm going to introduce the objective and methods for Word2Vec and discuss some basic observations using their method. 

## Word2Vec

The objective for the method is to find a good vector representation of words! However, to find a proxy for this final goal, they defined this proxy: **predictability of the words in the context given a center word**[^1]. 

As a sketch, their model learns two vector, input vector and output vector for each token $v_w,v_w'$. Note they choose to have different representations of a word when they are in the context vs they are in the center, which could be a design choice.
$$
\mathcal L=\frac 1T\sum_{t\leq T}\sum_{-c\leq j\leq c}\log p_\theta(w_{t+j}\mid w_{t})\\
p_\theta(w_O\mid w_I) = \frac{\exp{v_{w_O}'^Tv_{w_I}}}{\sum^W_{w}\exp{v'^T_wv_{w_I}}}
$$
The model looks really simple, and it doesn't even requires a multi-layer NN for SkipGram model. it only needs to store a large matrix. 



The 

![Schematics for CBOW and SkipGram](https://github.com/jojonki/word2vec-pytorch/raw/master/word2vec.PNG)



[^1]: An related method **Continuous Bag-of-Word** used the predictability of the central word given the context. 

## Training Tricks

### Hierarchical SoftMax

[Intro to Hierarchical SoftMax](https://leimao.github.io/article/Hierarchical-Softmax/) 

[Hierarchical SoftMax in PyTorch Discussion](https://discuss.pytorch.org/t/feedback-on-manually-implemented-hierarchical-softmax/82478)





### Negative Sampling













## Reference

* [Tutorial on Implementing Word2vec in Pytorch](https://towardsdatascience.com/implementing-word2vec-in-pytorch-skip-gram-model-e6bae040d2fb) 
* [Implementing Word2Vec in Pytorch (CBOW), SamaelChen](https://samaelchen.github.io/word2vec_pytorch/) 
* 



* Original paper [Efficient Estimation of Word Representations in Vector Space](https://arxiv.org/pdf/1301.3781.pdf) 