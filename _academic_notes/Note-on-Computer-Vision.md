---
layout: post
title: Note on Computer Vision
author: Binxu Wang
date: September 10th, 2019
comments: true
use_math: true
categories: [computer science,courses]
tags: [academic note, computer vision, computer science, imaging, machine learning]
typora-copy-images-to: ../assets/img/notes/cv/
---

Note on Computer Vision 
========

Lecture Notes from CS559. 

* TOC
{:toc}


# Lec01: Image Formation
In principle, **digital images** are formed by measuring energy (*counting photons*) over an array. But several pre-processing steps makes it interesting and relevant to processing. 



* Ceiling & Quantization 





# Lec2: Basic Operation on Image



## Pixelwise operation

Apply transform to each pixel separately! (Color, contrast )
$$
Y[i,j,:]=f(X[i,j,:])
$$


* **Grayscale**: $Y[n] = 1/3 (R, G,B)$
* Color sharpening/de-sharpen: subtract/add the Gray scale image 
* **Histogram Equalization**: Find monotonous function $h(x)$ that transform a variable X with empirical distribution $hist(X[n])$ to be as uniform as possible
* **Look Up Table(LUT)**: map each value (R,G,B) or intensity to a different value.



## General Efficiency Note

- Start implementation with for loop! 
- Avoid for-loop. If you have to put it in inner most part! 
- Substitute for loop with elementwise operation & convolution! 



## Convolution

> Linear operation over a small spatial neighborhood, simplest spatial relationship finder

$$
Y[n]=\sum_{n'} X[n-n']*k[n']
$$

*Remark*: The minus sign differs **convolution** from **correlation** , convolution can be understood best by considering Point Spread Function (https://en.wikipedia.org/wiki/Point_spread_function), i.e. input at $X[n]$ results in the response linear to the kernel $k[n']$ 

**Convolution scheme**. (different type of convolution operator)

* Valid: $W_Y=W_X-W_K+1$ whenever all pixels are covered by Kernel
* Full: $W_Y=W_X+W_K-1$  whenever any pixels are covered by Kernel
* Same: $W_Y=W_X$ 
  * *Note*: Think about the convolution matrix $A_k$ in 1d case, its shape will be like $[W_Y, W_X]$ . So for Same convolution, it will be an linear operator! 

**Padding Scheme**

* Zero, constant value
* Same as border
* Circular
* Mirror over border
* Etc. 

**Property**: 

??????????????????????



### Application of Convolution 

**Translation**: can be performed by convolving single value convolution kernel!! 

* Think about the input response function. 

**Blurring** : $G*I$ 

**Image sharpening** : substract the Blurred image, $(1+\alpha)I-\alpha G*I$ . 

**Edge Detection**: Derived from partial differential operator

* Derivative over space is a linear operation! 
* 2 derivative $I_x$ and $I_y$ are sufficient to compute derivative of any direction $I_\theta=\cos\theta I_x+\sin \theta I_y$ 

## Hough Transform: Global Feature Detection

* Define a parametrization of the space of the object (e.g. parametrize all line on plane by $(r,\theta)$ pair for $r=\cos\theta x+\sin\theta y$)  
* Each point vote for the objects it could belong to. Summarize over all the pixels
* Long lines and large global structure gets amplified! 
  * **Note**: Useful for easily parametrized objects like lines, circles, ellipses, segments



## Other Neighborhood operation

We can define such operations based on a neighborhood function $N:\Delta n\mapsto{0,1}$ defined in some neighborhood! 

### Order Filter

**Median, Maximum, Minimum filter**: 

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



**Property**: 



## Fourier Transform

**Discrete Fourier Transform** (DFT): The inner product of the image with Complex waves (cos in Real, sin in Imaginary) with different wavelength (wave number marked by $(u,v)$) and directions $S_{uv}[nx, ny]$.   

Intuition of the average amplitude and position of a variation in certain spatial frequency. 
$$
\mathcal F[X]=F(u,v)=\frac 1{WH} \sum_{nx,ny}X[nx,ny]​\exp(-j2\pi (unx/W+vny/H))
$$
**Basic Property:** 

* Can be view as a global coordinate transform of the image space $\R^{H\times W}$ 
  * If Image is vectorized, then the DFT is a complex orthonormal (Unitary) matrix $S^*$ over the space $\R^{H\times W}$ 
    * $F=\frac 1 {\sqrt {WH}}S^* X$, $X={\sqrt {WH}}S F$  
    * It's inverse $S^{-1}=\bar S^T$ is the conjugate transpose of the matrix
  * $S_{uv}[nx, ny]=\frac 1{\sqrt{WH}} \exp(-j2\pi (unx/W+vny/H))$ Defines the orthonormal basis -> a group of waves of different directions $(u,v)$ and phase $\sin.\cos$.  
    * The real and imagine part of $S_{uv}[nx, ny]$ defines 2 different phase of wave, 
    * $S$ is a unitary matrix if we linearize index into vector. 
* $F(0,0)$ is the average intensity of image $X$ ! 
  * Can be super large if not not normalized
  * Usually 0 for kernels 
* $F(u,v) $ is a complex image, by symmetry, just $WH$ independent variables. 



### Processing the Fourier Spectrum

**Fourier Space Filtering**: Masking the Fourier Representation $F$ will do blur / sharpen the image! 

* Larger spatial gaussian kernel ~ Narrower low pass filter
* Derivative Kernel ~  Gaussian Spatial derivative



**Content in the Phase**: The phase is more important to define the spatial configuration of an image

* **Relative Phase** defines where the interference peak and sharp edge occurs
* Pure amplitude $\|F\|^2$ is agnostic to space! 
* **Corollary**: If swap phase $\theta$ between image A and B and keep $ \|F\|^2$, then the content largely swap with phase! 

[Demonstration](https://www.cse.wustl.edu/~ayan/courses/cse559a/lec5.html#/fourier-transform-20) 

### Convolution Theorem

Here we use convolution on 1d signal as illustration. 

Convolution is a linear operation, thus can be think of as a matrix $A$ operating on the signal vector $X$. $Y=AX$. Note that $A$ has interesting structures

* For a same convolution, $A$ is a square matrix.   
* For convolution with circular padding, A is a [circulant matrix](https://en.wikipedia.org/wiki/Circulant_matrix)
  * Circulant matrix is well known to have the same **eigen vectors** the $n$ Fourier modes for $n$ points. $v_k=[z_n^{0k},z_n^{1k},...z_n^{(n-1)k}]$ with $z_n$ as the n order unit root. 
  * The **eigen value** of Circulant matrix is $\lambda_k=\sum_jz_n^{jk}c_j=(Fc)_k$ and thus can be written as $\Lambda=Fc$ 
  * Thus it can be diagonalize by the DFT matrix. $F[u,x]=\frac1nz_n^{xu}$ and inverse DFT matrix as $F^*[y,u]=z_n^{-yu}$  

Because of this, when we do convolution, we can represent the convolution in the Fourier basis. i.e. 
$$
\mathcal F(Y) = \mathcal F(A)\mathcal F(X)\\
FY=FAF^*FX
$$
And the convolution operator becomes a diagonal matrix $FAF^*=diag(\Lambda)$. Beacuse of this  
$$
FY=FAF^*FX=diag(\Lambda)FX=Fc\circ FX
$$
Thus we have the **Convolution Theorem** 

Besides, the Fourier Transform for the de-convolution operator is the complex conjugate of the convolution one. 


$$
\mathcal{F}(A^T)=FA^TF^*=(\bar FAF^T)^T=diag(\bar \Lambda)
$$


For math facts about circulant matrix check [MIT notes](http://web.mit.edu/18.06/www/Spring17/Circulant-Matrices.pdf)

## Efficient Computation of Convolution

**Frequency Space Convolution**

* DFT is computed in $o(nlog(n))$ time scale
* Thus convolution in Frequency Domain can be done by 3 FFT at  $o(nlog(n))$ time scale
* Desirable for Large Kernels

**Seperable Kernels**

* H, W seperable kernel like *Gaussian Kernel, Derivative Gaussian* 
* If $G=G_xG_y^T=Gx*Gy$, then $I*G=(I*G_x)*G_y$ . 
  * $H+W<HW$ 
* *Note* : 
* Note an in-separable kernel may be sum of separable kernels like $(1+\alpha)\delta-\alpha G_\sigma=(1+\alpha)\delta_x\delta_y-\alpha G_xG_y$ 
  * Approximate seperability by SVD! 

**Recursive Computation**

* Images can be represent by convolution pattern with some sparse point as well! -> Enhance sparsity

Some good implementation

* `import scipy.signal.convolve2d as conv2`  





## Multiscale Representation (mpi)

Sometimes we need similar features detection at different scale!  

* **Gaussian Pyramid** 
  * For image $I$ apply Gaussian filter, downsample!  
    * $I, [I*G]_-, [[I*G]_-*G]_-, ...$
* **Laplacian Pyramid** 
  * For image $I$ apply Gaussian filter, subtract! downsample!  
    - $I, [I*(\delta-G)]_-, [[I*(\delta-G)]_-*(\delta-G)]_-$
    - Get you local contrast of different scale! 
* *Note*: it's hard to get back to original image from the "representation" 
* **Wavelet Pyramid**
  * Local (like 2*2 blocks) coordinate transform 
  * Apply recursively
  * Is easily revertible!! 
  * **Application**: compression! Image modeling! 



# Lec6 7 Image Restoration Problem

**Problem Setting** : an parameter / model estimation problem (statistics)

## Bayesian Scheme

* In original statistical setting **Maximum Likelihood Estimation** i.e. $arg\max_xp(y|x)=\mathcal L(y)$ 
  * 
* In Bayesian setting, **Maximum *a posteriori* Estimation** (MAP) $arg\max_x p(x|y)\propto p(y|x)p(x)$ 
  * (**In Bayes, Prior Knowledge Matters! **)
  * *Remark*: Weight the evidence by prior! Bias the observation towards prior! 
* Add loss distance function, and minimze Loss Expectation given the original image
  * $arg\min_x \int L(y)p(x|y)\propto p(y|x)p(x)$ 

### Different Priors

*Note*: Image compression is about prior, which is the same as image distribution modelling. 

**Independent Pixel Prior**

* Prior distribution for each pixel is the same and independent! (i.id. )
* Then *a posteriori* estimation of each pixel can be done separately! 
* For example if the prior is Gaussian $X[n]\sim N(0.5,\sigma_p^2)$ , then the estimation is just a interpolation

$$
\hat X[n]=\frac {\sigma_p^2Y[n]+0.5\sigma^2} {\sigma_p^2+\sigma^2}
$$



**Multivariate Gaussian Prior**

* Allow dependency among variables! 





**Wavelet transform and restoration**

* Define the i.id. Gaussian (multi-var) prior in Wavelet transformed space ! 
* Use the inverse Wavelet transform to rotate it into pixel space! 
* *Remark*: A complex distribution can be constructed by some regular distribution if mapped to the correct representational space
  * GAN and VAE is a deeper demonstration of this idea! 



## Optimization with Regularization

Another way of forming image restoration problem is do optimization under regularization, e.g. 
$$
\hat X=\arg\min_X D(Y:X)+\lambda R(X)\\
\hat X=\arg\min_X \|Y-X\|^2+\lambda (\|G_x*X\|+\|G_y*X\|)\\
$$

### Classical Solvable Reg. Optim.

* If the Regularizer has Convolution, then it can be diagonalize in Fourier Domain! 
* 



### Numerical Notes: Solve $X=Q^{-1}Y$ Efficiently

**Remarks**

* Think in the matrix $A_K$ but never really compute in it! 

*  Never inverse a huge matrix and matrix multiply! Not stable 
* **Cholesky Decomposition** can be helpful in solving linear system. 
  * `np.linalg.solve` will do the job efficiently

* **Conjugate Gradient Method** (iterative method)
  * When you can vec multiply $Q$ but cannot form it! 



# Lec 8 Color

There is a spectrum $L[n,\lambda]$ every point in the space. We get our RGB values from an array of filters, i.e. 3 dimension projection of an infinite dimension spectrum
$$
X[n]=\int_\lambda L[n,\lambda]\Pi_X[n\lambda]
$$
**Metamer**: Different spectrum with the same RGB values! 

**HyperSpectral camera**: to get $>>3$ filters and get more channel image! 

## Light Color and Object Color

Color is not a property of object, it depends on illumination and env.

* **Remark**: Same object can look like different color in different light condition

Object apperant color can be think of as a linear process. The illumination spectrum $R[:]$ get linear transformed by material matrix $D[]$. 
$$
I[c]=D[c,:]R[:]
$$
**Natural Illumination** Normally well modelled by the black body radiators. 

### Transform Image across different Illumination

* **Theory** 
  * Metamer in one light condition may not be metamer in another! Thus in single illumination case some information is lost,  you cannot recover the image in principle.

* **Practice**: 
  * Linear transform of $[R,G,B]$
  * Diagonal transform (maybe in some color space!)
  * Von-Kries model 



### Color Constancy Problem

Learn to separate illumination and object color from the image! 

**Color prior**: 

*  **Gray world**: Assuming the average pixel `mean(I[:,:,:],axis=(1,2))` is white ! 
  * But not true in some environment with dominant hue! 
* **White patch Retinex**: Assuming the brightest patch in the color space is neutral (white). -> map the brightest pixels to white!  

Still an **active research area**, in computer vision and neuroscience

* CV people use object recognition ability and the prior on object color to estimate illumination

**Application**:

* Color correction for photos, create photos from different illumination. 

## Color Space (Representation)

Best color space depends on which task you like!

* **Linear transform**:
  * **XYZ** usually the standard way that camera takes the image, linearly translated into RGB. 
  * **YUV** a "**Decorrelated**" version of color space, Y~Luminance, U,V ~ color information. 
    * Useful for input into deep learning networks! Decrease interactions among 
* **Non-linear transform** : 
  * Light + rg chromacity: $L=R+G+B$, $r=R/L$, $g=G/L$. 
  * **Hue, Sactuation**: Columnar coordinates, Hue as angle, Sacturation as polar distance. 
  * **CIE-LAB space**: nonlinear transform, the distance in this space is perceptually relevant! By doing psychophysics! 

Eye and imaging 

# Lec8 9 Shading

**Motivation**

* Shading is a strong cue for shape! 
  * Sculpture and 3d illusion image used it!! 
* Multi-light source imaging can be used to generate high-resolution 3d model! 
  * By changing the illumination, shading change you can estimate the shape!.
* Color, material, light sources, .... 

## Imaging Geometry Note



### Normal Vectors



Normal vector field $\hat n (x,y)$  

Gradient field $\nabla Z(x,y)$ 



*Note*: In convention, **Z** direction points to camera ! Z increase with depth decrease

## BRDF (Bi-directional Reflectance Distribution Function)

* Material property

* How much energy output from the output angle, if you input unit energy from a input angle $L(\theta_i,\rho_i, \theta_o,\rho_o, \lambda)$  

**Property**

* Positivity 
* Energy Balance : Total energy arriving $\geq$ total energy leaving 
* Helmhotz reciprocivity : $L(\theta_i,\theta_o)=L(\theta_o,\theta_i)$ 
  * Symmetry of light source & Camera when inverting all the light rays 



## Light Source

* Point Light 
  * Parallel Light Approximation: if Light Source is infinitely away. If the light source is far enough > size of scene

*Note*: this approximation make the integration of BRDF just a linear mapping! Simplified 

## Photometric Stereo

If so and assume the object is *Lambertian*, the intensity of emitting light is majorly a function of the direction of the facet on object. 
$$
I=max(0,\rho<\hat n, \hat l >)
$$
**Note**, turning away from light source will give you shadow, which is also a cue for shape. 

- **Shadow**  
  - Cast shadow : shadow cast by object in front of another 
  - Attached shadow : because facet point away from the light $dot(n,l)<0$ 

For a single light source, the $n$ can only be determined up to $\theta$, $\phi$ can change without changing the lightness. Thus multi-images are needed  for calculation. 

The light value is linear to the light direction $\hat l $ and surface normal $\hat n$. 

Compute the normal vector (and shape) from light value under different light condition! Then we have the linear equation system 


$$
\hat n=\arg\min_n\|Ln-I\|^2
$$


$\hat n $ could be normalized and the norm is the reflectance from BRDF

Can solve the normal vector for each pixel ~independently! 



**Remark**: 

* Majorly works for Lambertian surfaces, if it does not work, we can use other type of specialized light source (Polarized light) to make it more Lambertian! 
* 3 light source may not be enough, more for stability
* Can use sphere (ground truth norm->luminance map) to calibrate the system
* *Note*: some pixel does not have well defined normal! Don't solve for it

## Normal to Depth

If we ignore perspective projection, then problem happens on the same plain. 

From imaging and surface geometry, the normal field and depth field are connected by these PDEs, analytically we could integrate on the field of $g_x,g_y$ and get the $Z$ field back! 
$$
\partial Z/\partial x=-\frac{n_x}{n_z}, \partial Z/\partial y=-\frac{n_y}{n_z}\\
g_x[n]=-\frac{n_x[n]}{n_z[n]}, g_y[n]=-\frac{n_y[n]}{n_z[n]}
$$
But we need a more robust algorithm for this! 

Think of $g_x,g_y$ as numerical derivative of $Z$ by convolving the  $f_x,f_y$ are derivative kernels in $x$ and $y$  direction. Thus, the problem can be formed as *Deconvolution* problem! (with some smoothing regularization! )

$$
Z=argmin_Z \|g_x[n]-f_x*Z\|+\|g_y[n]-f_y*Z\|+\lambda R(Z)\\
R(Z)=\sum_n (Z*f_r)[n]^2
$$




### Fourier Domain Deconvolution

Solve it by Fourier Domain Deconvolution, (i.e. *Frankor Chellappa algorithm* )

**Note** : 

* You don't know your absolute offset of your object! So that the 0 frequency of $Z$ is degenerate, cannot be solved! 
* As the problem is an integral problem, Z can be specified up to an overall constant! 

### Direct CGD: Conjugate Gradient

If we add mask $w[n]$ to the loss function, as the loss should not be defined on all visual field. Then the deconvolution is not easy in Fourier domain. (pixelwise operation is not diagonalized in Fourier Domain!! )
$$
Z=argmin_Z \sum_n w[n](g_x[n]-f_x*Z)^2+w[n](g_y[n]-f_y*Z)^2+\lambda R(Z)
$$
*Note*

* Use $w[n]=\hat n_z^2[n]$ for the valid  pixels with a normal vector! Others $w[n]=0$ 

We try to formulate it as a standard quadratic function


$$
\arg\min_ZZ^TQZ-2Z^Tb+c
$$
**Notes for Implementation**: 

* Note as $Z$ will be vectorization of an image so it will be huge! Forming $Q$ is not possible practically! Can only do $QZ$ mat-vec product in other ways. 
* Using conjugate gradient, we don't really need to inverse a matrix, but only need to mat-vec product, which could be done efficiently for convolution & pixelwise operations! 



https://en.wikipedia.org/wiki/Derivation_of_the_conjugate_gradient_method



## Advanced Stereo Method



# Lec 10 11 Camera Projection 



## Projection Geometry

### Homogeneous Coordinate



- Parametrize points with a fictative $z$ . $(x,y)\mapsto(\alpha x,\alpha y,\alpha)$ 
  - Mathematically, it's parametrization of $\mathbb P^2$ Projective plane

* For simple camera, the imaging geometry is like $(x,y,z)\mapsto(-f\frac xz, -f\frac yz)$ Thus only angle could be read out of the pixel location! 
* Use homogeneous coordinates to make it linear $(x,y,z)\mapsto(-fx, -fy,z)$ 



Similarly, 3D homogeneous coordinates $(x,y,z)\mapsto(\alpha x, \alpha y, \alpha z, \alpha)$ 

* Homogeneous plane equation, $l^Tp=0$ 
* Homogeneous plane equation $L^Tp=0,\ L=[l_1,l_2]$ 
  * 

### Basic Geometry

* 2d lines can be defined as $l^Tp=0$, $p=[x,y,\alpha]^T$ 
  * $l$ is specified up to scaling

* Points and lines are dual to each other 
  * line passing $p_1,p_2$, $l=p_1\times p_2$ 
  * intersection of 2 lines $p=l_1\times l_2$ 
  * 3 lines passing same point $l_0\cdot l_1\times l_2=det(l_1,l_2,l_3)=0$ 
  * 3 points on a same line $p_0\cdot p_1\times p_2=det(p_1,p_2,p_3)=0$  

### Image Transformations

* Translation: 2 dof
  * $\begin{pmatrix}I & t\\ 0 & 1\end{pmatrix}$, $t\in\R^2$  
  * $t\in\R^3$ 
* Rotation: 1 dof (if around center)
  * $\begin{pmatrix}R(\theta) & 0\\ 0 & 1\end{pmatrix}$, $R(\theta)\in SO(2)$ 
  * $R(\theta)\in SO(3)$ 
* Euclidean: 3 dof
  * $\begin{pmatrix}R(\theta) & t \\ 0 & 1\end{pmatrix}$, $t\in\R^2,\ R(\theta)\in SO(2)$ 
  * $R(\theta)\in SO(3), t\in\R^3$ 
* Similarity: scaling in $x,y$ 
  * $\begin{pmatrix}sI & 0\\ 0 & 1\end{pmatrix}$  
* Affine: 6 dof 
  * $\begin{pmatrix}A & t\\ 0 & 1\end{pmatrix}$, $A\in GL(2),\ t\in\R^2$  
* Homography: 8 dof 
  * $H\in GL(3)$ , up to scaling, so $SL(3)$ 

Similar results apply to 3d homogeneous coordinate transformation. 

* Note for 3D, in imaging, we majorly consider transform up to Euclidean transform! No more general. 

## Fit the Image Transform

4 points algorithm 



## Application: Panorama and Blending

A distinctive use of fitting perspective transformation is Panorama blending! Fit the 

So the problem is finding correspondence, solve the transformation equation and then do transform to connect the 2 images. 



## Robust Fitting Algorithm

Iterative algorithm to exclude too large error point pairs and select the others

Use a error upper bound, ignore the outliers. 



### RANSAC (Random Sampling and Consensus)



```tex
For i=1:n
S1. Random sample correspondence
S2. Compute homography $h$
S3. Use a metric to measure goodness of the fit
End
S4. Use the best point pairs in the steps above to initiate iterative algorithm 
```

# Lec 12 13 14 Stereo

## Basic of Projective Geometry



**Comments**: Why we need homogeneous coordinate?

* Note perspective projection from $\R^3\to\R^2$ though simple is not a linear operation. Because there is division operation $x=fX/Z$ 
* However, homogeneous coordinates has scaling factor. Thus a division problem become a multiplicative  problem! Thus, become linear. $x=fX,\ \alpha=Z$. 



## Camera Projection

In the **camera coordinate**, Z point outward along optic axis, X,Y go along width and height of the frame. 

Physical world to image plane transformation

$$
p=\begin{pmatrix}f_x & s & c_x & 0\\ 0 & f_y & c_y & 0\\0 & 0 & 1 & 0\end{pmatrix}p'
$$


$p=Pp'$ , $P=[K,0]$ $K$ as the intrinsic camera matrix. 

* $f_x=f_y=f$ normally, 
* $c_x,c_y$ is just a translation, offsetting the pixel index, normally $W/2, H/2$. 
* $s$ is pixel skew, normally $0$ 

If we use the **world coordinate** of object, the camera position and orientation must be taken into account, we can use a euclidean transform to transfer the world coordinate into camera one.  
$$
p=K[R,t]p'
$$

* $K$ is about intrinsic properties of camera: focal length, skew
* $[R,t]$ is about the orieantation and position of camera (5 dof)

## Camera Caliberation

> How to know the camera's pose $R,t$ and parameter $K$ just looking at image? ( Similar to the problem of self localization from vision in animal. )

Can use similar algorithm to image transformation fitting

* Use a bunch of 3d-2d correspondance to fit the equation $p=K[R,t]p'$ 
* Need 6 pairs of independent points. 
* And factorize the $(3,4)$ linear transform to $K,R$. 

### Vanishing Point

In projective geometry, all parallel lines intersects at the infinity (vanishing point)! And the 2d coordinates of vanishing point is connected to the physical direction of lines $d$ by extrinsic projection matrix. 

For lines $r(\lambda)=r_0+\lambda d$, 

- Assume in camera coordinate, the projection is $Kr_0+\lambda Kd$, 
- The coordinate of vanishing point is $\bar p = Kd$ . 
- Parallel line in physical world can give you $\bar p$. 



**Vanishing point method** 

* If we get 2 sets of parallel lines orthogonal to each other, we can get 2 vanishing points $\bar p_1,\bar p_2$

Then, we have equations
$$
Kd_1=\bar p_1 \\
Kd_2=\bar p_2 \\
d_1^Td_2=0
$$
As there is majorly one unknown in $K$, focal length $f$, 3 equation can sovle that.  



## Multi (Two) view Camera Geometry

> How points in 2 FoV in 2 cameras corresponds to each other? 



For cameras differed in rotation but not translation, then the 2 views will be connected by a **homography** (linear transform)! Thus you don't need to figure out depth of the world. 
$$
\bar p_1=K[R,0]p,\ \bar p_2=K[R',0]p\\
\bar p_1 = KRR'^{-1}K^{-1}\bar p_2
$$

But, in the other sense, 2 rotated view from the single point is not useful to figure out depth. 

### Epipolar Geometry

In general position, How the images of 2 camera relates to each other? 

Picture: Epipolar triangle 

![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Epipolar_geometry.svg/330px-Epipolar_geometry.svg.png)



**Keypoint**: 

* Geometric constraint makes the correspondance point of $p$ in view 1 lies on a line in view 2. 
* Each correspondance pairs lies on a plane going through baseline. There is a one parameter familiy of epipolar planes. 
* If camera geometry is known, this constraint makes correspondance search 1d instead of 2d. Easier for search! 
  * [Camera self motion](#optic flow), and [binocular stereo](#Rectified Binocular Stereo) are special cases for this 
  * In Camera motion case, epipolar line is in the direction of camera motion (pointing forward)
  * In Binocular stereo, the epipolar line is x axis! 
  * Normally epipole is outside FoV, so epipolar lines go like parallel! 

### Algorithm to Fit Camera Transform

Given the geometric intuition above, what is the transform connecting the coordinates in 2 views. 



* 8-point algorithm: 
* If the two cameras are caliberated, 5 dof = 3 rotation + 2 translation
  * 5-point algorithm: 

**Remark**

* If not caliberated, you cannot get absolute depth, but only relative depth. 
  * Because distance in camera and distance in pixel space are degenerate



### Rectification

If 2 cameras orients to the same direction?

* Epipole is in infinity $(1,0,0)$, if rotated properly, epipolar line is x-axis 
  * Life is much easier!
* Try to transfer the view in one camera to the other one, is the same as coming up with disparity map $d$ a long $x$ axis. 





## Rectified Binocular Stereo

In the case of rectification, corresponding points can only move in one direction, thus difference of 2 images could be coded in disparity of each point. Figure out  **Depth map** from **Disparity map**. 
$$
R[x-d(x,y),y]\sim L[x,y]\\
\Delta z^{-1}\propto d(x,y)^{-1}
$$

### How to find correspondance?

**Issue:**

* Smooth region is problematic! (too many answer)
* Non-Lambertian / reflective material is problematic! (No apparent answer! )
* Occlusion can be problematic. 



**Algorithm Sketch**

```tex
S1: For each keypoint, generate candidate match points on the other image. (Way to select key points)
S2: Select the closest keypoint match on the other image. (Define the representation and distance.)
S3: Find best match and the disparity among it. 
```

**Local keypoint matching options** 

* Pixel value + Euclidean distance (bad...)
* Clipped gradient + Euclidean distance 
* Census transformation + Hamming distance: similar to clipped gradient
  * Defined as a binary code for local gradient with spatial information in it! 
  * Note, it's *different from histogram of gradient*, as the spatial information is still coded and affect the distance matric! Thus it's not Rotation / Mirror invariant. 



**Cost Volume ** data structure

* Maximum disparity (knowledge of how close an object can be in front of cameras )
  * There is limited posibility of disparities! Can be stored in a tensor.
* $C[x,y,d]$ = distance / matchness between $I[x,y]\sim I'[x+d,y]$  

Estimate / optimize the disparity map from **cost volume**. 

* Naive method: $d[x,y]=\arg\min_dC[x,y,d]$ 
* Deal with noise in cost / image similarity 
  * Smooth the cost?
  * Smooth the disparity?
  * Bilateral filtering + disparity 



Optimize the disparity map in smooth constraint

**Global Optimization**: 

As the loss majorly consists of 2 kinds of terms unary term (match loss of a $d$), and binary term (consistency of neighbor unit), the loss function could be think of as a grid network. 

If we put the loss $L$ on top of a exponential $\exp(-L)$, this could be formulate as a Markov Random Field. 

And the Global Optimization could be solved by belief propagation in chains or loopy BP in the grid. 



**Issues**

* Matching uniqueness 
  * 2 points in $A$ match to the same point in $B$ . 
  * Add order constraint along epipolar line? 
    * However, not always true! 
* Occlusion 
  * Some point in $A$ don't have a match in $B$ 

**Tricks**

* Use left as reference or use right as reference, solve both case! 



It's an extension of the stereo case. 

- Object movement in the world VS Camera movement



## Laser Scanning Stereo

Solving correspondence is hard! 

* Use epipolar geometry to constraint the search, maybe not enough! 
* Actively illuminate the object with a line and match it 
* Line scanning could be **multiplexed**, using structured light / multi-line to scan in parallel!  
* **Note**
  * There will always be occlusion problem. so multiview of the object may always be required. 
  * Background light may affect the result (the laser should be unique enough! )



## Multi-view Stereo

* More constraint! may be easier to solve! 
* Use images by different people from the world



# Lec 14 Optic Flow

## Optic Flow

* Defined as a flow field in pixel space
  * $I_2[x,y]=I_1[x+u[x,y],y+v[x,y]]$ 
* **Application**: a basic geometry processing step 
  * Useful for analyzing motion and shape
  * Object tracking 
  * **Image morphing**: interpolating between images by flow the field by half the time! 
    * Turn the head by 2 head direction images!  

So intrinsically, it's a correpondance search, without epipolar geometry (2d)! Tricks: 

* Make life easier by restrict $u,v$ to be small deviations. 
* Intensity consistency



## Lucas Kanade Method

The equation could be write approximately as a flow field $PDE$
$$
I[x,y,t+1]=I[x+u[x,y],y+v[x,y],t+1]\\
I[x+u,y+v,t]=I[x,y,t]+u\partial_xI[x,y,t+1]+v\partial_yI[x,y,t+1]\\
\partial_t I=u\partial_xI+v\partial_yI
$$
However, obviously, we get only one equation at one pixel! 

* We only know the motion along the image gradient! motion orthogonal to gradient (along the equi-intensity line) is not noticeable

* **Aperture Problem**
  * **Locally** (see through a aperture) the motion perception is degenerate, moving along the line will not be noticed. 
  * https://en.wikipedia.org/wiki/Barberpole_illusion

**Solution**: decrease the resolution of $u,v$ field, since constancy of movement in a small region. Thus multiple equation (hope it's not degenerate) for a single pair of $[u,v]$ 

* Note locally 2 lines with different orientation will give you unique estimation of moving direction. But 2 lines with same orientation (*grating*) will be degenerate. 
* Note too small gradient will also give you bad answer! (hard to see motion in a smooth surface. )
* Generate texture give you good result! 
* Add positive value to diagonal to make it stable (ridge regression...)

$$
\begin{smatrix}\end
$$

**Note** : This algorithm could be applied in a hierachical way, along pyramid of multi-scale images. 

* Could help estimate large flow vectors. 

## Lucas Schunck Method



* Add Laplacian (2nd derivative) regularization on the flow field! Set up a global optimization problem 
  * Thus it could 

$$
(I_x[x,y]u+I_y[x,y]v+I_t[x,y])^2+\alpha(\Delta u[x,y]^2+\Delta v[x,y]^2)
$$



# Lec 15 Segmentation

> Group pixels togethers! 

* Dual problem to the (object) boundary detection problem
  * Flood Fill algorithm! 

**What is our label?** 

* **Geometry**: same plane, same surface
* **Material**: same material
* **Object**: esp. the object that moves rigidly together or doesn't move 
* **Foreground, background**

**Objective**

* Similar and related pixels goes to the same label. 

Thus, it's a clustering, in the feature space and the image pixel space. 

## Superpixel Formation

Pre-processing step. Group the similar looking and close by pixels into a label. 

### Simple Linear Iterative Clustering

**Formulation**: In short, make pixel coordinates part of the feature vector, and cluster the pixels with K-means in the augmented feature space. 

* Augment the image into the augmented pixel array $I'[n]=[L,a,b,\alpha n_x,\alpha n_y]$. (Usually use `Lab` space to reproduce the perceptual similarity.) 
* K-means cluster $I'[n]$. Objective find the label array $L[n]$. 

$$
L=\arg\min_L\min\sum_k\sum_{n,L[n]=k} \|I'[n]-\mu_k\|
$$

* **Initialization**: 
  * Initialize the K cluster by generating a regular grid $\{n_k\}$. 
  * To avoid boundary, choose minima of gradient amplitude as seeds! 
  * Choose the feature value of the grid point as mean $\mu_k=I'[n_k]$ . 
* Iteratively, 
  * Nearest Neighbor assignment: $L[n]=\arg\min_k \|I'[n]-\mu_k\|$ 
  * Re-estimate mean: $\mu_k=mean(I'[n]|L[n]=k)$ 

**Note**: Seeding is a common problem for segmentation problems. 

* How to choose seeds and avoid putting initial seed on some boundary! 
* **Efficiency Trick**, don't need to consider all pixel for all labels. Only consider a window for a pixel! Each pixel only needs to remember the distance to nearest cluster mean! 

**Drawback**: 

* Hard to predetermine the cluster number $K$ and control the size of superpixel. 

### Usage of Superpixels

Remember the bilateral filtering, superpixel provides a boundary that your operation should stop! 

* **Object**: Grouping superpixels together into objects. 
* **Denoising** image within superpixel patch 
* **Filter** the cost, disparity map, optical flow within superpixel! 
* Fit a simple model (linear) to the value within a superpixel, for denoising. 

And other information (disparity, flow) can also go into augmented pixel feature vector, and help the superpixel aggregation. 

## Graph based Segmentation

For example, for foreground, background segmentation. 

**Formulation**: 
$$
\arg\min_{L} \sum_n C(n,L[n])+\sum_{(n,n')\in E}w_{n,n'} 
$$
Think of the image as network, neighboring edges are connected, strength determined by the similarity of pixels. 



### Multi-label graph based segmentation 





Alpha beta swap, alpha expansion. 

# Lec 17 18 19 20 Machine Learning

## Logic of ML

In CV, we needs to solve the inverse problem of object to image transform. But the problems are quite ill-posed. Usually we need to solve it under some *regularization*, which are mannual made statistical assumptions

* Depth is smooth
* Color distribution should be like....

But these artificial prior are not perfect, we need to **learn** the prior, i.e. the relationships between some variables $(X,Y)$, and we want to estimate $P(X,Y)$. $P_{XY}$ can be used to calculate prior knowledge $P(Y\mid x)$ , thus we can have better "guess" of answer. 

To calculate $P_{XY}$, you use a bunch of sample set $(x,y)$, and fit some parametric distribution (i.e. mixture of Gaussian) $f(x,y\mid \theta)$ to it with MLE. But it doesn't work!! 

This hard problem will finally go to [deep unsupervised learning](Note on Deep Unsupervised Learning.md).  



### Supervised Learning

Instead of solving the fitting joint distribution problem. Define a map $f:x\mapsto y$ so that the loss is minimized according to the distribution
$$
\min \int L(y,f(x))p(x,y)dxdy\approx \sum_i L(y_i,f(x_i))
$$
**Note**: The sample pairs are an approximation for the underlying joint distribution! We only learns the relationship in this distribution domain! So the sample pairs that doesn't appear in real life may not be learnt in the mapping. 

### Overfitting

Too many parameters, too complicated model, than the fitting can be very bad if data is not enough

* Fit the noise! (better fit, less generalizability) 
* Needs more data to constraint the parameters. 
  * But enough data + complex hypothesis space will still give you back the right answer. 

Prefer simple model. Find a measure of model complexity and penalize to that. 

* Regularizer on the weights ...... 
* But rarely useful in real world case. 

**Note** : Hard to define what is simple universally. The regularizer introduces our bias of simplicity. 

### Bias-Variance Tradeoff

* Simple function class: higher approximation error, lower estimation error (easier to estimate)
* Complex function class: lower approximation error, higher estimation error (harder to constraint with data)



### Basic Components 

* Training set
* Loss function 
* Hypothesis space (model architecture / expressiveness)
  * Regularization strength, functional class.... 



Good for "ill" posed problems, add prior to regularize the problem. 

### Standard Practise   

* Training set, validation set, test set. 
  * Don't look at test set before final stage! 
  * Every effort to avoid overfitting! 



## Example: Binary Classification

Output $y\in \{0,1\}$

**Normal Regression**

* Loss function: L2 loss! Just treat it as fitting
* Binarize the output! 

### Logistic Regression

* Use a connection function $P(L=1)=f(w,x)=\sigma(w^T\bar x)$
* Logit function $\sigma(x)=\exp(x)/(1+\exp(x))$ 
* $\bar x$ is an augmented "feature vector", e.g.
  * $[x,1]$
  * $[x,x^2,x^3,1]$ 
  * $[g(x),x,1]$ 
* Loss function is $-y_i*\log(f(x_i))-(1-y_i)*\log(1-f(x_i))$ 
  * Cross entropy: between the real probability distribution and the inferred distribution of classes. $\sum_i\sum_c-P(y_i=c)\log P(\hat y_i=c)$ 

Decision boundary will be a hyperplane in the feature space! 

As the loss function is convex, we can optimize and get unique solution! 

## Deeper Model

### Gradient Descent 

* Calculate the gradient $g(w)=\nabla_w C(y,x;w)$. 
*  $w^{t+1}\leftarrow w^t-\alpha g(w^t)$  
* Step size control
  * Normally, direct line search
  * 2nd order Newton method 
  * In machine learning, use a fixed $\alpha$ or schedule the $\alpha$ by the steps
    * **Cost caluculation is not feasible**! 2nd order info is not available. 
    * Theory of when it can succeed is not available now! 

If you can try to work out gradient. 

### Stochastic Gradient Descent



* Random Sampling, without replacement
* Shuffle 
* Batch 



### BackProp and AutoGrad 

A Deep Learning Framework has these components

* Computational Graph:  encoding the symbolic relationship between data. 
* Node
  * Computation it carries out
  * Some stores input **value**, some stores inter-mediate value (**activation**), some has **parameters** in it 
  * Note some 
* Forward computation: send data forward 
* Backward computation: send gradient back 

### Build our own framework.

* Build a global list that book keeping the relationships of nodes: `ops`, and the data  `Value`, `Param` 
  * Note the nodes are objects in operation class, they will store **reference** to operands in `Value` and `Param` class. Note, it's not copying the global object! 
* Forward pass is just calling the `Forward` method in each operation, one by one! 
  * Though graph is not linear, it can be represented in a sequence just as programming language do. 
* Backward pass is the inverse, calling the `Backward` method in a inverse order! 
  * At the time backward is called it should have **gathered** all it's gradient! 
  * The grad of `loss` itself is all one, this is an input to the backward function. 
  * Each module will calculate 2 terms, one is $\partial out/\partial in$, one is $\partial out/\partial param$. 
  * Note, the intermediate value and parameters are **Global** variables, they will accumulate the gradient, as more than 1 nodes may send gradient to it! 

### Sigmoid and ReLU

> History of Nonlinearity

Let's see how the behavior of gradient when passing through the non-linearity. 

**Sigmoid function** : $1/(\exp(-x)+1)$

* Activation is limited, doesn't need to normalize. s
* Can saturated in positive or negative way! 
  * The gradient will vanish in both way!
  * Initialization and normalization should be careful. 

**ReLU**: $ReLU=\max(x,0)$

* Doesn't change gradient when positive. 

As we can see, gradient descent can be very fragile! The gradient behavior ~ Normalization, must be observed clearly 

### Initialization

Naive way is to set parameters to random values. 



### Operations Over Space

In this category, treat the image as vector is not efficient! Data is usually represented as $(B,H,W,C)$ tensor. 

`conv2`, 

* Forward is just convolution
* But we know, convolution is linear, so gradient will be linear function of `Param` and `Value`, thus backward pass is upconvolution or deconvolution. 

`downsample`: 

* Just send 
* Note 

`maxpool`, `max` : and any 

* Send forward the maximum value, **store** the `argmax` index
* Send backward the gradient to the index in input! (*Gradient Routing*! )

`flatten`: 

* Just reshape the input or gradient 

### Example: Backprop in Convolution

> If you don't have a large memory GPU, do for loop over the kernels, instead of for loop over pixels! Move the image in parallel, and add pixel to it. 



### Conditional and Eager Execution

Routing gradient according to condition is simple! But when there is loop, this can be tricky! 

## Spirit and Lessons

> Neural network in computational perspective is **Differentiable Programming**. Come up with building blocks of operation, make sure each of them is *differentiable* 

* Choose the hypothesis space 
* Make the gradient flow healthy! Not cut or vanished ! 
  * For very deep network, 

# Lec 21 Semantics Tasks in Vision

## Task Taxonomy

Classic semantic CV tasks: 

* **Image classification**: 
  * Image is not an object! So the label may not represent the whole thing. Can classify based on scene or dominating object. 
* **Object detection**: Check if certain object in the scene, if so drawa box around it. 
  * Propose a box squaring the target object
* **Semantic segmentation**:  Precisely label the identity for each pixel, classification on pixel level. 
* What's more? 
  * **Instance segmentation**: distinguishing between different instances of the same type, different person. 
  * **Human pose-skeleton estimation**: 
  * **Face Recognition**: 
  * **Expression recognition**: 
  * **Let language and vision interact with each other**: *Just talk about the image!*, *answer some question about the image!* 

### History and Progress

Seems there is no equations that could solve these problems for free! 

* Note **evaluation** is a non-trivial challenge! 
  * Ancient times, we only have limited objects and limited images, hard to compare between lab! 
* Building an image dataset
  * People collect large amount of images (camera gets much cheaper! ) Using MTurk, to crowd source the labels for an image
  * Use word-net, a word hierachy as labels. 
  * Larger dataset push the ML to accomodate large data. (NN doesn't work well on small datasets, but perform much better than SVM on larger dataset. )
  * The miracle of `ILSVRC 2012` 

* What big data has changed?
  * Traditional algorithm designed to use small training data. 
    * Complex optimization method, 2nd order! 
    * Simple classifier, SVM (partly limited by optimization methods, if you want convex, convergence guanrantee! Elif you cannot compute the Hessian)
  * Current workflow is to first **collect large dataset**, and then find algorithm!! 
    * Using 1st order, gradient descent! 
    * Now we can use much more complicated classification algorithm! 
    * History tells us, Developping sophisticated algorithm on simple dataset is more like an intellectual exercise...... First collect data and train is the way. 

*Note*: CNN can learn random labels for the images, (just like pigeons) ...... arbitrary category learning can be done in CNN. 

## Classification

### Architecture

General setting for image classification

* Fix the input image to certain size $S\times S$
* Output a $C$ dimen vector for C classes.
  * Use cross-entropy to train
  * Use argmax or top K to inference



**VGG-16**

* Convolution 
* Maxpooling
* Fully connected
* Soft max

**Note**: the conv net arithmatics. 



* Using smaller simpler kernel but more layers is better than large kernel 

5-2 



## Object Detection

**R-CNN**

* Input images.
* Propose boxes! 
* Compute CNN features
  * Note we only run through CNN once, and cropping out the features in middle layers each time. 
* Classify based on CNN features. 



### Transfer Learning

Train on task A (easier to collect data on), and use smaller set of data on task B. 

* Task is complex. Don't have enough data, so use the learnt network on a much larger bulk of data and apply! 
* For example, the network learns a surprisingly useful set of features during the training! And can be applied to different tasks. 

## Segmentation

Essentially, it's a classification problem on single pixel, take in patch centered around it and output the label for it. 

Can be done more efficiently by sharing feature and tune the `stride` and `dilation`! Because running CNN on overlapping patches will compute the features for first few layers redundantly. 

**Fully convolutional network**

* We change our understanding convolution layer, IT IS FULLY CONNECTED to the patch it governs. 
  * For the last convolution layer, we use $C$ different kernels corresponding to labels, each output the probability of one class. 
* However, Down sampling (i.e. `strides`), and Maxpooling make the feature tensor smaller, then we cannot get a label image with same size! 
  * Just go ahead then you will get a label map of lower resolution! Nearby labels are largely similar !!! 
  * Use `dilate` convolution! `stride` is downsampling the output automatically, but `dilate` accounts for the strides in input! 
  * `dilate` allows you to apply a sparse network (because of down sampling) 

For example, a network architecture of `c3,c3s2,c3,c3s2,c3`

translates into `c3,c3,c3d2,c3d2,c3d4`



**Note** 

* We can add a MRF algorithm to the output labels from Fully connected CNN, in order to make it smoother. (Cf. disparity labelling)



## Deep Architecture

**General Consideration**

* Deep vs Wide
  * Deep and wide are both valid ways to make a network express complex function. 
  * But with the same bulk of data, deeper network will cause less overfitting problem. 
* However, gradients are harder to get to the parameters for first few layers. **Gradient vanish!**

**Solution to Gradient Vanishment**

* Gradually bake up the network! Or sequentially train each layer from lower 
  * Remember the ancient training layer by layer practice! (Stacked Restricted Boltzmann Machine. )
* **ResNet**, add jump connection to send gradient back. 
* **DenseNet**, concatenates feature dimension, share the features with each other. 



# Lec 22 23 Training Practicality

Parametrization of the function matters, not only the functional family! 

$x$, 

**Keypoint**: GD first order method, you have few control over the step size. 

* Step size scheduler is useful! 

## Initialization

* ReLU will cause negative part to 0 thus you make sure input to ReLU have half the probability > 0. 



Thus **normalization** is crucial! 

* Use the dataset mean and std, centralize the input!
* Note, try to ensure, `var` of output from each layer is 1, just like input `var` is 1.
  * For $y=wx$,  $var(y)\approx var(w)var(x)$. 
  * We should set the variance of $w$ according to the input window size $\sigma^2(w)=1/N=1/(K^2C_1)$.
    * Don't set `var` of weight to be 1, then there will be much higher 



## Normalization Layers 

**Batch Normalization Layer**: 
$$
y=BN(x)\\
y=\frac{x-Mean(x,axis=[B,H,W])}{\sqrt(Var(x,axis=[B,H,W])+\epsilon)}
$$
Do mean and variance for each channel across a **batch**. 

* Appears to be super useful and speed up training! 
* Unlike other layers, it changes different samples together! 
* Using the batch mean and var in forward and backward during training. But use the whole training `mean` and `var` during inference. 
  * Pre-Compute that `mean` and `var` once by going through the ImageNet once. 
* Note you should backprop through the BN layer! Not ignoring it. 

**Caveat**

* Using the running mean in forward pass is great! but it's complicated for back propagation! Because part of your activation depends on the last batch which depends on your weight again! 



**Usage**

* As BN is targeted to remove mean and centralize, don't put bias before it. and do ReLU after it! 
* `ReLu(a*BN(con2(x))+b)` is a common practise. 

* Usually BN is used in first few layers, NOT FC layers, that will hurt you, as the sample size will be much smaller



## Regularization

Prevent overfit is still important! 

* **Best solution: Get more data!** 
* **Second best solution**: Get more fake data, augment to increase tolerence! 
* Other tricks : Explicit regularization
  * **Weight decay**: L1 or L2 loss to all $w$, but not $b$. Add it explicitly to loss with $\lambda $. 

Not always work! 





### Drop out method

In training time, set each element $f$ as 0 with probability $ p$ independently, and set it as $(1-p)^{-1}f$ with probability $1-p$

In essense, it's a Bernouli random mask $M$ over activation tensor $F$, element-wise operation. 
$$
g=f\circ M,\ \nabla_f=M\circ \nabla_g\\
M\sim(1-p)^{-1}Bern(1-p)
$$
It's like randomly drop out activation and gradient at each sample. 

### Early stop 

> It's a kind of regularization because epoch number limits the network state it can reach! 

But when to stop? The absolute training loss is not indicative, normally it will become slower and slower. 

### Learning rate dropping

Drop learning rate by 10 each several epochs. 

Learning 

## Optimization Method

### Momentum in SGD

$$
g_i\gets\gamma g_i+\nabla_{w_i}\\
x_i\gets g_i
$$

**Adagrad**
$$
g_i^2\gets g_i^2+(\nabla_{w_i})^2\\
w_i\gets w_i-\lambda \nabla_{w_i}/\sqrt{g_i^2+\epsilon}
$$
**RMSprop**
$$
g_i^2\gets \gamma g_i^2+(1-\gamma)(\nabla_{w_i})^2\\w_i\gets w_i-\lambda \nabla_{w_i}/\sqrt{g_i^2+\epsilon}
$$
**Adam** = RMSprop + Momentum 

Adam normally works well! 



Note 

* These 2 algrithms applies different rate to different part of parameter. 
* Besides, they can be thought of as approximation to 2nd order algorithms. Assuming the Hessian to be some diagonal matrix! 

## Distributed Training 

> How can we break down computation onto multiple GPUs? 

Note processing of different batches are independent! 

### Model parallelism

If your architecture has 2 different path parallel to each other, then deploy them on 2 different GPU and combine as they join is OK. 

cf. AlexNet 2012

*Not popular now! May not help many network.*

### Data parallelism

In the ideal case, 

* Each device load a different part of data and compute their own activation and gradient. 
* 



**Communication overhead**: Gathering gradient and distributing weights can be really slow, PCI-e bus is not fast enough

* Normally gradient computation takes longer than averaging gradient, so distribute 
* **Better communication hardware**: 
* **Compress the transmitted gradient by quantization**: gradient is noisy, why not make it simple....
* **Approximate distributed GD**: Update weight on each machine alone, after a certain steps averaging weight across machine and sync. 



# Lec 23 Deep Prior for Physical Tasks

For high level vision, we have no model to invert, so we have to learn!

But for low to middle level vision, we have a **physical model** to invert, however, it's ill-posed, so we still need prior, and DL help us on that. 

## Denoising

Deep Learning method on denoising: 

* Take many images $x$
* Add any noise at certain level $y=x+\epsilon$ 
  * Gaussian or Poisson
* Use DCNN to learn the relationship $(x,y)$, and predict $x\gets f(y)$ 



Note, 

* Neural network based algorithm gives you **much faster inference** speed than optimization based algorithm. (ventral stream works like that as well)

**IRCNN**: CVPR 2018 

* One thing they find is that, using NN to predict noise $\epsilon$ from noisy image is much easier than predicting the original image, 
* Because you don't need to maintain the representation of the whole image! 
* Best part is the network is agnostic to task! Can transfer 



> Actually, any assumption we made to solve equations mathematically simple, may be substituted by a Neural Network that learning these priors from data. 
> (Tractable driven assumption -> Data driven assumption)





### Plug and Play prior

Classical problem setup: 
$$
y=Ax+\epsilon\\
\hat x=\arg\min_x\|y-Ax\|_2^2 - \log p(x)
$$
And the prior $p(x)$ is the hand waivy assumption about how a natural image should look like. So we want to learn this by a network! 



Relax this equation by adding an intermediate variable $z$
$$
\hat x=\arg\min_{x,z}\|y-Ax\|_2^2+\beta(x-z)^2 - \log p(z)
$$

* $\beta$  control the strength of constraint by $z$ i.e. coupling of $x$ and prior. 
  * So we can increase $\beta$ with training, baking it up. 
* $x,z$ can be optimized alternatively 
  * $\arg\min_x\|y-Ax\|_2^2+\beta(x-z)^2$ is a least square problem on $x$ solve analytically. 
  * $\arg\min_z \beta(x-z)^2-\log p(z)$  is essentially the same equation as denoising. We can use the network learn to do denoising for this part!  

**Note**

* The spirit is when doing denoising, the IRCNN has learn about the statistics of local patches and how a natural image should look like~
* GAN, VAE can be used to do similar things, but from a different perspective. 



Thus a same framework could be used for multiple tasks.

* Deblurring 
* Superresolution
* In painting, filling the gap



## DL in Stereo

> Look into the classic pipeline, see where is the hacky part, replace with a trained NN. 
> (Hacky part is where human brain learns from data and experience, and inject some prior to it. NN can do that with data. )



### Siamese Network

Use NN to come up with a distance function $f$, such that we can run globalization on the disparity volume. 

* Use a network to encode patch into a feature vector $\bar p = g(p;\theta)$, 
* Use the cos distance between $\bar p,\bar p'$, $d(p,p')=-\cos (\bar p,\bar p')$  
  * If this is not good enough, you can use the $fc$ layers to learn a nonlinear distance function. 

**Training**

* Note it does not need a high level 

**Triplet loss**

* Choose a random patch $p$ in one image, correct match patch $p'$ in another and a random wrong image $q$.  If the correct match patch has smaller ditance than the wrong image, the loss is 0, else it's 1.
*  



### Modern Stereo

* Run globalization by running a 3D convolution on the cost volume! 

* Do subsampling to make it into 2d
* Thus the model can be trained end to end! 

The hardest part is backprop through the cost volume tensor, as it's formed by a complex reshaping of input data. 



**Training**

* The training data is quite massive, have to get 2 image and a simultaneous depth map.
  * Data collecting: Driving a depth sensing car around! Much harder than the previous method. 
  * Depth data is hard to collect! 

**Pre-Training**

* Use the classic geometric constraints to help self supervision! 
  * If it's not on the epipolar line,  







## Monocular Depth Estimation 

In human vision, monocular depth perception (one eye viewing, photos) is not that good! So low baseline in the first place. 

**Training**

* RGB image and a depth image. 
* Mapping RGB image to 
  * depth image 
  * derivative of image 
  * distribution of depth 



### How can human help supervise! 

* **Problem**: human cannot annotate depth on pixel level! 
* What's the thing that is easy for human to annotate, but also good for computers to learn. (just like geometric constraint) Use a derived quantity as the source of loss
  * Relative depth  
  * Orientation of some surface in the image. 
  * Can let human work on segmented images! 

## Surface Normal Estimation 

If you want normal more than depth, compute directly

Surface normal will not suffer from accumulated error, can work with large depth planes. 



**PlaneNet**: Find the orientation of the plane in the image! 



## Intinsic Image Decomposition



## Color Constancy

Predict illuminant color from image, thus separate object color from illumination color. 

**Training**: 

* Form the problem as a classification





## Image Colorization 

Output a discretized distribution in color space for each point. 



## Illumination Estimation 

**Outdoor illuminance** : 

* The parameters to learn is simple, 
* 

**Learn to predict indoor illumination**



## Style Transfer





The core understanding is the covariance of layers represents style. 



## Point-Cloud Processing







# Lec 25 Generative Adversarial Network

## Why Generative?

* Usually the network output a single best guess, $\hat y $. 
* But $p(y|x)$ Is not deterministic, sometimes you want to model a prior or posterior distribution instead of one point estimate. 
  * Conditional GAN is modelling the posterior distribution / guesses given a input.
  * Unconditional GAN is modelling the prior natural statistics





Note: 

* Classification task can give us a distribution of labels. 



> GAN, morph a random distribution to one that match the output. 

## Task settings 

* Given samples from $p_x(x)$, generate samples from this distribtution. 
* Using a noise vector $z$ from a known distribution, produce output $x$ from $p(x)$. Make $G(z\mid\theta),z\sim p_z(z)$
* **Method**: Use a discriminator to discriminate between real sample and fake sample. 

**Loss function**: 
$$
L(\theta,\phi)=-\mathbb E\log(1-D(G(z;\theta);\phi))-\mathbb E\log D(x;\phi)
$$

* Generator want to maximize it, make it 
* Discriminator want to minimize it, make better discrimination. 

$$
G=\arg\max_G\min_D L(\theta,\phi)
$$

## Theoretical Consideration

* Why min-max training work? 
* The loss function is essenstially a divergence between 2 distributions. 





## Training Practicality 

* You can compute gradient w.r.t. loss, but make one part descent, one part ascent. 

* Choose a bunch of $z$ samples, and a bunch of real images $x$ , pass gradient through Discriminator towards generator. 

* 

* But adversarial training is super unstable

  * Discriminator is much easier than Generator 

**Trick**:

* Train generator more epoches, train discriminator less, make 
* Note if you use Batch Normalization, Discriminator may use the batch statistics to discriminate. 



## Conditional GAN

Add a conditioning input, 

Using drop out as a source of noise! 

Don't use mean of output but use the of output. 



Pixel to pixel translation. 







## Cycle GAN

Domain Translation! With unpaired image to image translation. 

* There are cases, exactly matched pair of images. 
* 

The spirit of training is to get a transformation $F:\mathcal X\to\mathcal Y,G:\mathcal Y\to\mathcal X$, presumably a forward map and inverse map. Besides with a descriminator $D_x$ and $D_y$ to determine $x\in\mathcal X,y\in\mathcal Y$ within manifold condition 

Cycle consistency Loss

* $d(G\circ F(x)-x)$ inverse map match the original sample
* $D_y(F(x))$ consistency with data manifold 



**Caveat** 

* Add some sample pairs may constraint the transform. 



## Variational Autoencoder



The pipeline is $E:X\mapsto (\mu,\Sigma)$ , $z\sim\mathcal N(\mu,\Sigma)$ , $D:Z\mapsto \hat X$ . 

Even if we cannot back propagate from $z\to \mu,\Sigma$  we can use the reparametrization trick. Given 

Note the image is 



Conditional VAE

## U-Net and Probabilistic U-Net

 

# Lec 27 Un-Supervised Learning 

> What to do if it's hard to collect enough training data. 

**Several strategy**

* Use a easier task / lesson that is easier to train, and ample in data!  
  * Artificially produce training data and answer to train network
* Train something on a format that is easier for human to provide data! 
  * Surface normal is easier than transformation 
* Use Computer Graphics engine to render synthetic images, which you have complete knowledge of it. 
  * Note there is a tradeoff between render quality (photorealism) and speed! 
  * Render is not always cheap



## Pre-train Tasks



* Find image, make it B&W, train network to do colorization. 



* Let networks solve Jigsaw Puzzles
  * Put the segmented image patches together! 



* **Visually Indicative Sound** : 
  * Let a kid walk around and hit what they see! The sound is indicative of material etc. and much easier to get. 



## Domain Adaptation 



