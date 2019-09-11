---
layout: post
title: Note on Computer Vision
author: Binxu Wang
date: Semptember 10th, 2019
comments: true
use_math: true
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

## Global Feature Detection: Hough Transform

* Define a parametrization of the space of the object (e.g. parametrize all line on plane by $(r,\theta)$ pair for $r=\cos\theta x+\sin\theta y$)  
* Each point vote for the objects it could belong to. Summarize over all the pixels
* Long lines and large global structure gets amplified! 
  * **Note**: Useful for easily parametrized objects like lines, circles, ellipses, segments



## Neighborhood operation

We can define such operations based on a neighborhood function $N:\Delta n\mapsto{0,1}$ defined in some neighborhood! 

### Order Filter

**Median, Maximum, Minimum filter**: : 

* Median can get rid of outliers! 
* Combine max and min $Y[n]=max / min{X[n−n′]}N[n′]>0$ 

**Local order statistics**: Median can get rid of outliers! 



### Morphological operation

For Binary value image $I[n]\in\{0,1\}$, 

* Erosion: $F[n]==1\ if\ I[n+\Delta n]==1\ \forall \Delta n\ s.t. N(\Delta n)==1 $
  * $F[n] = \text{AND}~~ \{ I[n-n'] \}_{N[n'] = 1}$
* Growth:$F[n]==1\ if\ I[n+\Delta n]==1\ \exist  \Delta n\ s.t. N(\Delta n)==1$ 
  * $F[n] = \text{OR}~~ \{ I[n-n'] \}_{N[n'] = 1}$
* Opening:  Erosion * n + Growth *m
* Closing: Growth *m + Erosion * n 

*Note*: these 2 operators does not commute! 

### Bilateral Filtering

**Bilateral Filtering**: A more elaborate version of **Gaussian smoothing**. Make the kernel content dependent! $B(n1,n2)$. Let the kernel strength determined by 2 factors, distance between pixel, and value difference between pixel. 
$$
B(n1,n2)\propto\exp(-|n1-n2|^2/\sigma^2-|X[n1]-X[n2]|^2/\sigma_f^2)
$$
The philosophy is, only average over things with similar feature (pixel value). Avoid edge blurring. 
$$
Y[n2]=\sum_{n1}X[n1]*B(n1,n2)
$$
*Note*: Still an active research area!

* Much less efficient than convolution !! Not an linear operation
* *"Distance in the pixel space and distance in the feature space"* This is an interesting concept! Can define more distance term in different space! (like kernel / feature space)





## Fourier Transform

**Discrete Fourier Transform** (DFT): The inner product of the image with waves with different wavelength (wave number marked by $(u,v)$) and directions $S_{uv}[nx, ny]$.   
$$
\mathcal F[X]=F(u,v)=\frac 1{WH} \sum_{nx,ny}X[nx,ny]​\exp(-j2\pi (unx/W+vny/H))
$$
**Basic Property:**

* Can be view as a global coordinate transform of the image space $\R^{H\times W}$ 
  * If Image is vectorized, then the DFT is a complex orthonormal (Unitary) matrix $S^*$ over the space $\R^{H\times W}$ 
    * $F=\frac 1 {\sqrt {WH}}S^* X$, $X={\sqrt {WH}}S F$ 
    * It's inverse is the conjugate transpose of the matrix
  * $S_{uv}[nx, ny]=\frac 1{\sqrt{WH}} \exp(-j2\pi (unx/W+vny/H))$ Defines the orthonormal basis-> a group of waves. 
    * The real and imagine part of $S_{uv}[nx, ny]$ defines 2 different phase of wave, 



* $F(u,v) $ is a complex image, 



### Processing the Fourier Spectrum

**Fourier Space Filtering**: Masking the Fourier Representation $F$ will do blur / sharpen the image! 

* Larger spatial Gaussian Kernel ~ Sharper low pass filter
* Derivative Kernel ~  Gaussian Space



**Content in the Phase**: The phase is more important to define the spatial configuration of an image

* Phase defines where the interference peak and sharp edge resides
* Pure amplitude $|F|^2$ is agnostic to space! Uniform! 
* **Corollary**: If swap phase $\theta$ between image A and B and keep $|F|^2$, then the content largely swap with phase! 

[Demonstration](https://www.cse.wustl.edu/~ayan/courses/cse559a/lec5.html#/fourier-transform-20) 

### Convolution in Fourier space

















