Topology
===========

# Basic Definitions

## General topology
**Topology** 拓扑: 对于一个集合$X$ 定义了其中哪些子集$U\subset X$ or $T\subset 2^X$是开集, 即定义了一个拓扑, 定义的开集满足:

* 任意两个(有限多)开集的交还是开集
* 任意开集并是开集
* $\emptyset ,X$ 是开集

**Continuous map** 连续映射: 对于映射$f: X\mapsto Y$ Y中任意开集的原像是开集. if $U\subset Y$ is open, then $f^{-1}(U)\subset X$ is open. 

* 等价定义: 
	* 对$p\in X$, $f(p)$ 的邻域$V$ 的完全原像$f^{-1}(V)$是$p$的邻域. 
	* 对$p\in X$, $f(p)$ 的邻域$V$, 存在$p$的邻域$U$, 使得$f(U)\subset V$ 
	* https://en.wikipedia.org/wiki/Continuous_function#Continuity_at_a_point
* 连续映射保持$X$与$f(X)$之间拓扑性质: 连通性, 道路连通性, 可分性, 紧致性


**Separable space**可分性: Exist countable dense subset. 存在可数, 稠密子集

* Real line and subset of real line is separable
* 紧致度量空间 可分
* 稠密: 


**Homeomorphism** 同胚:  Exist a continuous map $f: X\mapsto Y$ , and it has a continuus inverse map. $f^{-1}:Y\mapsto X$ 

**Quotient topology**: 

**Product topology**

**Subspace topology**



## Algebraic Topology

**Homotopy** 同伦: Relationship **between 2 maps**. Exist a Continuous mapping that deform a map into another. $f,g: X\mapsto Y$, exist $H:X\times [0,1]\mapsto Y, H(x,0)=f(x), H(x,1)=g(x)$  , then $f\simeq g$ 

**Homotopy Equivalence** 同伦等价: Relationship **between 2 spaces**. If exist maps $f,g$ from X to Y and back, and $f\circ g\simeq id_Y, g\circ f\simeq id_X$ 

* ​

**Isotopy**: A speific case of Homotopy (relationship between maps). If $f,g$ are embedding and exist $H(x,t)$ that is an embedding at each given $t$, that connects $f,g$. Then it is an Isotopy. 

* Isotopy is the Equivalent Relationship in [Knot theory](Knot Theory). If 2 knots (as embedding of $S^1$ ) are connected by embedding then they are Isotopy

**Ambient Isotopy**: A continuous distortion of ambient space that take a submanifold to another.  $F: \mathcal M\times [0,1]\mapsto \mathcal M$ that connects two embedding $f,g: \mathcal N\mapsto \mathcal M$ . $F_0\circ f=f, F_1\circ f=g$. 

**Homology Group**: 基本群. 空间上的一维道路构成的群. 

* ​



**Homology** 同调: Examining the paths and rings on a topological space to see the topology the space itself. 



## Topological Properties

### Countability 可数性

第一可数性 $C_1$: 每个点有可数邻域基

* 从而可以编号

第二可数性 $C_2$: 空间的拓扑$T$有可数拓扑基$B$.($\forall U\in T$可被表示成$B$中元素并)

* 欧式空间有第二可数

### Separation Axiom 可分性

[分离公理汇总](https://en.wikipedia.org/wiki/Separation_axiom)

**第二可分性** (Hausdorff性质)$T_2$: Two points in $X$ are separated by neighborhood. (have disjoint neighborhood)

* 子空间 乘积空间保留$T_2$属性, 商空间不一定保持. 

### Connectedness 连通性
**Path Connected** 道路连通: 任意两点存在道路相连. 道路即$\alpha:[0,1]\mapsto X$一个连续映射.

**Connected** 连通: 拓扑空间$X$不可被分成两个非空不相交开集的并. 

* 连通不一定道路连通, 道路连通推出连通. [拓扑学家的正弦曲线](https://en.wikipedia.org/wiki/Topologist%27s_sine_curve)

**Branch of Connected** 连通分支: 以连通为等价关系得到的分支

### Compactness 紧致性
其核心idea是模仿欧式空间的有界闭集. 

**Compact space** 紧致空间 : 对于一个拓扑空间, 对于任何开覆盖$\{U_j\}$, 均包含有限开覆盖$\{U_{\alpha_i}\}$. Each open cover for a topological space has a finite subcover. 

* 紧致空间上连续映射的像集紧致->最值定理, 最大模定理
* 紧致蕴含列紧: 紧致集合上点列有收敛子列
* 欧式空间上紧致子集 $\equiv$ 有界闭 

**Sequentially Compact** 列紧 : 任何无穷点列可以取出一个收敛子列

**Quasi Compact** 仿紧: 任何开覆盖存在局部开加细

有关紧致性的结论: 

* Hausdorff空间的紧致子集是闭集
* 紧致空间到Hausdorff空间的连续映射 
	* 若是surjective则是商映射
	* 若是Bijective则是同胚


### Dimension 拓扑维数




## Theorems

### Brower fixed point theorem

拓扑球体的连续自映射 存在不动点. 

