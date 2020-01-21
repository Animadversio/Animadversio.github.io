# Image Prior: Modeling Spatial Relaionship

Class: CSE 659
Completed: No
Created: Jan 15, 2020 1:48 AM
Materials: https://www.cse.wustl.edu/~ayan/courses/cse659a/lec1.html#/
Reviewed: No
Type: Section

This is the basis for most further applications

We need Regularizer for a spatial configuration 

$$\hat X=\arg\min_X \phi(X)+R(X)\\$$

This could be interpreted in a Bayesian way, 

$$\hat X=\arg\max_XP(X|I)P(I)=\arg\max_X\log\exp(-\phi(X))+\log\exp(-R(X))$$

# Smoothing Regularization

Images (and labels) are smooth (Gradients are small) ! 

$$R(X)=\sum_n\sum_fR(\nabla_f*X[n])$$

**Design Choices**

1. What kind of gradient to penalize
2. How do you penalize (L1, L2, Lp?) (L1 penalty is better often)

## **How to analyze a prior?**

- Find the distribution corresponding to that regularizer

$$p(v)\propto\exp(-R(v))$$

- See how it affect the minimizing result of a loss

$$\min_v(v-v_0)^2+R(v)$$

### Heavy Tail Distribution

- The smaller the p (p<2) the more heavy tail distribution
- Comparing to Gaussian, More emphasis in closing to 0, or quite large!
    - So it's said to be sparse prior!
- Natural image gradients appears to be heavy tail

![Image%20Prior%20Modeling%20Spatial%20Relaionship/Untitled.png](Image%20Prior%20Modeling%20Spatial%20Relaionship/Untitled.png)

### Shrinkage function

The operator defined by solving minimization with regularization 

$$s(v_0)=\arg\min_v\alpha(v-v_0)^2+R(v)$$

- L2: scale the identity line ! $s(v_0) = \lambda v_0$
- L1: Shrink to 0 below $\alpha$, offset other things linearly by $\alpha$
- Lp ($p<1$):  Shrink to 0 below $\alpha$, offset other things

Thus, Heavy tail regularizer will leave small values to be 0, and penalize not as hard towards the larger values. 

![Image%20Prior%20Modeling%20Spatial%20Relaionship/Untitled%201.png](Image%20Prior%20Modeling%20Spatial%20Relaionship/Untitled%201.png)

## Solvable Case

If you use wavelet transform (unitary matrix)

## Optimization

### How Lp affect optimization

- L2, it's a Least square problem,
    - Can solve in Fourier Domain, and can use conjugate gradient! (to avoid forming the matrix Q)
- L1, Convex optimization, iteratively solvable with shrinkage function
- Lp < 1, Not even convex !

## Algorithms

## Problem setting

$$\hat X=\arg\min_X\|AX-Y\|^2+\lambda\sum_n |\nabla_x*X[n]|^p + |\nabla_y*X[n]|^p$$

### Fourier Domain Least Square

If it's 

### **Conjugate Gradient**

We can do CG if $p==2$

Note, if you have per pixel weight, you have to use CG, because it's not convolution.

### Iterative Reweighted Least Square (IRLS)

**Rationale**: We know how to solve least square, so just map the problem to least square

- Use weight to transform problem as p=2
- solve the p=2 Least square
- Update the weights

**Note**: 

- p=1 it's convex, so globally converging
- p<1 it's not guanranteed, as loss is not convex.

### Quadratic splitting

It's the simplest case of **Proximal method** in optimization. 

**Basic Idea: Split the optimization variables into 2, and** introduce relaxation variable  

- Split the problem into 2 and let the 2 parts negotiate and compete!

Relax the problem of 

$$\arg\min_XF(X)+G(X)$$

Into 

$$\arg\min_X\min_WF(X)+G(W)+{\beta\over2}\|X-W\|^2$$

When $\beta$ is large enough, this goes back to original problem

Then you can optimize the 2 variables alternatively and iteratively, if these problems are simple enough! 

$$\hat X_t=\arg\min_X F(X)+{\beta\over2}\|X-W\|^2$$

$$\hat W_t=\arg\min_WG(W)+{\beta\over2}\|X-W\|^2$$

And then you increase $\beta$ from time to time, tighten it up! make it converge back to original problem. 

Note ADMM is more principled version of this. 

In our case, relax the problem as 

$$\hat X=\arg\min_X\|AX-Y\|^2+{\beta\over2}\sum_n |\nabla_x*X[n]-w_x[n]|^2 + |\nabla_y*X[n]-w_y[n]|^2+|w_x[n]|^p+|w_y[n]|^p$$

- Thus Optimization towards $X$ can be solved by Fourier Domain Least Square.
- Optimization towards $w_x, w_y$ are pixelwise 1-d optimization. Can use shrinkage function LUT to compute.
- Also increase $\beta$

Work super well in practise 

- If your problem has multiple parts, these parts doesn't work well with each other, but they all work with quadratic loss,
- Then you can try splitting your problem!

This could be applied to deblurring! 

## Gradient Penalty Regularizer

Maybe the function should not be applied **pixel wise** to gradient, it can be applied to all the 

$$R(X)=R(\nabla*X)[n]$$

$R(.)$ can be a function on the whole space! 

- Using pixelwise regularizer is assuming independence between pixel.

### **Radial function regularizer**

The result is interesting, 

**Shrinkage function** 

$$[v_1,v_2]=\arg\min_{v_1,v_2}\|v-v_0\|^2+\|v\|^p$$

It's just the original shrinkage function applied to radial direction (vector norm direction)

This could be applied to RGB image, the 3 channels are not independent 

# Learning Image Prior

ALmost universal truth

- Better prior are more complicated, harder to optimize
- Better priors are more data driven, better than hand crafted
    - If you have data, do it.

$$R(X)=-\log p(X)$$

**Caveat**: Image itself is too high dimensional, you'd better work with patch! 

## How to learn a distribution?

Choose a parametric form of distribution, which you could evaluate likelihood! 

$$p(X|\theta) $$

Given the Samples 

$$[X_1,X_2...]$$

Do maximum likelihood inference for the $\theta$ 

### Gaussian Prior

Training a Gaussian prior is analytically exact! Just compute the mean and covariance matrix of all your data samples 

- Normally your mean vector at small scale is equal luminance !
- If you do Eigen decomposition of covariance matrix (do PCA), then you will find interesting result
    - PC1 pattern is the overall luminance
    - PC2-.... looks really like Fourier Basis !!!!
- Note if your samples are translational invariant, the Fourier Basis is expected !
    - Note if your images are well aligned, then it's no longer translational invariant, then you will see interesting patterns!

Actually Gaussian prior regularizer is equivalent to regularizing a filtered image. 

- Note the first PC is different!
    - Usually the first eigenvalue is pretty large !
    - And the distribution over the first eigenvector is not Gaussian! more uniform.
- The next few components will work like convolving $V_i$ onto image with a squared penalty on gradients





### Bayesian Interpretation of Gaussian Denoising



The posterior of 2 Gaussian multiplied is still a Gaussian! Good ! 



Two kinds of Bayesian estimator

* MAP, maximum / **mode** of the posterior $\arg\max_X p(X|Y)$
* Mean Estimator $\mathbb E_{p(X|Y)}(X)$ 

Note for Gaussian, mean and mode 



## Gaussian Mixture Prior 

$$
p(x)=\sum_i\pi_ip(x;\mu_i,\Sigma_i)\\
\sum_i \pi_i=1
$$

This is a pretty good  distribution. 

* Mean $\mu=\sum_i\pi_i\mu_i$ 
* Covariance: Consists of within gaussian term and across gaussian term (variance between the mean). 
  * $\mathbb E (X-\mu)(X-\mu)^T=\sum_i\pi_i\Sigma_i +\sum_i\pi_i(\mu_i-\mu)(\mu_i-\mu)^T$  

**High Flexibility**

* Multimodal
* The covariance structure is not "ellipsoidal", it can be more restrictive, choosing between axis 1,2,3 ! 
* The decay is not of gaussian speed! ---- heavier tail distribution! 
  * Choosing between close to 0, 
* etc. approximation to any function, given enough components. 

**Note**: this is also quite powerful for theoretical purpose, can use this as model of underlying distribution. 



### Fitting a Gaussian Mixture

**Parameters**: $\Theta =\{\pi_i,\mu_i,\Sigma_i\}$ 

**Bad news**: likelihood non-convex! 

* Note, there is **internal swap symmetry** of the Likelihood function, thus it's definitely non-convex

$$
\arg\max_\Theta \sum_t\log\sum_i\pi_i\det(2\pi\Sigma_i)^{-1/2}\exp(-\frac12 (X_t-\mu_i)^T\Sigma^{-1}(X_t-\mu_i)) 
$$

You have to use EM algorithm. 

### Expectation Maximization

Think of mixture of gaussian distribution as a 2 step process. 

Introduce the label variable $Z\in\{1,2,...k\}$ with distribution 

$p(Z=i)=\pi_i$

The posterior distribution of $X$ is Gaussian. 
$$
p(X\mid Z=i)=\mathcal N(X\mid \mu_i,\Sigma_i)
$$


The variable $X$ marginalizes as 
$$
p(X)=\mathbb E_Z p(X\mid Z)=\sum_ip(Z=i)p(X\mid Z=i) 
$$




