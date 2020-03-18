---
layout: post
title: Note on Generative Adversarial Network
author: Binxu Wang
date: Mar 7th, 2020
comments: true
use_math: true
categories: [machine learning]
tags: [academic note, generative model, computer vision, computer graphics, machine learning, deep learning]
typora-copy-images-to: ../assets/img/notes/cv2/
---
Note on GAN
====
Note with reference to the Youtube lecture series Hongyi Li. 

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
