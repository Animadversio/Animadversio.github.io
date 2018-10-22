## Exterior Form

### Multilinear algebra 

**Linear Space** $V$

* With a basis ${e_1…e_n}$ 
* $v=v^ie_i$

Space of linear function on linear space $V^*$ ——**Dual Space**

* Linear Space
* Have a dual basis of linear function $e^1,…e^n$ , $e^i(e_j)=\delta^i_j$
* $f=f_ie^i$ 

**Tensor** : linear functions on product space of $V,V^*$ 
$$
T: V^*\otimes V^*...\otimes V\mapsto R
$$
Tensor basis $e_{j_1},e_{j_2},…e^{j_{r+1}},…e^{j_{r+s}}$ 

Multilinear function on product space form a space $\otimes^r V^*$ . Dual space of $\otimes^r V$ 

* 多重线性函数的空间
* 超曲面上的$I,II$形式 即(0,2)张量

**Tensor Product of Multilinear function** 
$$
f\otimes g (x_1...x_{p+q})=f(x_1...x_{p}) g(x_{p+1}...x_{p+q})
$$
f and g work on different entry

**Antisymmetrize** 
$$
[f] (x_1,x_2...x_r)=\frac1 {r!} \sum_{\sigma\in S(r)}sgn(\sigma) f(x_{\sigma(1)},x_{\sigma(2)},...x_{\sigma(r)})
$$
**Exterior form**: 外形式 反对称逆变张量——$V$上反对称r重线性函数
$$
f(x_{\sigma(1)},x_{\sigma(2)},...x_{\sigma(r)})=sgn(\sigma) f(x_1,x_2...x_r)
$$
$\sigma$ 是$(1,…r)$ 上的一个置换 ($\sigma\in S(r)$). 故外形式是个$C_n^r$ 维度的空间. r阶外形式空间记做 $\wedge^r V^*\subset\otimes^r V^*$ 

* n阶外形式$\wedge^n V^*$是个1维空间, 基矢量是$e_1\wedge e_2…\wedge e_n$ 可以称为Volume form 或者Orientation form

**Exterior Product, Wedge** 外积 楔积: 反对称化与张量积运算的合成. $\wedge^r V^*\times \wedge^s V^*\mapsto \wedge^{r+s} V^*$ 
$$
f\wedge g= \frac{(r+s)!}{r!s!}[f\otimes g]\\
{\omega \wedge \eta(x_1,\ldots,x_{k+m})} = \sum_{\sigma \in Sh_{k,m}} \operatorname{sgn}(\sigma)\,\omega(x_{\sigma(1)}, \ldots, x_{\sigma(k)}) \eta(x_{\sigma(k+1)}, \ldots, x_{\sigma(k+m)}),
$$










###  Exterior Algebra



[Cf. Lie Algebra](Lie Group.md)



## Exterior Differential form

For differential manifold $\mathcal M$ there is a tangent and cotangent space each point $T_p,T_p^*$  natural basis, for the regular coordinate $u_1….u_n$ , 

* $du^i$ is the operator to extract $i$ entry in the tangent vector thus a basis in $T_p^*$ 
* $\partial_{u^i}$ is the differential operator. For a manifold with realization in space $r(u_1…u_n)\in\mathcal M$, it denoting $r_i=\partial r/\partial u_i$ , the natural basis of  $T_p$
* $\partial_i(du^j)=\delta_i^j$  

The elements of vector and covector change w.r.t  basis of  $T_p,T_p^*$ . Easy to follow chain rule, denote the Jacobian matrix 

* $$
  \frac{\partial \tilde u^i }{\partial u^j}=J^i_j\\
  \frac{\partial r}{\partial \tilde u^i}=\frac{\partial r}{ \partial u^j} \frac{\partial u^j}{\partial \tilde u^i }\\
  \partial_{\tilde u^i}=(J^{-1})_i^j\partial_{u^j}
  $$


用这组基底，则在流形上坐标变换时向量空间的基矢量变换非常直接，对偶向量空间也是。

Thus the transform of elements of vector and dual vector is 
$$
v^{i'}=J^{i'}_i v^i\\
f_{i'}={J^{-1}}^i_{i'}f_i
$$
So 







### Hodge Dual

https://en.wikipedia.org/wiki/Hodge_star_operator















