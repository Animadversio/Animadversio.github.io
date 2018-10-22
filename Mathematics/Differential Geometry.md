# Differential Geometry

[TOC]

**Questions**





# Curves

Define as a mapping from Interval to Euclidean space $r: I->\mathbb{R}^3$. Indeed a 1D object


## Major Questions

* The regular criterion for parametrization. 

    * Proper transform of parameter

* What Quantity is invariant to parameter transform (Analytical Description ) and intrinsic to geometry object? (**Geometric Invariants**) 
    - Arc lenth $ds$
    - Curvature $\kappa$ 
    - Torsion $\tau$ 

* Given the intrinsic properties, existence and uniqueness of curve?  (Construction problem, **Dynamic Equation**)
    - Plane Curve
      $$
      \begin{aligned}

      dT/ds & =\kappa N \\

      dN/ds & =-\kappa T \\

      \end{aligned}
      $$

    - Frenet Equation, Frenet Coordinate self evolution
      $$
      \begin{aligned}
      dT/ds & =\kappa N \\
      dN/ds & =-\kappa T + \tau B\\
      dB/ds & =-\tau B\\
      \end{aligned}
      $$

    - Existence and identity of curve can be proven by integration, or equivalently **Existence and uniqueness of solutions of ODE**  . Cf. [Gauss-Codazzi Eq](#Gauss-Codazzi-Equation)

* Given the geometric properties, how they determine the shape of curve?  (Find Normal Forms)
    - Local expansion
    - Local **normal form** 

* In what condition a curve is closed? 

    * ​

* Cusp in curvature function

    * 四顶点定理

* Maximal/minimal value problem
    - Variational method
    - Euler Lagrange Equation

* Dynamics of a curve: Geometric flow e.g. [Curvature flow](#Curvature flow)


## Methods



## Curvature

- 曲线弯曲程度的描述
- 单位方向向量转向速率$\frac{dr(s)}{ds}$ $\frac{d\theta}{ds}=\kappa_v(s)$
  - Cf. Gauss map 的切映射性质
- 曲线弧长对一阶微扰的响应



## Frenet Equation

Frenet Equation, Frenet Coordinate self evolution:
$$
\begin{aligned}
dT/ds & =\kappa N \\
dN/ds & =-\kappa T + \tau B\\
dB/ds & =-\tau B\\
\end{aligned}
$$
Write the Dynamic Equation of Coordinate on local coordinate, then Geometric Invariant Emerge!!  Cf. [Gauss-Codazzi Eq](#Gauss-Codazzi-Equation) 



## Theorem and Conclusions

### Theorem 四顶点定理



## Interesting things

* 渐屈线 与 渐开线的对偶性
  ​

  ![ExponentialSpiral](/Users/binxu/Documents/2017大五上学期/Differential Geometry/ExponentialSpiral.png)

### Zoo of curves

* 椭圆
* 抛物线
* 旋轮线Cycloid
* 悬链线Catenary
* 曳物线Tratrix
* 螺线Spiral
    * 等角螺线



## Variational method and Shortest Line

$\kappa$ as arc length's response to curve perturbation. 

Specificly, if we define length functional of curve $\mathcal L(\gamma)$ then the curvature vector is the gradient of functional $grad \mathcal L= -\kappa N$ . And this relationship gives the curve shortening flow.   

### Curvature flow

$$dr/dt=-\kappa r$$

每次取曲线弧长上的等距点列，相连成折线。逐次取每个折线段中点重连。

$$r(s)\mapsto \frac14[r(s+ds)+2r(s)+r(s-ds)]$$

$$\Delta r(s)=\frac14[r(s+ds)-2r(s)+r(s-ds)]\approx \frac12\frac{d^2r(s)}{ds^2}ds^2=\kappa N(s) ds^2$$

相当于在曲线上跑热方程，最后会使曲线趋于平滑／圆

[Wiki Curve Shorten Flow](https://en.wikipedia.org/wiki/Curve-shortening_flow)



# Surface

## Major Questions

* Characterize the surface's local curving ?
* Parametrize the Surface, better and optimally ? 
* Reconstruct a Surface given the local derivative data? 
* What constraint a curve / closed curve on surface 



## Local Description of Surface

* 局部一阶信息：
  * 切平面（切空间）、法向、切空间一组基底、局部内积结构
  * $r_u ,r_v, $
  * $$n=\frac{r_u\times r_v}{\|r_u\times r_v\|}$$
  * $$I=dr\cdot dr=Edu^2+2Fdudv+Gdv^2$$ 
* 局部二阶信息：
  * 曲面二阶展开$r_{uu},r_{uv},r_{vv}$ 在法向上分量
  * Gauss映射像的变动与曲面上变动的关系（Gauss映射的切映射）
  * $G: r\rightarrow n(r)$, $dG: dr\rightarrow dn(r)$, $dr\in T_p, dn(r)\in T_{G(p)}=T_p$ 
  * $$II=n\cdot d^2r=-dn\cdot dr=Ldu^2+2Mdudv+Ndv^2$$ 
* 曲率：
  * 内嵌曲线的曲率：法曲率Normal Curvature
    * $\kappa(v) \cos\theta=k_n(v)$, $\theta=angle(n,N)$ 为切向量为$v$ 的内嵌曲线主法向与曲面法向$n$之间夹角 (球)
    * 主曲率为法曲率的极大极小值
    * $k_n(v)=\frac{II(v,v)}{I(v,v)}$ 
    * $II,I$ (Reighlay Quotient) 控制着过该点的所有内嵌曲线曲率. 
  * 曲率作为Gauss映射的微分(Weingarden transform)变换系数
    * esp. 高斯曲率作为Gauss映射的Jacobi ($M$与$G(M)$ 空间的面积变换)
    * $dn=W(dr)$ 
    * $II=<W(dr),dr>$ , 可以发现W映射为$T_p$ 切空间上的自伴算子，因此有本征值$k_1,k_2$
    * 主方向对应$W$上的特征方向. 法曲率极值~Gauss切映射本征值 
    * 局部坐标下$W$的矩阵形式, 
      * $<dr, dn>=<dr, dr>W, W=-I^{-1}II$  
    * 常高斯曲率(CGC) 曲面
      * $K>0$ 球面 Delaunay曲面族
      * $K<0$ 伪球面 旋转曳物线
      * $K=0$ 可展曲面 部分直纹面, 平面, 锥面, 柱面
  * 曲率作为面积对曲面变分的响应
    * 极小曲面(Minimal Surface)，常(平均)曲率曲面(CMC)
      * 物理模型：肥皂泡肥皂膜, 
      * $H=0​$, $H=C​$ 
      * 案例: 
* 局部标准型
  * 二阶标准展开
  * Dupin标准型
* 曲面上矢量场与曲率线 坐标网
  *  曲率线网的存在性


* 


### First Foundamental Form $I$

$$I=dr\cdot dr=Edu^2+2Fdudv+Gdv^2$$ 

* Discribe the arc length structure, 
* The inner product coefficient matrix (metric) inherited from $R^3$ . Or inner product coefficient of ${r_u,r_v}$ basis. 
* Determinant describe area differential $A=\sqrt{EG-F^2}$ 



### Second Foundamental Form $II$

$$II=n\cdot d^2r=-dn\cdot dr=Ldu^2+2Mdudv+Ndv^2$$

* 2nd order deviation projected on the normal 



### Invariant quantity of two differential form 

**Question**: Given 2 differential form what quantity is invariant to parameter change? and have geometric meaning?

$II-\lambda I$ two forms has eigen value and eigen vectors which are invaviant to parameter change. Solve the equation $det(II-\lambda I)$ gives the eigens. 

* Equivalent to eigens of $I^{-1}II$ [Weingartan Map Matrix](#Weingartan-Map)
* Eigenvalues are real, vectors perpendicular to each other .
* Principal direction of maximum/minimum normal curvature
* Invariant scalar : $K=det(I^{-1}II)=\lambda_1\lambda_2 $ , $H=tr(I^{-1}II)=\lambda_1+\lambda_2 $
* 





## Curvature

- Surface's Deviation from plane
  - Local Expansion esp. 2nd order
- The curvature of curves embedded in surface
  - Normal Curvature
- Derivative map induced by Gauss map
- Riemann Curvature: orientation change of vector when parallel transport through a route on surface. 
  - ​


## Gauss map

The map from surface to the tangent on each point (to $S^2$ )

For a surface $r: I\rightarrow \mathcal M, (u,v)\rightarrow r(u,v) $, $I\subset R^2, \mathcal M\subset R^3$ , Gauss map mapping the Surface to $S_2$  $n:\mathcal M\rightarrow S_2, \mathcal M(p)\rightarrow\mathbf n(p)$ . Provide an intrinsic discription of Surface.



### Weingartan Map

The differential of Gauss map, defined on the Tangent space of surface and that of the normal vector space ($S_2$) 

As the two tangent space is the same (same normal), Weingartan map is a linear transform !! (Self adjoint operator)
$$
(n_u,n_v)=(r_u,r_v)W\\
W=-I^{-1}II
$$
With eigen value, eigenvector. 



### Gauss Curvature

Gauss curvature is the determinant of Weingartan map $ K=det(W)=det(II)/det(I)$ or Jacobian of Gauss map

Characterize the area change in Gauss map
$$
K=\lim_{\Omega\rightarrow 0} \frac{Area(G(\Omega))}{Area(\Omega)}
$$
This idea finally goes to Gauss Bonnet theorem Connecting K and topology of surface. 







## Parametrization of Surface

坐标 参数化是微分几何的脚手架，研究几何本身的工具。好的参数化将极大的方便研究，坏的参数化会掩盖几何性质，甚至引起误解(Singularity)

曲面上的坐标场

* 自然坐标$(u,v)$
* 曲率线正交坐标场
  * 正交归一标架场的存在性? $s.t. ds^2=du^2+dv^2$  
    * No!! 
    * 通常不能逐点规范正交化!! 
* 复坐标, 等温坐标
  * [复变函数](Complex Analysis.md)
  * [共形映射](Conformal map.md) 
* [流形(抽象曲面)](#Manifold)参数化——利用测地线
  * 法坐标系 Normal Coordinate
  * 测地极坐标
  * 测地直角坐标

## Gauss-Codazzi Equation

Question: Existence of Surface given $I,II$ form? [Cf. Frenet Eq. ](#Frenet-Equation) 

Thought: Construct the dynamic equation of moving local coordinate (PDE) and find solution Criterion. (Solvable Criterion 可解性条件)

$r_u,r_v,n$ is a local complete basis, so the derivatives of them can always be represented by linear decomposition. 
$$
r_{uu}=\Gamma^1_{11}r_u+\Gamma^1_{11}r_v+L n\\
r_{uv}=\Gamma^1_{12}r_u+\Gamma^1_{12}r_v+M n\\
r_{vv}=\Gamma^1_{22}r_u+\Gamma^1_{22}r_v+N n\\
n_u=-A_{11} r_u-A_{12} r_v\\
n_v=-A_{21} r_u-A_{22} r_v\\
$$
In the concise form $i,j=\{u,v\}$.: 
$$
r_{ij}=\Gamma^k_{ij}r_j+II_{ij} n\\
n_i=-A_{ij} r_j
$$
 For the set of **linear 1st order PDE**, the solution criterion is (Order of partial is interchangeable) 
$$
(r_{uu})_v=(r_{uv})_u; \ (r_{vu})_v=(r_{vv})_u; \ (n_u)_v=(n_v)_u
$$
Resulting in 3 * 3=9 Equations. And 3 non-tricial ones are **Gauss and Codazzi Eq.** 

* ​

### Christoffel

克里斯托符号是 曲面的二阶变动 在局部切空间基上展开的结果。二阶变动在法向的投影是$II$ 基本形式。





### Gauss Egregium

Gauss curvature is determined solely by $I$ form. 



## Curve on Surface

研究曲面上的曲线，自然的 曲线的一些(弯曲)性质被曲面约束着。

Question: 

* 曲线的弯曲性质与曲面弯曲性质的关联，
* 哪些性质是属于曲面本身的？
* 哪些属于曲线的，哪些是曲面一点处的性质？
* 哪些是内蕴的



### Normal Curvature

Curvature of the intersection of plane and surface 





### Geodesic curvature and torsion

Moving frame method to curve on surface. Define moving frame $\{e_1,e_2,n\}$ which connects curve to surface ($n$) . Write Dynamic Equation of moving frame [Cf. Frenet](#Frenet Equation)
$$
\begin{aligned}
de_1/ds & =0\ e_1+\kappa_g e_2+ \kappa_n n  \\
de_2/ds & =-\kappa_g\ e_1+0\ e_2+ \tau_g n \\
dn/ds & =-\kappa_n e_1-\tau_g e_2+ 0\ n \\
\end{aligned}
$$
Geodesic Curvature 

* ​

Geodesic Torsion

* ​





## Special Cases

**Classical way of surface construction**

* Function Graph 函数图像
  *  $r(x,y)=(x,y,f(x,y))$ 
  *  $$E=1+f_x^2,\ F=f_xf_y,\ G=1+f_y^2$$ 
  *  $$n=$$
  *  $$L=f_{xx}/A,\ M=f_{xy}/A,\ N=f_{yy}/A$$, $A=\sqrt{1+f_x^2+f_y^2} $ 
  *  ​
* Revolution Surface 
  * $r(u,v)=(f(u)\cos v,f(u)\sin v, g(u))$ 
  * $$E=f(u)^2,\ F=0,\ G=f'(u)^2+g'(u)^2$$
  * $$n=$$
* Ruled Surface直纹面$r(u,v)=C(u)+v V(u)$ 
  * $$E=,\ F=0,\ G=$$
  * ​

### Extendable surface

**Properties**  

* ​



### Minimal Surface

Solution to the area variation problem.

**Properties**

* ​



### Constant Gauss Curvature Surface

* 球面
* 平面
* 双曲面

# Intrinsic Geometry

内蕴几何考虑的是



## Map between Surface

曲面之间的映射, 

### Isometry

正规曲面$S,\bar S$之间的映射$\phi : S \mapsto\bar S $ 是一个Isometry, 当其诱导的切映射$d\phi$ 在切空间上是一个等距变换. 也即切映射保内积. 
$$
<d\phi(w_1),d\phi(w_2)>_{T_{\phi(p)} }=<w_1,w_2>_{T_p}
$$

* 局部等距映射
  * 对每点存在一个邻域, 其上有一个映射是等距变换
* 全局等距映射
  * 

对于曲面Isometry变换下不变的性质, 即给定了曲面$I$形式后不变的性质, 即Intrinsic Geometry, 也就是黎曼曲面的内容. 



### Conformal map

正规曲面之间的映射, 当其诱导的切映射在切空间上内积只差一个逐点不同的常数, 即切映射保角. 
$$
<d\phi(w_1),d\phi(w_2)>_{T_{\phi(p)} }=\lambda(p)^2<w_1,w_2>_{T_p}
$$

* 解析函数作为复平面到复平面映射, 是一个共形映射. 
* 任意正规曲面均是局部共形于平面的 ([等温坐标存在性](#Parametrization-of-Surface)), 也彼此局部共形. 



### Isometric Group of Surface

有了保长对应，则曲面到自己的保长对应成群。——描述了曲面本身的对称性



## Geodesic



### Geodesic Charts



## Gauss-Bonnet Theorem

### Local G-B



### Global G-B

Global G-B Theorem 由于法映射$n$, 诱导从曲面$S\to S^2$ 的映射, 而$K$代表该映射的像与原像的面积比. 因此积分得到的是$n(S)$ 在球面上覆盖的面积

$$\int\int KdA=2\pi \chi$$



# Riemann Manifold

Abstract Surface. Try to generalize the intrinsic geometry of surface to high-dim geometric objects~

带有度规结构的几何学 [Riemann Geometry](Riemann Geometry.md)

不带度规结构, 但有微分结构的流形几何, 是微分同胚下不变的几何 [Differential Manifold](Differential Manifold.md)



拓扑同胚下不变的东西[[Topology]](Topology.md)


