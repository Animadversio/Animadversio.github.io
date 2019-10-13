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
- Avoid for-loop, if have to put it in inner most part! 
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



**Example**: 

* Translation can be performed by convolving single value convolution kernel!! 
  * Think about the input response function. 

**Blurring** : $G*I$ 

**Image sharpening** : substract the Blurred image $(1+\alpha)I-\alpha G*I$ . 

 

**Edge Detection**: Derived from partial differential operator

* Derivative over space is a linear operation! 2 derivative $I_x$ and $I_y$ are sufficient to compute derivative of any direction $I_\theta=I_x+I_y$ 

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

* For simple camera, the imaging geometry is like $(x,y,z)\mapsto(-f\frac xz, -f\frac yz)$ Thus only angle could be read out of the pixel location! 
* Mathematically, it's parametrization of $\mathbb P^2$ Projective plane



Similarly, 3D homogeneous coordinates $(x,y,z)\mapsto(\alpha x, \alpha y, \alpha z, \alpha)$ 

* Homogeneous plane equation, $l^Tp=0$ 
* Homogeneous plane equation $L^Tp=0,\ L=[l_1,l_2]$ 
  * 

### Basic Geometry

* 2d lines can be defined as $l^Tp=0$, $p=[x,y,\alpha]^T$ 
  * $l$ is specified up to scaling
  * line passing $p_1,p_2$, $l=\beta p_1\times p_2$ 



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



## Camera Projection

Physical world to image plane transformation


$$
p=\begin{pmatrix}f_x & s & c_x & 0\\ 0 & f_y & c_y & 0\\0 & 0 & 1 & 0\end{pmatrix}p'
$$


$p=Pp'$ , $P=[K,0]$ $K$ as the intrinsic camera matrix. 

* $f_x=f_y=f$ normally, 
* $c_x,c_y$ is just a translation, offsetting the pixel index, normally $W/2, H/2$. 
* $s$ is pixel skew, normally $0$ 

The image is affected by the camera position and orientation, we can use a euclidean transform to note that! 
$$
p=K[R,t]p'
$$

* $K$ is about intrinsic properties of camera: focal length, skew
* $[R,t]$ is about the orieantation and position.



Use similar algorithm to image transformation fitting! 





### Vanishing Point

In projective geometry, all parallel lines intersects at the infinity (vanishing point)! And the 2d coordinates of vanishing point is connected to the physical direction of lines by extrinsic projection matrix. 

For lines $r(\lambda)=r_0+\lambda d$, 

* 





## Multi (Two) view Camera Geometry

Assuming that the 



Normally, for cameras with rotation but not translation, then the 2 views will be connected by a **homography**! Projective transformation!

Thus you don't really need to figure out depth of the world. 
$$
\bar p_1=K[R,0]p,\ \bar p_2=K[R',0]p\\
\bar p_1 = KRR'^{-1}K^{-1}\bar p_2
$$



### Epipolar Geometry

How the images of 2 camera relates to each other? 

* 
  * 8-point algorithm: 
* If the two cameras are caliberated, 5 dof = 3 rotation + 2 translation
  * 5-point algorithm: 

**Remark**

* If not caliberated, you cannot get absolute depth, but only relative depth. 
  * Because distance in camera and distance in pixel space are degenerate



### Rectification

If 2 cameras orients to the same direction?

* Epipole is in infinity 
* Epipolar line is x-axis 
  * Thus 





## Rectified Binocular Stereo

In the case of rectification, corresponding points can only move in one direction, thus difference of 2 images could be coded in disparity of each point. Figure out  **Depth map** from **Disparity map**. 
$$
R[x-d(x,y),y]\sim L[x,y]\\
\Delta z^{-1}\propto d(x,y)^{-1}
$$

### How to find correspondance?



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
  * Defined as a code for local gradient with spatial information in it! 
  * Note, it's different from histogram of gradient, as the spatial information is still coded and affect the distance matric! Thus it's not Rotation / Mirror invariant. 



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





