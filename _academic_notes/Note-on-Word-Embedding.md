



## Motivation

`Word2Vec`  is a very famous method that I heard of from the freshman year in college (yeah it comes out in 2013). Recently, some reviewer reminds us of the similarity of the "analogy" learnt by the vector representation of words and the vector representation of image space in GAN or VAE. 

In this note, I'm going to introduce the objective and methods for Word2Vec and discuss some basic observations using their method. 

## Word2Vec

The objective for the method is to find a good vector representation of words! However, to find a proxy for this final goal, they defined this proxy: **predictability of the words in the context given a center word**[^1]. 

As a sketch, their model learns two vector, input vector and output vector for each token $v_w,u_w$. Note they choose to have different representations of a word when they are in the context vs they are in the center, which could be a design choice.
$$
\mathcal L=\frac 1T\sum_{t\leq T}\sum_{-c\leq j\leq c}\log p_\theta(w_{t+j}\mid w_{t})\\
p_\theta(w_O\mid w_I) = \frac{\exp{u_{w_O}^Tv_{w_I}}}{\sum^W_{w}\exp{u^T_wv_{w_I}}}
$$
The model looks really simple, and it doesn't even requires a multi-layer NN for SkipGram model, it only needs to store a large matrix. As there is no expansion of neural activation, the batch size can be huge ~ 5000 center, surround and still fit on GPU. 

![Schematics for CBOW and SkipGram](https://github.com/jojonki/word2vec-pytorch/raw/master/word2vec.PNG)



[^1]: An related method **Continuous Bag-of-Word** used the predictability of the central word given the context. 

## Training Tricks

The biggest problem is the normalization factor or partition function $Z$. Techniques to circumvent this is 

* Avoid normalization completely, only maximize the numerator
* Use Hierarchical SoftMax and reduce the time for approximate partition function to $\log W$ 
* Use Negative Sampling, turn the probability maximization problem into a binary classification problem. 



### Hierarchical SoftMax

[Intro to Hierarchical SoftMax](https://leimao.github.io/article/Hierarchical-Softmax/) 

[Hierarchical SoftMax in PyTorch Discussion](https://discuss.pytorch.org/t/feedback-on-manually-implemented-hierarchical-softmax/82478)



### Negative Sampling

Note that, the original probability maximization problem is a W class classification problem for each of the T vectors. (W is the size of vocabulary) Negative Sampling is transforming this multi-classification problem into many binary classification problem, i.e. given a center word, the context could be classified as positive examples, while some random random other words should be classified as negative samples. The equation for this is simple
$$
\log \sigma(u_{w_c}v_{w_I})+\sum_{w_r\sim P(w)}\log (1-\sigma(u_{w_r}v_{w_I})) 
$$


## Evaluation and Property

What property should a good embedding have?

In the original paper, it has these features: the similar words are clustered together with cosine similarity. While there is also a analogy structure, where $vec(Man)-vec(woman)+vec(King)\approx vec(Queen)$. Thus these become commonly used benchmark properties for a word embedding. 

* 

## Reference

* [Tutorial on Implementing Word2vec in Pytorch](https://towardsdatascience.com/implementing-word2vec-in-pytorch-skip-gram-model-e6bae040d2fb) 
* [Implementing Word2Vec in Pytorch (CBOW), SamaelChen](https://samaelchen.github.io/word2vec_pytorch/) 

* [Lilian Weng's Post on Word Embedding](https://lilianweng.github.io/lil-log/2017/10/15/learning-word-embedding.html) which has a great discussion about NCE ang Negative Sampling



* Original paper [Efficient Estimation of Word Representations in Vector Space](https://arxiv.org/pdf/1301.3781.pdf) 