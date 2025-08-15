For an 0 th order optimization. You only need a way to generate samples around you (sampling) and a way to estimate gradient on these samples. Several aspects will affect the performance of your optimizer 

* Estimating gradient and Hessian to form a step
* Handling constraints 
* Efficient sampling 
* Parametrization of the space or the landscape over the parameters 

## Boundary Handling 

Sampling from a bounded region in a high dimensional space can be a challenge. As rejection based method could be super-inefficient, since a large volume of density will be reside outside the support. 

So there is other strategies that helps this. 

http://dobigeon.perso.enseeiht.fr/papers/Dobigeon_TechReport_2007b.pdf

## Design Optimizers for BigGAN





## Estimating Gradient and Hessian 

Thanks to Dr. Holy, he points out a line of research on [derivative free optimizations](https://en.wikipedia.org/wiki/Derivative-free_optimization), which is Powell's algorithms:  [COBYLA](https://en.wikipedia.org/wiki/COBYLA), [UOBYQA](https://en.wikipedia.org/wiki/UOBYQA), [NEWUOA](https://en.wikipedia.org/wiki/NEWUOA), [BOBYQA](https://en.wikipedia.org/wiki/BOBYQA) and [LINCOA](https://en.wikipedia.org/wiki/LINCOA) algorithms.

The thought behind it is closely related to the LBFGS algorithm. (See [LBFGS notes]({{< relref "Note-on-LBFGS.md" >}})) which is to update the Hessian little by little with minimal change each step. 

