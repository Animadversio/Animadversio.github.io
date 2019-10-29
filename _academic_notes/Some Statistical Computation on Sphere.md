---
layout: post
title: Some Computation on Sphere 
author: Binxu Wang
date: Oct 13th, 2019
Use_math: true
comments: true
categories: [Math]
tags: [tech note, Statistics, Math, Geometry]

---

# Some Computation on Sphere (Compact Riemann Manifold)

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







## Generate Uniform Mesh 

This problem differs from the former one, because we want the nearby points to have nearly equal distance from each other. Random sample from uniform distribution may well give us clustered points if the sample number is not very high. 

https://en.wikipedia.org/wiki/Geodesic_polyhedron

geodesic icosphere 



## Define the Mean of Points 

**Problem**: 



**Note**: that circularity happens in the parameter space (intrinsic corrdinate of the manifold), but not in the embedded space! So many work could be done easier by resorting to the extrinsic coordinates. 



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
f(\mathbf {x} )={\frac {A}{{\textrm {c}}(\kappa ,\beta )}}\exp\{\kappa {\boldsymbol {\gamma }}_{1}^{T}\cdot \mathbf {x} +\beta [({\boldsymbol {\gamma }}_{2}^{T}\cdot \mathbf {x} )^{2}-({\boldsymbol {\gamma }}_{3}^{T}\cdot \mathbf {x} )^{2}]\}
$$
The parameters are an amplitude parameter $A$, and 2 parameters characterizing the shape and peakness of the function $\kappa,\beta$. And 3 unit-vectors $\gamma_1,\gamma_2,\gamma_3$ forming a set of orthonormal basis ($[\gamma_1,\gamma_2,\gamma_3]\in SO(3)$ which is a 3 parameter matrix group), thus there are 6 parameters for this function. 



## Visualize Function on Sphere
