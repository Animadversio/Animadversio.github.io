Homology Theory
========


### Category and Functor idea
范畴函子理论. 

## Chain Complex
**链复形**: 一个组合$\{C_q,\partial_q\}$. 其中$\{C_q\}$为一组Abel群. ${\partial_q:C_q\to C_{q-1}}$为一组群同态. 满足$\partial_{q-1}\circ \partial_q=0$

**同调群**: 闭链群$Z_q(C )=ker(\partial_{q})$, 边缘链群$B_q(C )=im(\partial_{q+1})$, 商群为q维同调群$H_q(C )=Z_q/B_q$

**链映射**

* 链映射$f$诱导同调群同态$f_*: H_*(C ) \to H_*(D)$

**链映射的同伦**: 对于$f,g: C\to D$若存在一组同态${T_q: C_q\to D_{q+1}}$, 使得同态
$$\partial_{q+1}\circ T_q + T_{q-1}\circ\partial_{q}=f-g$$
那么两个链映射同伦$f\simeq g$

* 同伦的链映射$f\simeq g$诱导相同的同调群同态$f_*=g_*$

**链的同伦等价**: 若存在两个链复形$C,D$,与$f:C\to D,\ g:D\to C$, 有$f\circ g=id_D,\ g\circ f=id_C$, 则$C\simeq D$两个链复形同伦等价. 

* 同伦等价的链有同构的同调群

Note: {链复形,链映射} 是一个范畴. 取同调群是一个函子. 

## Singular Homology
**单形**: $\Delta_q=\{(x_1,...x_{q+1})|x_i\geq 0,\ \sum_i x_i=1\}\subset R^{q+1}$

* 等价定义 任意位置的单纯形, $k+1$个仿射线性无关矢量(${v_i-v_0},i=1...k$之间线性无关)的凸包.
$$C=\left\{\theta _{0}u_{0}+\dots +\theta _{k}u_{k}~{\bigg |}~\sum _{i=0}^{k}\theta _{i}=1{\mbox{ and }}\theta _{i}\geq 0{\mbox{ for all }}i\right\}$$

**奇异单形**Singular simplex: Continuous map$\sigma: \Delta_q\to X$

对于拓扑空间$X$定义在全体q维奇异单形上的自由Abel群 即q维链群$S_q(X)$. 其元素为q维链$c_i=\sum_j a_j \sigma_j \in S_q(X)$. 

边缘算子$\partial$定义为

### Example
道路连通空间的0维同调群 $H_0(X)=\mathbb Z$ 

单连通空间的1维同调群 $H_1(X)=0$ 


## Simplicial Homology
定义在单纯复形上, 以及单纯复形的实现(可以被单纯剖分的空间上). 

**单纯形**：

* 若一个单纯形$s$的顶点集都包含在另一个单形$t$中，则称$s$为$t$的面

**单纯复形**：一些闭单纯形的集合，其中两个闭单形或者不相交，或者交集为两者的面。（规则相处条件）

**Euler Characteristic**: $\chi(K)=\sum (-)^i \{\sigma_i\}=\sum (-)^i  C_i(K)=\sum (-)^i H_i(K)$

* 对于多面体即 $V-E+S=2-2g$，虽然多面体的面不一定是单形


**Betti Number**: i 阶单纯同调群的维数/rank 

**Euler Poincaré**