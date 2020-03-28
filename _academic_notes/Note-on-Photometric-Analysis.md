Note on Photometric Reasoning
====

Shape $\hat n$, lighting $l$, reflectance $\rho$ affect image appearance $I$. Can we infer them back? 
$$
I=\rho<\hat n,l>
$$


> How much does shading and photometric effects tell us about shape, in natural settings. 





Theoretical Analysis 

* There is ambiguity from geometry. If you have $I,\rho, l$ for a pixel and want to infer $\hat n$. You know $\hat n $ up to a cone around $l$. 
* What if we know these on a patch?

Assume the shape is a graph, $z(x,y)$. Can we infer the normal / depth map from image?

IJCV 1999 The Bas-Relief Ambiguity. 

![image-20200326135712579](../assets/img/posts/Taiwan/image-20200326135712579.png)

The Relief appears to be much deeper than they really are, showing that there is ambiguity ($z,z'$ ) from a single view image $I$! 

A family of shapes that have the same appearance (and shadow) when you move light accordingly. 



Assume a family of transform GBR linear transform parametrized by $\lambda,\mu,\nu$ 
$$
z'(x,y)=\lambda z(x,y)+\mu x +\nu y
$$

$$
[x,y,z']=p'=Gp,\ G=\begin{bmatrix}1& 0& 0\\
							 0& 1& 0\\
							 \mu& \nu& \lambda\end{bmatrix}
$$

$$
\hat n'=G^{-T}\hat n
$$

Assume $\rho$ is same, then it could be absorbed into $l$ thus if $l'=Gl$, then

$\hat n'\cdot l'=(G^{-T}\hat n)^T\cdot Gl= \hat n'\cdot l$ 



**Shadow**

* Attached shadow: When the $\hat n$ turns away from light $\hat n\cdot l <0$ 
* Cast shadow: When one part of shape block light to the other part. $p_1\cdot l$

![image-20200326141203463](../assets/img/posts/Taiwan/image-20200326141203463.png)

Need some albedo renormalization for exact same intensity. But changing human perception don't rely on albedo that much, so you may not even need to match that! 

