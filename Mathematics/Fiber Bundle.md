Fiber Bundle
=====
流形上切空间整体, 流形上的标架

## Definition 

**Fiber Bundle**: $\pi:E\to M$, 而结构群$G$左作用在纤维$F$上, 

1. 局部平凡化: 存在$M$的一个开覆盖, $\cup U_a=M$, 在每个$U_a$上$\phi_a: U_a\times F\to \pi^{-1}(U_a)$为光滑同胚
2. 转移函数: 在$U_a\cap U_b\neq \varnothing$上, 每点的纤维在两个局部平凡化中的表示有转移映射$\phi_{b,p}^{-1}\circ\phi_{a,p}:F\to F$, 对应于一个G群中的元素$g=g_{ab}(p)$, : 
$$\phi_{b,p}^{-1}\circ\phi_{a,p}(f)=g_{ab}(p)\cdot f ,\ f\in F\cong\pi^{-1}(p)$$
而且该映射$g_{ab}: U_a\cap U_b\to G$是光滑映射. 

[comment]: # (This actually is the most platform independent comment)

**Comments**:

* 注意 不同于G-主丛, 结构群不**全局**作用在纤维丛空间上, 左作用在每根纤维上
* 转移映射比纤维更本质! 存在覆盖以及转移映射 即可构造丛
* **转移函数的性质**: 
$$g_{ab}=g_{ba}^{-1},\ $$
* $E\cong F\times M$则称丛平凡. 
	* **Remark**: 丛理论的一个Motivation是局部平凡的场在整体上可以怎样不平凡. 
	* 整体拓扑会讨论主丛. 几何学家讨论纤维丛更多.


**G-Principal Bundle**: (纤维即为结构群$F=G$的纤维丛) 一个映射$\pi:E\to M$. 结构群$G$右作用在$E$上. 满足

1. 局部平凡化: $\phi_a: U_a\times G\to \pi^{-1}(U_a)$
2. 群作用等变(Equivariant): 群在$G$上的作用和群在$E$上的作用对应. 对于每根纤维的局部表示$\phi_{a,p}:G\to\pi^{-1}(p)$, 有在丛空间上的作用等价于在$G$空间上的作用.
$$R_h\circ \phi_{a,p}=\phi_{a,p}\circ R_h$$

* 两种定义的思路等价. 


**Vector Bundle**: (纤维为$V^n$向量空间, 结构群为$GL(n,R)$的纤维丛) 

* 向量丛的秩即为n, 每点线性空间维数. 

**Covering Space**: 纤维为离散点, 结构群为作用在点集上的变换群, 即为复叠空间 [复叠空间](./Covering Space.md)

**Section**截面: $\sigma:M\to E$, 使得$\pi\circ\sigma=id_M$

* 所有Section的空间记做$\Gamma(E)$

**Thm:** 一个主丛是平凡的当且仅当其存在截面

### 对于丛的操作
**Pullback Bundle**: 对于流形间映射$f:M\to N$与丛$\pi: E\to N$. 有拉回丛$f^*N=\{(x,p)|f(x)=\pi(p)\}$. 

* 即通过映射把目标流形的纤维拔下来种在自己的流形上. 
* 类似的也可以拉回一个向量场, 把一个Section拉回来

**Product Bundle**: 

**主丛的同构**: 

* 可以关于丛的同构进行纤维丛分类. 


## Connection on Bundle

**一般联络**

**向量丛的联络**


## Fiber Bundle



## Vector Bundle 

### Tubular Neiborghood



## Case Study

### Hopf Bundle


### Tangent Bundle
$TM$

