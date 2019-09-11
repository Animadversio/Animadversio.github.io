---
layout: post
title: Note on Computer Vision
author: Binxu Wang
date: July 30th, 2019
comments: true
categories: [computer science]
tags: [academic note, computer vision, computer science, imaging, machine learning]
typora-copy-images-to: ../assets/img/notes/cv/
---

Note on Computer Vision 
========

* TOC
{:toc}
[Lec 1-2 Image Formation]

# Lec01: Image Formation
In principle, **digital images** are formed by measuring energy (*counting photons*) over an array. But several pre-processing steps makes it interesting and relevant to processing. 



* Ceiling & Quantization 





# Lec2: Basic Operation Over an Image



## Pixelwise operation

Apply transform to each pixel separately! (Color, contrast )
$$
Y[i,j,:]=f(X[i,j,:])
$$


* **Grayscale**: $Y[n] = 1/3 (R, G,B)$
  * Color sharpening! 
* **Histogram Equalization**: Find monotonous function $h(x)$ that transform a 
* **Look Up Table(LUT)**

## Convolution

Basic (Linear) operation over a small spatial neibourhood, simplest spatial relationship finder
$$
Y[n]=\sum_{n'} X[n-n']*k[n']
$$




**Convolution scheme**. (different type of convolution operator)

* Valid: $W_Y=W_X-W_K+1$ whenever all pixels are covered by Kernel
* Full: $W_Y=W_X+W_K-1$  whenever any pixels are covered by Kernel
* Same: $W_Y=W_X$ 

**Padding Scheme**

* Zero, constant value
* Same as border
* Circular
* Mirror over border
* Etc. 

**Property**: 

??????????????????????



**Example**: 

* Translation  can be performed by single value convolution kernel!! 

**Blurring**

**Image sharpening** : substract the Blurred image $(1+\alpha)I-\alpha G*I$ . 







**Edge Detection**: Derived from partial differential operator

* Derivative over space is a linear operation! 2 derivative $I_x$ and $I_y$ are 

## Neighborhood operation

### Order Filter

**Median, Maximum, Minimum filter**: : Median can get rid of outliers! 

**Local order statistics**: Median can get rid of outliers! 





### Morphological operation

For Binary value image, 

* Erosion: 
* Growth:
* Opening:  
* Closing: 

### Bilateral Filtering

**Bilateral Filtering**: A more elaborate version of **Gaussian smoothing**. Make the kernel content dependent! $B(n1,n2)$. Let the kernel strength determined by 2 factors, distance between pixel, and value difference between pixel. 
$$
B(n1,n2)\propto\exp(-|n1-n2|^2/\sigma^2-|X[n1]-X[n2]|^2/\sigma_f^2)
$$
The philosophy is, only average over things with similar feature (pixel value). Avoid edge blurring. 
$$
Y[n2]=\sum_{n1}X[n1]*B(n1,n2)
$$
*Note*: Still an active research tool!

* Much less efficient than convolution !! Not an linear operation
* *Distance in the pixel space and distance in the feature space* This is an interesting concept! Can define more distance term in different space! 

##Fourier Transform

**Discrete Fourier Transform** (DFT): The inner product of the image with waves with different wavelength (wave number) and directions. 

$\mathcal F[X]=F(u,v)=\frac WH \sum_{nx,ny}X[nx,ny]$





















