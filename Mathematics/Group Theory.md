Group Theory
========
[TOC]


## Definition

**Group**群: 

1. identity 
2. group operation
3. Inverse of group operation 

* **逆映射**: 群中存在$g\mapsto g^{-1}$的"逆"映射, 在离散,有限群中可以导出许多性质
	* 偶数阶群中必存在元素$a^2=e$,(即自逆元素, 是"逆"映射的不动点)
	* "逆"映射不改变元素的阶, 因此order>2的元素个数总是偶数个. 

群的阶: 群的元素个数

**Group action**: 群的作用方式 

1. 左作用: 
2. 右作用: 
3. 共轭作用: 




### 子群
**Subgroup**: 群的子集且满足群公理. (在"逆"映射以及群运算下封闭)

**Coset**: 以子群元素为等价关系$a\sim b, if\ \exists h\in H\ a=hb$, 得到的等价类

* $G:H$子群与陪集组成的集合, $G$模掉该等价关系得到的商空间.
	* 但该空间不一定在运算下成群! 


子群的指数: 子群的左陪集个数$|G:H|$

**Lagrange Theorem**: if $G$ finite, $H\leq G$, $|G|=|G:H||H|$. 

### 群的生成
对于$M\subset G$, 所有包含$M$的子群的交是其生成的子群$<M>$

* 即包含子集$M$的最小子群
* 生成系: $M, which <M>=G$
* 可以由有限生成系生成的群是有限生成群. $\exists M\subset G, <M>=G, \ |M|<\infty$

**Order**元素的阶: $o(a)=|<a>|$, 即使其自作用回到单位元$a^n=e$的$n$的最小值. 可以为$\infty$

**Group Exponent**群的方次数: 群中所有元素order的最小公倍数(LCM)

* 群中每个元素均可生成一个循环子群$<a>$, 依照元素阶数该群为有限或无限. 
	* 因此: 有限群中$o(a)||G|$元素阶数整除群阶数. 
	* 因此: 有限群$a^{|G|}=e$
	* 因此: 有有限个子群的群一定是有限群
* 有限群中一定有许多这样的循环轨道. 有限群可以用循环子群轨道分解.(抛去$e$) 
* 元素的阶和群的方次数是一个同构不变量, 因此可用来快速判定两个群的同构关系

**Cycle Graph**: 用于表现group中这些循环子群性质的图表

https://en.m.wikipedia.org/wiki/Cycle_graph_(algebra)


**Cayley table**: 群的乘法表
https://en.m.wikipedia.org/wiki/Cayley_table

### 正规子群 商群

寻找正规子群的一个动机即可以作商群, 因此可以拆解群. 

**Invariant/Normal subgroup**: A subgroup that is invariant under any conjugate operation of group element. 

$H\leq G$, if any condition below is true, $H\trianglelefteq G$

* $\forall g\in G, gHg^{-1}=H$
* $\forall g\in G, gH=Hg$

**Importance of Normal Group**: for subgroup $H\leq G$, $G/H$ is group iff $H\trianglelefteq G$. 

* 交换群的任意子群为正规子群. 
	* $Z_q\trianglelefteq Z_p$ if $q|p$.  
* 

**Normalizer**正规化子: $N_G(S)=\{g\in G|gSg^{-1}=S \}$

**Quotient Group**: Group formed by a invariant subgroup and all its cosets, use the same group operation. $G/H$

* 商(以及直和)运算是对于群核心的运算. 

**Center**中心: 与群中所有元素交换的元素集合$Z(G)$

* $Z(G)=C_G(G)=\cap_g C_G(g)$

**Centralizer**中心化子: $C_G(S)=\{g\in G|gs=sg\ \forall s\in S\}$

* $C_G(S)\trianglelefteq N_G(S)$ 中心化子是正规化子的正规子群. 

### 群同态
**群同态**：

**同态基本定理** $\phi: G\to G_1 $, then $im(\phi)\simeq G/ker(\phi)$

**第一同构基本定理**: 

**第二同构基本定理**: 

### 群运算
**直和**: 即在两个群的乘积空间上定义群, 非常自然. 
$G\oplus H$ 即群空间为$G\times H$, 单位元为$(e_g,e_h)$, 群运算为$(g_1,h_1)\circ(g_2,h_2)=(g_1 g_2,h_1 h_2)$, 逆为$(g^{-1},h^{-1})$. 

* 交换群的直和还交换. 

**群可直和分解的判定**: 如果$H,K\trianglelefteq G$, $HK=G$, 那么$G=H\oplus K$, 等价于

* $H\cap K=\{e\}$
* G群单位元在$HK$中只有唯一表示

**直积**: 无限个群的直和即为直积. 并无本质区分

## 特殊类型的群

**低阶群的构造与结构**


### 交换群

即Abelian Group。有很好的性质

* 其任意子群是Invariant subgroup 因此可以对任意子群做商
* Abel群, 相当于定义在整数Ring上的Module（近似为整数系数的线性空间）

交换群的一些判定条件: 

* 交换等价于Cayley table是对称的. (检查所有二元运算)
* $Exp(G)=2$是群交换的充分条件. (每个元素都是二阶的)
* 交换等价于"逆"映射$g\mapsto g^{-1}$是群同态(自同构). 

**交换群结构**

**有限生成交换群分类定理**：

### 单群

**Simple Group**: 不存在$G,{e}$之外的正规子群. 

* 单群是某种意义上不可拆分的基本元素, 类似素数
* 例如:
	* 素数阶循环群$Z_p$
	* 交换单群: 
		[有限单群分类]	

**非交换单群**



### 可解群

**Solvable Group**可解群: 




