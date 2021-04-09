---
layout: post
title: Note on Stability Theory
author: Binxu Wang
date: Apr 9th, 2021
use_math: true
comments: true
categories: [mathematics]
tags: [Math, Geometry, Dynamic System, Control Theory]
typora-copy-images-to: ..\assets\img\notes\dynsys
---

<!-- # Nonlinear Dynamic System Notes -->

# Stability Theory
## Definitions
**Definitions** Given a system $\dot x=f(x)$, and a equilibrium point $f(x^*)=0$ let it be $x^*=0$. The equilibrium point is 

* Stable: $\exists \delta,\epsilon, \|x(0)\|<\delta \implies \forall t>0,\|x(t)\|<\epsilon$
	* *Interpret*: Points starts around fix point, stays around it. 
* Unstable: When it's not stable. 
* Attractive: $\exists \delta,\|x(0)\|<\delta \implies \|x(t)\|\to 0,when\; t\to\infty$
	* *Interpret*: Points starts around fix point, converge to it finally.
	* *Note*: A equilibrium can be attractive without being stable. (Saddle on Limit Cycle)
* Asymptotic stable: Attractive and stable
	* *Interpret*: points starts around fix point, stays around and converge finally.
* Exponentially stable: $\exists \delta,\|x(0)\|<\delta \implies \forall t, \|x(t)\|\leq ce^{-\alpha t}$, for $c,\alpha>0$
	* *Interpret*: Points converge to fix point, can be bounded by exponential.
	* *Note*: $ES\implies AS$
* Globally Asymptotic Stable: For all initial $x_0$ 
* Globally Exponentially Stable: For all initial $x_0$ 

**Comments**:
* Stability concept refers to a fixed point, not a system; but for LTI, you can say stability of a system.

### Comments for Linear System
**Comments for Linear System**

For Linear system (LTI)
* Asymptotic stable $\equiv$ Exponentially Stable

Linear system $\dot x=Ax$ has one or infinite equilibrium points. 
* LTI can be AS/ES only when it has only 1 equilibrium point.
* When LTI has infinite equilibrium point, it's stable or unstable.


**Criterion**
Stable for LTI:
* If and only if, for $A$ 
	* For the eigen space that geometric multiplicity equal to algebraic multiplicity, $\Re \lambda\leq 0$
	* For the eigen space that geometric multiplicity less than algebraic multiplicity, $\Re \lambda< 0$

Asymptotic / Exponentially Stable for LTI:
* If and only if $\Re \lambda_i<0$, for $A$. 
	* Also known as $A$ is a Hurwitz matrix. 


## Spectral Stability Theorems (Lyapnov's First Methods)
**Lyapnov's First Methods**: For a system $\dot x=f(x)$, with a fix point $x^* $, consider the Jacobian of it at fix point $J=\partial f/\partial x$

* If $\Re\lambda_i<0,\forall i$, then the fix point is asymptotically stable.
* If $\Re\lambda_i>0,\exists i$, then the fix point is unstable.
* If $\Re\lambda_i=0,\exists i$, then cannot decide.

*Comments*: This connects to the stable and unstable manifold theorems.


## Lyapnov Functions Stability Theorems (Lyapnov's Second Methods)

**Lyapnov Main Theorem**: Given a system $\dot x=f(x)$, with a fix point $x^* $. If exists a C1 function $V:D\to\mathbb R$

1. $V(x)$ is pos.def. on $D$
2. $\dot V(x)$ is neg.semi.def. on $D$
3. $\dot V(x)$ is neg.def. on $D$

With 1,2 the system is stable at $x^*$, with 1,3 system is asymptotic stable at $x^*$. 

**Comments**: 
* Existence of Lyapnov function is sufficient but not necessary for stable fix point. See [Converse Theorems](#Converse-Stability-Theorems)

**Chetaev Instability Theorem**: Given a system $\dot x=f(x)$, with a fix point $x^*=0 $. If exists a C1 function $V:D\to\mathbb R$

1. $x^*$ is on the boundary of $G=\{V(x)> 0\}$, which implies
	* $V(0)=0$
	* $0\in \partial\bar G$
2. Exist a neighborhood $U$, $\dot V(x)<0,\forall x\in U\cap G$ 

*Interpret*: There is a direction or space that $x$ will leave fix point and keep increase $V$. 

**Barbashin-Krasovskii theorem for Globally Asymptotic stable**: Given a system $\dot x=f(x)$, with a fix point $x^* $. If exists a C1 function $V:\mathbb R^n\to\mathbb R$

* $V(x)$ is pos.def.
* $V(x)$ is radially unbounded. $\|x\|\to\infty,V(x)\to\infty$
* $\dot V(x)$ is neg.def.

*Note*: a radially unbounded $V$ guarantees the sublevel sets are bounded.


**Lyapnov theorem for Exponentially Stability**: Given a system $\dot x=f(x)$, with a fix point $x^*=0 $. If exists a C1 function $V:D\to\mathbb R$, and $\exists c_1,c_2,c_3,k>0$ s.t. $\forall x\in D$

* $c_1\|x\|^k\leq V(x)\leq c_2\|x\|^k$
* $\dot V(x)\leq - c_3\|x\|^k$


Alternative **Lyapnov theorem for Exponentially Stability**: Given a system $\dot x=f(x)$, with a fix point $x^*=0 $. If exists a C1 function $V:D\to\mathbb R$, $\exists \alpha$ s.t. $\forall x$

* $V(x)$ is pos.def.
* $\dot V(x)\leq -\alpha V(x)$ 








## Invariance Set Theorems
> This theorem is useful to assist Lyapnov main theorem, when $\dot V(x)$ is neg.semi.def. in the domain.

**LaSalle Theorem**


### Stability Criterion for LTI

For LTI system, the criterion above could be reduced to a linear algebraic problem. 

**Lyapnov Equation**



## Lyapnov's Indirect Method
Connection of LTI and Nonlinear Stability





## Converse Stability Theorems







[Oriolo](http://www.diag.uniroma1.it/~oriolo/amr/material/stability.pdf)