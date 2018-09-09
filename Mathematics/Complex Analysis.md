Complex Function
========
[TOC]

# Complex Field
复数域

* 复数域作为更大的数域 让我们有更大的的范围可以解代数方程，将方程解的结构看得非常清楚。
* 许多实数函数进入了复数域 得到了关联
* 其本身构成了许多拓扑空间使我们可以研究
* 其又可以成为描述几何 描述方程(QM)的有力工具

## Topology of Complex Number


## Convergence of array


## Riemman Sphere



# Analytical function


## Complex Function

**Partial derivative of complex function**

* $\partial_x,\partial_y$
* $\partial_z=1/2(\partial_x-i\partial_y),\partial_{\bar z}=1/2(\partial_x+i\partial_y)$
	* Though $\partial_z, \partial_{\bar z}$ are not independent, they can be deemed as independent in chain rules of partial derivations.

**Geometric interpretation**

Complex function as mapping between plane/Riemman Sphere

* Derivative of map: Tangent mapping $df$
	* Analytical function induces conformal map
	* Any complex function has a Jacobian  $J$ at each point
* Tangent plane/space
	* Real tangent space/Complex tangent space

## Analytic

**Criterion**

* **Definition**: Exist derivative in complex plane. The limit exist on the point ($A$ is bounded complex)
$$\lim_{z-z_0} \frac{f(z)-f(z_0)}{z-z_0}=A$$
If for each point in the domain of $f$, then $f$ is holomorphic
* **Cauchy-Riemann equation**: $\partial u/\partial x=\partial v/\partial y, \partial u/\partial y=-\partial v/\partial x$
	* Put it another way, the Jacobian of map is this form 
	$$a\ b ;-b\ a$$
	Thus the map is certainly conformal. 
	* And it means $f'(z)=u_x(z)+i v_x(z)$ or to $f'(z)=u_y(z)+i v_y(z)$
	* $
* **Complex derivative**: $\partial_{\bar z} f=0$
	* i.e. Analytical function is only function of $z$ not $\bar z$. $f(z,\bar z)=f(z)$ 
	* Thus the differential $df(z)=f'(z)dz$ independent from $d\bar z$


**Property**

* Analyticity is kept by $+,-,\times$ and $\div$ by non-zero function.
	* Corr: Pure real(imaginary) value complex function is constant
	* Corr: if $\Re[f(z)-g(z)]=0$ or $\Im[f(z)-g(z)]=0$, Then $f(z)-g(z)\equiv const$ 
* Injective Analytic function's inverse $f^{-1}$ is analytic
	* ​Thus induces a homeomorphism between domain and image.

**Geometric View**

* Injective Analytic function induce a holomorphic homeomorphism between domain and image.
	* $f:\Omega_1\mapsto \Omega_2$ is bijective and the inverse is also analytic, thus it's homeomorphism and holomorphic
	* ​

## Series Expansion



## Integral Expression


