Manifold
===========
[TOC]

# Manifold Definition

**Topological manifold**: Given a Hausdorff topological space $M$, if for each point $p\in M$ exist a open neighborhood $p\in U\subset M$, and exist a homeomorphism between $U$ and an open subset in $\mathbb R^n$ . Such space is a manifold (without boundary). 

* **Chart**: for each $U$, the $\psi: U\mapsto \psi(U)\subset \mathbb R^n$ is a Chart
* Atlas: the collection of tuples $\{U_i,\psi_i\}$ 

拓扑流形限制了每点局部可以建立n维坐标系(参数化), 但坐标系之间的转换并未加光滑性限定! 两个坐标之间的转换函数$\phi\circ\psi^{-1}:\psi(U\cap V)\subset\mathbb R^n\mapsto \phi(U\cap V)\subset\mathbb R^n$ 必然是同胚(连续可逆), 但未定义光滑性.

当两个坐标卡之间的转换函数$\phi\circ\psi^{-1}:\psi(U\cap V)\subset\mathbb R^n\mapsto \phi(U\cap V)\subset\mathbb R^n$ 的各个分量的r阶偏导存在且连续则称两个chart $C^r$ 相互转换(相关). 

**Differential Mainfold**: 拓扑流形$M$ 上存在一个微分结构, $A=\{U_a,\psi_a\}$ 构成$M$上的图册. 

* 任意两个Chart图之间$C^r$相关. ($r\in \mathbb Z, \infty,\omega$ 分别为r阶可微, 光滑, 解析) 
* $\{U_a\}$ 构成$M$的一个开覆盖. 
* $A$ 是$C^r$ 极大的!$\mathscr A$ 

* $R$ 上就有不可数个光滑微分结构(相互不等价)


**Note**: 流形本身的坐标系没法求导! 只有欧式空间之间的映射才好求导求偏导. 因此微分, 光滑性都是坐标系之间的关系, 而非内禀坐标与嵌入之后的外在坐标之间的关系!! 谨记

**Equivalence of Differential Structure**: 

**Homeomorphism of Differential Structure**: 

**Note**: 流形上函数/映射的光滑性阶数不可超过流形本身的光滑性阶数. (否则在坐标转换时 阶数会被转换映射的光滑性限制住. 函数光滑性不依赖于所取得坐标chart  


​                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

**Close manifold**: Manifold without boundary. 

**Orientation**: 流形的定向. 若两个chart的转换函数的Jacobian处处为正, 则两个chart定向相容. 若整个微分结构中任意两个chart定向相容, 则该流形时定向的. 

**定向同胚**: 若定向流形之间存在一个同胚$f$. 且两个流形各存在一个定向的微分结构, 使在每个坐标域上$f$坐标表示的J为正, 则两个流形定向微分同胚. 

* 一个定向与其反定向是定向同胚的. 


## Mapping between manifold
**Smooth mapping** 光滑映射: 光滑映射$f:M\to N$ 诱导的某一坐标chart中坐标的映射$y(x)=\psi\circ f\circ \phi^{-1}: U(\subset R^m)\to V(\subset R^n)$ 是光滑的即可. 

**Smooth Homeomorphism** (Differential Homeomorphism)微分同胚: 
映射$f:M\to N$ 及其逆映射$f^{-1}: N\to M$ 均是光滑的. 

## Tangent Space
由于有局部坐标, 也就存在了局部的基矢描述一点附近的状况. 而且通常切空间上的切映射性质很大程度上决定了, 两个Manifold之间局部映射的性质. 

**Tangent and Cotangent vector** (函数-曲线对偶内蕴定义): 

* 考虑所有$M$上函数$f:M\to R$集合$F$
* 考虑所有$M$上过一点p曲线$\alpha:R\to M$的集合$\gamma_p$
* 若$\alpha,\beta\in\gamma_p$, $\alpha\sim\beta$当对于所有$M$上函数$f$, 两者诱导的方向导数相同$df(\alpha(s))/ds=df(\beta(s))/ds$
* 若$f,g\in F$, 在p点$f\sim g$, 当对于所有$\alpha\in\gamma_p$, 对两个函数诱导的方向导数相同$df(\alpha(s))/ds=dg(\alpha(s))/ds$
* 切空间$T_pM=\gamma_p/\sim$, 其元素为过p点曲线的等价类, 记为$\alpha'=X$
* 余切空间$T_p^*M=F/\sim$, 其元素为函数在p点的等价类, 记为$df$ 

导出: 

* 显然, 余切空间作为函数空间有$+,*$代数结构, 成为线性空间
* 作为对偶, 切空间有$+,*$结构, 将曲线局部映射到$R^k$空间中作加和:
	* $k\alpha'+l\beta':=\phi^{-1}(k\phi\circ\alpha+l\phi\circ\beta )$
* 切向量是将余切空间映射成数的线性映射, $\alpha': T_p^*M\to R$
* 余切向量是将切空间映射成数的线性映射, $df: T_p^M\to R$

**Tangent and Cotangent Bundle**: 

**Note**: 切丛较为特殊的构造引出了更为普遍的[向量丛](Fiber Bundle.md)构造. 以及其他更一般的纤维丛. 

### 切映射,推前拉回
对于$F:M\to N$, $\forall p\in M$

**Tangent map**: $dF:T_pM\to T_{F(p)}N$ 

**Pushforward**: $F_*:T_pM\to T_{F(p)}N$ 

**Pullback**: $F^*:T_{F(p)}^*N\to T^*_pM$ 


## Orientation
通常我们理解的定向是外蕴的, 特别是对于超曲面可以考察是否可以统一的连续的每点赋予一个法向量, 并且有直观可定向的流形有内外两面(Jordan-Brewer分离定理). 而对于抽象的微分流形则需要内蕴的从其微分结构(Atlas)或者每点切空间结构($T_xX$)进行定向. 

**微分结构定义** 若流形微分结构中两个chart的转换函数的Jacobian处处为正, 则两个chart定向相容. 若整个微分结构中任意两个chart定向相容, 则该流形是定向的. 

* 存在如上的微分结构, 则流形可定向. 
* 定向流形指已经指定了一个定向的流形. 

**切空间定义** 对$X$中每一点切空间$T_xX$指定一个定向, 使得每个Chart中$\varphi:U\to R^k$的$d\varphi_y$将$T_yX$定向映射成$R^k$中的一个正定向. 

* 线性空间$V$的定向是指: 其有序基$\alpha$的等价类$[\alpha]$. 
* 显然可以从微分结构定义中, 通过每个chart的$d\varphi_y$拉回$R^k$中的正定向形成切空间定义. 

**0维空间的定向** 对于0维流形, 给每个点赋一个定向数$sgn:X\to \{0,1\}$称为一个定向. 

* 0维流形为1维流形的边界, 当且仅当其定向数和为0. 


## Submanifold
一个流形被映入另一个流形时, 维数不同以及切映射性质的一些可能性. 

**Immersion**: A mapping between 2 differential manifold $f: M\to N$, if the differential $df:T_p M\to T_{f(p)}N$ is injective everywhere. $f$ is immersion

* i.e. the rank of differential $rank(df)=dim(M)$
* locally homeomorphism 
* Exist a locally canonical chart around $x\in X, y\in Y$ s.t. the submerssion represent in the local chart is $(x_1,...x_l)\mapsto (x_1,...x_l,0,...0)$

**Embedding**: An Immersion $f: M\to N$ that has global homeomorphism $M\cong f(M) $

* The map (immersion) $f$ is injective
* Homeomorphism refer to $f(M)\subset N$ with the induced subspace toplogy is homeomorphic to $M$, i.e
	* **Caveat**: One-to-one immersion is not necessarily embedding. like $R\to [0,1]\times[0,1],\ t\to [\sqrt2t,t]\mod 1$ is not embedding. 

**Theorem**: if $\psi:M\to N$ is injective smooth immersion, if $M$ is compact then $\psi$ is a embedding submanifold

* One-One, continuous map from compact space to Hausdorff space is homeomorphism. 

**Submersion**: A mapping between 2 differential manifold $f: M\to N$, if the differential $df:T_p M\to T_{f(p)}N$ is surjective everywhere. 

* i.e. the rank of differential $rank(df)=dim(N)$
* Submerssion is open map. 开映射

**Canonical submerssion**: exist a canonical chart around $x\in X, y\in Y$ s.t. the submerssion represent in the local chart is $(x_1,...x_l,...x_k)\mapsto (x_1,...x_l)$
	* 因此存在典则坐标, 使淹没在局部看是一个商映射/坐标空间上的投影. 

### Whitney Embedding 

[ 紧致Riemann流形可以在n维空间里实现吗?? 

**Whitney embedding for compact manifold** 紧致流形可以嵌入任意高维度的欧式空间. 
证明思路: 


**Whitney immersion for any manifold** 

## Manifold with Boundary
带边流形, 很大的扩展了流形可研究的范围. 


# Vector Field on Manifold


# Differential forms on Manifold

## Exterior form

[Exterior form](.\Differential Geometry\Exterior form.md)



## Differential forms

## de Rham Theory





# Riemann Manifold



# Differential Topology
## Morse Theory
通过研究流形上的函数, 特别是其临界值, 正则值来考察流形的Topology. (可以近似看做地图等高线与等高线面截出来的流形部分. )

**Regular point**: with smooth mapping $f:M\to N$, if at point $x\in M$, $rank(df_x)=dim(N)=n$, then $x$ is a regular point. i.e. $df_x$ is surjective. 

**Regular Value**: to $y\in N$ if all $x\in f^{-1}(y)$ is a regular point, then $y$ is called a regular value. 

**Critical point**: All $x\in M$ that $rank(df_x)<n$, i.e. all points in $M$ that are not regular. 

**Critical Value**: image of critical point. 

**Regular value preimage theorem**: 

**CD theorem**: 

### Sard Theorem
关于流形之间映射$f:M\to N$上临界值集的测度. 

**Sard Theorem**: 

### Morse Function
**Morse Function**: Function on manifold $f:M\to R$, which all the critical points are not degenerate. (所有临界点非退化)

* Indegenerate: the Hessian matrix $H_{ij}=\frac{\partial^2 f}{\partial x_i\partial x_j}$is not degenerate


### Traversality
两个子流形相交时的"正则"性(稳定性质/一般性质). 



## Intersection Number



### Mod 2 Intersection Number





### Oriented Intersection Number





## Basic Theorem for Differential Topology

### 单位分解定理
存在一组流形的开覆盖$\{U_\alpha\}$,以及相应的一组函数$\{\phi_\alpha\}$, 使得

1. $supp(\phi_i)\subset U_i$
2. $\forall x\in X,\ \sum_i \phi_i(x)=1$
3. $\phi_i(X)\subset [0,1]$

**Remark**: 即存在单位映射$1:X\to\{1\}$的一个在坐标卡系上的分解,使每个函数都定义在单独的坐标卡上. 因此是一种连接局域定义量构造整体量的方法. 也是一种将整体量划归到坐标系上显示计算的方法. 

* 流形上Riemann度量的存在性: 各个坐标卡上的定义通过单位分解来做光滑混合
* 流形存在关于群$G$不变的黎曼度量: 以$G$的群作用来平均各点的Riemann度量得到不变度量. 
* 定义k维流形上k形式的积分: 局域积分 然后再用单位分解连接求和起来
* 证明Stokes公式




