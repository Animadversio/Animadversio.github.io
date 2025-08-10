---
layout: post
title: Note on Bifurcation Normal Form
author: Binxu Wang
date: 2021-05-09
# use_math: true
math: true
comments: true
categories: [mathematics]
tags: [Math, Geometry, Dynamic System]
typora-copy-images-to: ..\assets\img\notes\dynsys
---

## Basic Notions

**Def** Topological Equivalence: 2 dynamic systems are topological equivalence when there is a homeomorphism between their solutions.

**Def** **Conjugate**: Two maps are connected by $$g=h^{-1}\circ f \circ h$$. 

* In some fields like group theory this is also called equivariance w.r.t. $h$
* For Discrete dynamic systems, map $f,g$ are topological equivalence when they are conjugate.
  *  $$g=h^{-1}\circ f \circ h$$. 
* For continuous dynamic systems, when the systems $\dot x=f(x)$, $\dot y=g(y)$ are topological equivalence, their flows are conjugate.
  *  $\psi^t=h^{-1}\circ \phi^t \circ h$ 
  *  $h(\psi^t(x))=\phi^t(h(x))$

**Comments**:

* For smooth coordinate change $y=h(x)$ in continuous time system $\dot y=g(y)$ and $\dot x=f(x)$. Then their vector fields suffice $f(x)=(\frac{dh}{dx})^{-1} g(h(x))$. 
	* If this latter property is true over the space, the two systems are conjugates. 

**Locally topological equivalent**: 



**Saddle-Node bifurcation**
$$
\dot x=\alpha-x^2
$$

**Pitchfork bifurcation**
$$
\dot x = x(\alpha-x^2)
$$


**Flip Bifurcation** 
$$
\dot x=x(x-\alpha)
$$

**Hopf Bifurcation**

The super critical Hopf Bifurcation
$$
\dot z=(\alpha+i)z-z\|z\|^2
$$
The sub critical Hopf Bifurcation
$$
\dot z=(\alpha+i)z+z\|z\|^2
$$