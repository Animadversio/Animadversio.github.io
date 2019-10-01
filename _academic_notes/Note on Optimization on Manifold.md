---
layout: post
title: Note on Optimization on Manifold
author: Binxu Wang
date: June 20th, 2019
comments: true
use_math: true
categories: [algorithm]
tags: [tech note, Algorithm, Differential Geometry, Optimization]
---

Note on Optimization on Manifold
===

[Optimization Algorithms on Matrix Manifolds](https://press.princeton.edu/absil)

[](https://diginole.lib.fsu.edu/islandora/object/fsu:185265/datastream/PDF/download/citation.pdf)

Manifold is locally very similar to $\R^n$ flat space, but globally not. 

Manifold is locally homeomorphic to a Euclidean space of the same dimension, besides there is Riemann logrithm map that connect the local vector space $T_p$ to the neighbourhood of $p$ on the manifold. Thus, many local optimization algorithm that work on flat $\R^n$ space can  work the same on neighborhood of a manifold. The unique thing of working on a manifold is how to transport the local direction information in one neighborhood into another neighborhood. 

To be concrete, consider gradient based optimization algorithm for a function $f$ on manifold $\mathcal M$. The gradient vector can be estimated in a neighbor, 











