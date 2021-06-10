---
layout: post
title: Note on Lyapnov Stability Theory
author: Binxu Wang
date: Apr 9th, 2021
use_math: true
comments: true
categories: [mathematics]
tags: [Math, Geometry, Dynamic System, Control Theory]
typora-copy-images-to: ..\assets\img\notes\dynsys
---


# Stability Theory

## Motivation
We want to know for a dynamic system, in this note majorly autonomous system, when it is stable? The meaning of stability? If it's stable how to prove so. 
Majorly we are going to use Lyapnov functions and spectral properties of linearized system to prove. 

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
**Stable for LTI**:
* If and only if, for $A$ 
	* For the eigen space that geometric multiplicity equal to algebraic multiplicity, $\Re \lambda\leq 0$
	* For the eigen space that geometric multiplicity less than algebraic multiplicity, $\Re \lambda< 0$

**Asymptotic / Exponentially Stable for LTI**:
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

With 1,2 the system is stable at $x^\ast$, with 1,3 system is asymptotic stable at $x^\ast$. 

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

*Interpret*:
* $V(x)$ is bounded by a parabola type thing up and down. so is $\dot V(x)$ bounded to be more negative than a parabola


## Invariance Set Theorems
> This theorem is useful to assist Lyapnov main theorem, when $\dot V(x)$ is neg.semi.def. in the domain.

**LaSalle Theorem** 







## Lyapnov's Indirect Method

### Stability Criterion for LTI
For LTI system $\dot x=Ax$, the criterion above could be reduced to a linear algebraic problem. 

**Lyapnov Equation** $A^T P+PA=-Q$, Given $A$ any n-by-n matrix; $Q$ is positive definite symmetric matrix; Solving $P$ as positive definite matrix.

**Theorem**: There exists a positive definite $P$ solution for any a positive definite $Q$. $\equiv$  $A$ is Hurwitz matrix. 
* Further if $A$ is Hurwitz, $P$ is unique for $Q$

*Interpret*: 
* If a LTI system is exponentially or asymptotic stable, then there is a quadratic Lyapnov function to prove it. 
	* Given a stable linear system, we can pick a $Q$, solve Lyapnov Equation to get $P$.
	* Then we can define $V(x)=x^TPx$, this $V(x)$ will be a Lyapnov function. We can test this function for the non linear system  
	* For this $V$, $\dot V=-x^TQx$ will be negative definite, so it's Lyapnov function.
* In fact, it's proven that $P$ equals, but this is too hard for computation. solving linear algebra is easier.

$$
P=\int_0^\infty e^{A^T\tau}Qe^{A\tau}d\tau 
$$

* Numerically we solve it by `lyap` in `matlab`. 


**Lyapnov's Indirect Method(Connection of LTI and Nonlinear Exponentially Stability)** For system $\dot x=f(x)$, $f$ is C1 and for a $r>0$ the Jacobian map $x\to df_x$ is Lipschitz on $B_r(0)$, then the followings are equivalent.

* $x^*$ is the exponentially stable fix point of the non linear system 
* $x^*$ is an exponentially stable / asymptotic stable fixed point for the linearized system 
* $A=df_{x^*}$ is a Hurwitz matrix

*Interpret*: 

* This is a very strong connection of linearized and nonlinear exponential stability. Spatial geometry + convergence speed. 

* If the linearized matrix has Eigenvalue on imaginary axis, then the fixed point **will not be exponentially stable**, i.e. it will not converge exponentially on some dimension. 

## Converse Stability Theorems
Converse Stability Theorems describes the existence of Lyapnov function given the Stability properties of a fixed point. 

**Converse Asymptotic Stability (Massera)** For $\dot x=f(x)$, $x^*=0$ is an asymptotic stable equilibrium point. $f(x)$ is locally Lipschitz on $\chi$

* Then there exists a ball $B_r(0)$, $r>0$ and C1 function $B_r(0)\to \mathbb R$, satisfying
	1. $V(x)$ is pos.def. at 0. 
	2. $\dot V(x)$ is neg.def at 0. 

If $x^*=0$ is globally asymptotic stable (GAS) and $\chi=\mathbb R^n$ 

* Then there exist a C1 function $V:\mathbb R^n\to \mathbb R$ satisfying
	1. $V$ is radially unbounded 
	2. $V(x)$ is pos.def. at 0. 
	3. $\dot V(x)$ is neg.def at 0. 

**Converse Asymptotic Stability with Domain of Attraction** For $\dot x=f(x)$, $x^*=0$ is an asymptotic stable equilibrium point. Its domain of attraction is $D_0$. Suppose $f(x)$ is locally Lipschitz on $\chi$

* Then exist a C1 function $V:D_0\to \mathbb R$ satisfying
	1. $V(x)$ is pos.def at 0
	2. $V(x)\to+\infty,when\;x\to\partial D_0$. (*Radially unbounded*)
	3. $\forall c>0$, $\Omega_c=\{x\mid V(x)\leq c\}$ is compact subset of $D_0$
	4. $\dot V(x)$ is neg.def. at 0

*Interpret*: The $V$ is a perfect Lyapnov function describing the shape of the domain of attraction. 

**Converse Exponentially Stability** For $\dot x=f(x)$, $x^*=0$ is an exponentially stable equilibrium point. $f(x)$ is locally Lipschitz on $\chi$. 

* Then there exists a ball $B_r(0)$, $r>0$ and function $B_r(0)\to \mathbb R$, satisfying
	1. $c_1 \|x\|^2\leq V(x)\leq c_2\|x\|^2$
	2. $\dot V(x)\leq c_3 \|x\|^2$
	3. $\|\partial V/ \partial x\|\leq c_4 \|x\|$
	4. With $c_1,c_2,c_3,c_4>0$

*Interpret*: The $V$ is a quadratic type function. 



* [Oriolo](http://www.diag.uniroma1.it/~oriolo/amr/material/stability.pdf)
* [Stanford ee363](https://web.stanford.edu/class/ee363/lectures/lyap.pdf)