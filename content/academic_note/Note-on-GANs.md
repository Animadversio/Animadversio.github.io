---
layout: post
title: Note on Generative Adversarial Network
author: Binxu Wang
date: Mar 7th, 2020
comments: true
use_math: true
categories: [machine learning]
tags: [academic note, generative model, computer vision, computer graphics, machine learning, deep learning]
typora-copy-images-to: ../assets/img/notes/GAN/
---
Note on GAN
====
Note with reference to the Youtube lecture series Hongyi Li. 

# Architecture Developments



## Self Attention

Used in Self-Attention GAN and BigGAN

```python
class Self_Attn(nn.Module):
    """ Self attention Layer"""
    def __init__(self,in_dim,activation):
        super(Self_Attn,self).__init__()
        self.chanel_in = in_dim
        self.activation = activation
        
        self.query_conv = nn.Conv2d(in_channels = in_dim , out_channels = in_dim//8 , kernel_size= 1)
        self.key_conv = nn.Conv2d(in_channels = in_dim , out_channels = in_dim//8 , kernel_size= 1)
        self.value_conv = nn.Conv2d(in_channels = in_dim , out_channels = in_dim , kernel_size= 1)
        self.gamma = nn.Parameter(torch.zeros(1))

        self.softmax  = nn.Softmax(dim=-1) #
    def forward(self,x):
        """
            inputs :
                x : input feature maps( B X C X W X H)
            returns :
                out : self attention value + input feature 
                attention: B X N X N (N is Width*Height)
        """
        m_batchsize,C,width ,height = x.size()
        proj_query  = self.query_conv(x).view(m_batchsize,-1,width*height).permute(0,2,1) # B X CX(N)
        proj_key =  self.key_conv(x).view(m_batchsize,-1,width*height) # B X C x (*W*H)
        energy =  torch.bmm(proj_query,proj_key) # transpose check
        attention = self.softmax(energy) # BX (N) X (N) 
        proj_value = self.value_conv(x).view(m_batchsize,-1,width*height) # B X C X N

        out = torch.bmm(proj_value,attention.permute(0,2,1) )
        out = out.view(m_batchsize,C,width,height)
        
        out = self.gamma*out + x
        return out,attention
```

## Style GAN





## BigGAN







# Conditional GAN 

## Text Conditioning

Text is processed and combined with noise vector. 

## Image Conditioning

Image could be sent directly as spatial input! Thus you have conditional GAN. 

**Comments**: Conditional GAN is similar to supervised learning, but doesn't map one input to one single output, you can get a distribution of possible output based on one input. Instead of getting a mean output! 

Conditioning vector should be sent into Discriminator to inform him what to discriminate. 

# Unsupervised Conditional GAN





# Theory of GAN 

Minimize some divergence between 2 distributions. Note when the discriminator is fully trained then the output score of it should match the relative probability of natural image and synthesized image. 

Thus the optimal discriminator loss is a form of divergence between 2 distributions, i.e. "Discriminability". This discriminability should decrease as better and better G is trained. 

Thus you should really 
