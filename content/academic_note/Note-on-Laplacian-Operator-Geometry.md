---
layout: post
title: Note on Laplacian Operator (Diffusion) in Geometry Processing
author: Binxu Wang
date: 2020-05-08
# use_math: true
math: true
comments: true
categories: [mathematics, algorithm]
tags: [tech note, Math, Linear Algebra, computer vision, Graphics, computer graphics, Geometry]
typora-copy-images-to: ..\assets\img\notes\spectgraph
---

# Note on Laplacian-Beltrami (Diffusion) Operator 

## Motivation

[Laplacian on graph](Spectral-Graph-and-Segmentation.md) and on discrete geometry (mesh) are very useful tools. 



One core intuition, just like Laplacian in $\R^n$ space, it's related to diffusion and heat equation. Recall the diffusion equation is 
$$
\frac{\partial \phi}{\partial t} = \nabla\cdot D\nabla\phi
$$
Note in differential geometry's term, this operator is intrinsic, so it doesn't depend on embedding of manifold in external space. It only depends on the metric of Riemann manifold. 

## Relation to Fields in Pure Math 

This notion is also a intersection of many fields, here are a few examples

### Spectral Geometry

On a Compact Riemann manifold, we can define a Laplace operator, and it will have a discrete spectra (provable). 

There is some deep connections between the spectra of a manifold and it's geometry and topology! 

### Harmonic Analysis 

Harmonic function are those that solves Laplace equation on some domain. 



## Smoothing

So one of the prominent usage of Laplacian operator is to do smoothing on geometry (any manifold). Define some data on a manifold, then run the diffusion equation to make it smooth. This in essence is doing gradient descent on the Dirichlet energy of the function. 
$$
E_D[f]={1\over2}\int_\Omega\|\nabla f(x)\|^2dx=<\nabla f,\nabla f> \\
f:\Omega\to \R,\; E_D:H^1\to\R \\
\nabla E_D[f]=\nabla^2f=\Delta f
$$
Thus there is a well known Laplacian smoothing algorithm 
$$
f\gets f-\epsilon \Delta f
$$
In geometry processing, this continuous notion will go back to a Laplacian on discrete geometry, i.e. network embedding or mesh. Just as in [Spectral Graph Theory](Spectral-Graph-and-Segmentation.md) 

## Spherical Harmonics

Recall from special function and Quantum Mechanics, we know that the spherical harmonics are a group of basis function on sphere. 

How do we get them? Yeah, when we are trying to find the steady states of Hydrogen atom, we (kindof) solve Laplacian equations in 3d space, and then separate of variables leads us to solve the angular part on $S_2$. The equation becomes a eigen equation for Laplacian operator (Helmholtz equation) on sphere. 
$$
\nabla^2Y=\lambda Y\\
\frac{1}{\sin\theta}\frac{\partial}{\partial\theta}\left(\sin\theta\frac{\partial Y}{\partial\theta}\right)+\frac{1}{\sin^2\theta}\frac{\partial^2Y}{\partial\phi^2}=\lambda Y
$$
So actually, the angular wave functions for hydrogen atom, are all the eigen functions for Laplacian operator on sphere. Thus it's not surprising they form a orthonormal basis for function on sphere. 

Literally, harmonic function are those that solve Laplace equation. Here we are solving the eigen equations for Laplacian equations. 
$$
f:S_2\to\R\; ,\nabla^2f =\lambda f
$$
So this idea could be generalized to more domains, graph or manifold! Solving and finding eigen functions for Laplace equations on these domain will give you a set of eigen function useful for parametrize stuffs! 



https://en.wikipedia.org/wiki/Spherical_harmonics

## Discrete Laplacian 





## Minimal Surface







## Reference

[2005 GEOMETRIC DIFFUSIONS AS A TOOL FOR HARMONIC ANALYSIS AND STRUCTURE DEFINITION OF DATA](https://signallake.com/innovation/PNAS05_diffusion.pdf)

[Spherical parameterization for genus zero surfaces using Laplace Beltrami eigenfunctions Julien Lefè](https://www.youtube.com/watch?v=2k6j0UUPpSY)

 

[Intro to Spectral Geometry](https://www.ems-ph.org/books/186/9783037191514_introduction.pdf)

