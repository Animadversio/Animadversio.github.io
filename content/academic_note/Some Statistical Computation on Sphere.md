---
layout: post
title: Some Computation on Sphere 
author: Binxu Wang
date: Oct 13th, 2019 (updated Dec.1st 2020)
use_math: true
comments: true
categories: [mathematics]
tags: [tech note, Statistics, Math, Geometry]
---

# Some Computation on Sphere (Updating)

## Motivation

Recently, in research, we encounter quite a few statistical problems on sphere. For example, 

* Head direction tuning 
* 3d direction of object 
* 3d direction of body parts
* Some 3d tuning 

There are many standard statistical operations on Euclidean space, like getting mean, standard deviation and generate uniform distribution, fitting a model etc. We can perform these operation without thinking. 

But these things become a problem on the sphere, because of the intrinsic Geometry and Topology of the sphere. 



*Note*: [Simulation_and_Visualization_of_Spherical_Distributions](https://www.researchgate.net/publication/324605982_Simulation_and_Visualization_of_Spherical_Distributions) an 2018 review by some UCSB statisticians is a great guide to the topic. 

## Generate Uniform Distribution

**Problem**: Generate a uniform distribution on the sphere. 

Normalized Gaussian distribution will do the work, due to the intrinsic rotation symmetry. However, a uniform distribution does not guarantee to generate no clusters. 



## Generate Uniform Mesh 

This problem differs from the former one, because we want the nearby points to have nearly equal distance from each other. Random sample from uniform distribution may well give us clustered points if the sample number is not very high. 

https://en.wikipedia.org/wiki/Geodesic_polyhedron

geodesic icosphere 



## Define the Mean of Points 

**Problem**: Given a set of points on a sphere, compute their mean. 

**Note**: that circularity happens in the parameter space (intrinsic coordinate of the manifold), but not in the embedded space! So many work could be done easier by resorting to the extrinsic coordinates. 

Check this repo for different method to generate points on a sphere and compare. 

 https://github.com/gradywright/spherepts 

## Fit a Distribution of Sphere

**Problem**: Given a set of sample points $z_i$ on the sphere, fit a distribution defined on sphere as the model of data. 



## Fit a Function Defined on Sphere

**Problem**: Given a set of sample points $z_i$ and their function value $y_i$, estimate a function defined on sphere $f(z;\theta):S^2\mapsto \R$, such that $\arg\min_\theta\|f(z_i;\theta)-y_i\|$ 

**Problem Variant**: If we know the noise scheme (like that of neuron firing rate or photon counts), then the problem could be formulated as a statistical estimation problem

$$
y_i =f(z_i;\theta)+\epsilon\\
\arg\min_\theta\ \mathcal \log L(\theta;y_i,z_i)=\sum_i \log p(y_i,z_i,\theta)
$$


**Solution**: 

The problem is intrisically the same to the curve fitting problem on Euclidean space, which could be solved by optimizing the loss function in the $\theta$ space by gradient or non-gradient optimization methods. The only tricky part is the parametrization of  $f$. 

For example, the function defining Kent distribution is 

$$
f(\mathbf {x} )={\frac {A}{c(\kappa ,\beta )}}\exp\{\kappa {\boldsymbol {\gamma }}_{1}^{T}\cdot \mathbf {x} +\beta [({\boldsymbol {\gamma }}_{2}^{T}\cdot \mathbf {x} )^{2}-({\boldsymbol {\gamma }}_{3}^{T}\cdot \mathbf {x} )^{2}]\}
$$

The parameters are an amplitude parameter $A$, and 2 parameters characterizing the shape and peakness of the function $\kappa,\beta$. And 3 unit-vectors $\gamma_1,\gamma_2,\gamma_3$ forming a set of orthonormal basis ($[\gamma_1,\gamma_2,\gamma_3]\in SO(3)$ which is a 3 parameter matrix group), thus there are 6 parameters for this function. And we can fit this function just as  normal with matlab fitting routines. 

```matlab
ft = fittype( @(theta, phi, psi, kappa, beta, A, x, y) KentFunc(theta, phi, psi, kappa, beta, A, x, y), ...
        'independent', {'x', 'y'},'dependent',{'z'});
Parameter = fit([theta_data(:), phi_data(:)], score_data, ft, ...
                'StartPoint', [0, 0, pi/2, 0.1, 0.1, 0.1], ...
                'Lower', [-pi, -pi/2,  0, -Inf,   0,   0], ...
                'Upper', [ pi,  pi/2,  pi,  Inf, Inf, Inf],...)%, ...
                    'Robust', 'LAR' );
V = coeffvalues(Parameter);
CI = confint(Parameter);
```

## Visualize Function on Sphere

Refer to this note for plotting in `matlab` 

https://math.boisestate.edu/~wright/montestigliano/PlottingOnTheSphere.pdf 



## Numerical Integration on Sphere

**Problem**: Given a set of points and their function evaluations on a sphere $\{p_i\in S^2,f(p_i)\}$ or given a function handle, that could be evaluated at any points on a sphere. Compute the integration of the function on sphere. 
$$

$$


## Numerical Differentiation on Sphere

$$

$$

