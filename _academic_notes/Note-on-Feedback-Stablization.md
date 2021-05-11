---
layout: post
title: Note on Feedback Stablization
author: Binxu Wang
date: May 10th, 2021
use_math: true
comments: true
categories: [mathematics]
tags: [Math, Geometry, Dynamic System, Control Theory]
typora-copy-images-to: ..\assets\img\notes\dynsys
---

[Stability Theory](Note-on-Nonlinear-System-Stability.md)

When a system has control, then comes the questions of whether we could make it stable under the control. 

Regular Feedback: regular feedback is a function $\bar u$ on state space $\mathbb R^n$, 1) Locally Lipschitz on $\mathbb R^n\setminus \{0\}$ 2) continuous at 0

## Problem Setup
A control affine system is this

$$
\dot x =f(x)+\sum_i g_i(x)\bar u_i=f(x)+g(x)\bar u
$$

**Interpretation**: 
* This control system has multiple vector field, a drift field $f$ by default, and a few "Gain" field that you can control $g_i$. 
* You can modulate those "Gain" fields and leverage the drift fields to navigate the space. 
* Note in the degenerate case, if $f=0$ and $m=1$, then $\dot x=\bar ug(x)$, this system is driftless, and the control signal can only modulate speed / time, cannot change the track. 


The **equilibrium stablization** problem is: For a controlled equilibrium $0$, $f(0)+g(0) u^\ast=0$, find a feedback function $u:\mathbb R^n\to\mathbb R^m$, s.t. $x=0$ is a globally asymptotic stable equilibrium. 

## Condition for Existence

Main theorem is **Arstein Sontag theorem**

**Arstein Sontag theorem**: For $\dot x=f(x)+g(x)\bar u$, $f(0)=0$,  there exists a **global** regular stablizer if and only if, there exist a $C1$ contrrolled lyapnov function (CLF), which satisfied small controlled property.


* Note this theorem states only continuous feedback. There are scenarios that requires in-continuous or more complex feedback like those with internal dynamics. 

**Controlled Lyapnov Function**: A function $V:\mathbb R^n\to \mathbb R$, that is pos. def. at 0 and radially unbounded. Also satisfies the equivalent conditions

* When $x\neq 0$, and when $L_{g_1}V=L_{g_2}V=L_{g_i}V=0$, then $L_{f}V\neq 0$ 
* $\forall x\neq 0$, then there $\exists u\in \mathbb R^m$ s.t. $L_{f}V+\sum_i u_i L_{g_i}V<0$
	* Or $\forall x\neq 0$, $\inf_{u\in \mathbb R^m} [L_{f}V+\sum_i u_i L_{g_i}V]<0$

*Interpretation*: 
* This C.L.F.'s property and existance is mandated by the [converse Lyapnov theorems](Note-on-Nonlinear-System-Stability.md#Converse-Stability-Theorems). 
* There exists at least a control vector everywhere to decrease the C.L.F.
* When all the control signal cannot decrease C.L.F. (geometrically, the gradient of C.L.F. is orthogonal to all the vector fields $g_i$), then the drift field can still decrease C.L.F.


**Small Control Property** For a C.L.F., $\mathbb R\to\mathbb R$, $\forall \epsilon>0,\; \exists \delta >0$, such that, $\forall x\in B_\delta(0)\setminus 0$, there $\exists u\in B_\epsilon(0)$, s.t. $L_{f}V+\sum_i u_i L_{g_i}V<0$. 

*Interpretation*: When the state deviation from equilibrium is small, you can use a small control to make it converge. (the Columb repulsion is like a counter example.)

[MIT Dynamic System and Control 2011](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-241j-dynamic-systems-and-control-spring-2011/lecture-notes/)