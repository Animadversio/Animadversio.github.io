

## Motivation

Sometimes we want to examine the Hessian or Jacobian of a function w.r.t some variables. For that purpose, autogradient algorithm can help us. 

## Autograd mechanism 

In Essence, `Autograd` requires a computational graph. (*Directed Acyclic Graph*) For each computational node (e.g. $z=f(x,y)$), we define a forward computation $(x,y)\mapsto z,\ z=f(x,y)$ mapping bottom to top, and a backward computation mapping the partial derivative to top to the partial derivative to bottom. $\partial_z\mapsto (\partial_x,\partial_y); (gx,gy)=g(gz;x,y)$ .  

Note that, the backward computation $g$ is *not a function*. In the sense that, it depends on inner variables, same $gz$ can be mapped to different $(gx,gy)$, depending on $x,y$. As a simplest example, for a linear operation[^1] (like convolution), 
$$
z=f(x,y)=x^Ty\\
g(\partial_z)=(\frac{\partial z}{\partial x}\partial_z,\ \frac{\partial z}{\partial y}\partial_z)=(y\partial_z, x\partial_z)
$$
Thus, the node has to store the operand $(x,y)$ in the latest forward pass, which is part of the computational graph. Thus keep track of the operands can take up a large amount of memory. 

Note for some operation

So some important things are 

* when to create the computational graph
* what to keep track of (if some part doesn't need )
* when to let go and compute a new graph

[^1]:*Note*, this credit assignment computation of linear operation is educational, in that the larger argument in $(x,y)$ will get less gradient, and smaller argument will get more! 



Note from the [official documentation]( https://pytorch.org/docs/master/notes/autograd.html ), we know the default	

> An important thing to note is that the graph is recreated from scratch at every iteration, and this is exactly what allows for using arbitrary Python control flow statements, that can change the overall shape and size of the graph at every iteration. You don’t have to encode all possible paths before you launch the training - what you run is what you differentiate. 