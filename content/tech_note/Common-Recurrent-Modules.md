# Motivation

Recurrent Network falls into the larger topic of sequence modelling. 



# Architecture



## LSTM

The architecture of a LSTM module

![](https://miro.medium.com/max/1400/1*hl9UVtgIcQkDIGD8VFykdw.png)



* `c_t` is the cell memory
* `h_t` is the hidden state

For each of the inner gate variables $f_t$, $i_t$, $g_t$, $o_t$ they are an non-linear function taking $h_{t-1}$ and $x_t$ as input and output the inner state at that moment. 

* [Pytorch implementation of LSTM cell](https://github.com/pytorch/pytorch/blob/c62490bf597ec93f308a8b0108522aa9b40701d9/torch/nn/_functions/rnn.py#L23) 
* 

## GRU



* [Pytorch implementation of GRU cell](https://github.com/pytorch/pytorch/blob/c62490bf597ec93f308a8b0108522aa9b40701d9/torch/nn/_functions/rnn.py#L46) 



## Transformer 

* Enhance parallelization
* Can learn to fetch data from different part of data 



The key is the attention module, for each item in sequence (a representation vector) it propose a key, quest and value vector. Then use inner product of quest and key and soft-max normalization to form a attention matrix, then use this attention matrix to recombine the `value` vectors. 

# Training Practise

As recurrent network can be unrolled through time, 

Some tricks for regularizing and optimizing LSTM based models introduced in [Regularizing and Optimizing LSTM Language Models](https://arxiv.org/pdf/1708.02182.pdf)

* 

Too many steps back in sequence is not easy to back prop, and it could induce gradient explosion or vanishing. 