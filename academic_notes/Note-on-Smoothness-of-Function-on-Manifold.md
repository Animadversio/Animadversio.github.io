

# Smoothness of Function on Manifold

## Motivations



## Dirichlet Energy

Dirichlet energy is defined as the integral of squared norm of functions' gradient in a set. So it's a functional over smooth function on the set $C^\infty (M)\to \R$.  
$$
D[f]=\int_M\|\nabla f\|^2 d\omega\\
$$
An important property of Dirichlet Energy is that the stable points of $D[f]$ gives harmonic functions. 

**Sketch of Proof**: Given a perturbation $u$ then the change of Dirichlet energy w.r.t. the perturbation amplitude $\epsilon$ will be the following. The 2nd equation follows from Gauss theorem. 
$$
\frac{dD[f+\epsilon u]}{d\epsilon}=2\int_M \nabla u \cdot\nabla f d\omega=-2\int_Mu \Delta fd\omega
$$
Thus if this quantity vanish for any given $u$, then $D[f]$ is stable around $f$. which is equivalent to $\Delta f$ vanishes everywhere on $M$. 

## Dirichlet Energy on Manifold 

Given a manifold and a function on it, we would like to define the Dirichlet energy on it. 

### Integration on Manifold

First recall, the definition of an integration on manifold, esp. integration of a scalar field, is the integration of the volume (n-)form. 

Here we assume we work with some local coordinates $\phi:D\to M,u\mapsto p$, then the volume form could be written as this, i.e. the scalar functions are weighted by the determinant of metric tensor $\sqrt{\det g}$. 
$$
\mathcal I=\int_M f(p)dvol_M=\int_D f(\phi(u))\sqrt{\det g}\; du_1\wedge...\wedge du_n
$$
Moreover, if the manifold $M$ is embedded in a ambient Euclidean space, then we could explicitly write out the coordinate map $\phi$ and the Jacobian $J=d\phi$ . Then $g=J^TJ$, which entails $\sqrt{\det g}=\epsilon \det J$ . This simply means the integration will be weighted by the volume expansion factor $\det J$, while the sign of it depends on the orientation of the coordinates. 

### Norm of Gradient

Differential of function is a 1-form on the manifold $df$, while gradient is the counterpart of it in the tangent vector space. 





## Smoothing and Interpolation on Sphere





## Interpolation on point clouds

Two extend this idea further, we want to define the smoothness of tuning with any data point space. 