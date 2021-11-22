

## Basic Categories of Synaptic Learning Rule

* Associative vs non-associative
  * Non associative, involves one side only. 
  * Associative, involves activity of both pre and post. Associative rules are more often used in computation.
* Local vs Global (homo, hetero synapse)
  * Hetero synapse is to modify weight $w_{B\to A}$ by synapse $w_{C\to A}$. 
* Direction: Potentiation, Depression
* Time scale: Short term, Long term





## Hebbian Learning

$$
\tau_w dw/dt = u v
$$



Updated version is this covariance rule or extended Hebbian Learning
$$
\tau_w \frac{dw}{dt} = u (v-<v>)
$$
* synapse will depress or excite based on activity of post syn firing. Weight  will increase if post syn firing higher than average. 

These learning rules are covariance based. 



A more extended version is the BCM rule (Bienenstock,  Cooper, and  Munro  learning rule). Tune up or down the synapse weight based on a nonlinear function of post-syn activity. 
$$
\tau_w \frac{dw}{dt} = u\cdot \phi(v,\Theta)
$$

* $\phi(v)<0$ if $v<\Theta$ , $\phi(v)>0$ if $v>\Theta$ 
* $\Theta = \bar v(t)$  provide an adaptive threshold similar to covariance rule. $\bar v(t)$ is a time average of recent post-syn activity. Moving average. 
* This define a dynamic system of $w$ and $\Theta$ 
  * At first, weak synapses make post syn v has low firing rate. $\Theta$ is low. Thus all weights tend to grow. 
  * After weight grows, $\Theta$ gets higher, then only above average input patterns are facilitated, not all. 
* Finally the environment or distribution of the inputs $u$ determines what it learns. 

There are theoretical results for this synaptics dynamics 

> Mathematical results, obtained only for certain discrete distributions, are of two types: (2) equilibrium points are locally stable if and only if they are of the highest available selectivity with respect to the given distribution of d and (2) given any initial value of m in the state space, the probability that m(t) converges to one of the maximum selectivity fixed points as t goes to infinity is 1. 



### Weight explosion

* Using only Hebbian or extended Hebbian rule, all weights will explode. 
* Need criterion for weight decay. 



## Oja's Rule

It adds an intrinsic weight decay into the dynamics, depending on the input strength: Stronger input, faster decay. ($v^2$ is element-wise square amplitude of activity.)
$$
\tau_w\frac{dw}{dt}=vu-\alpha v^2 w
$$
L2 Norm of weight value will stay around a fixed point $\|w\|^2$





This can predict or model the homeostasis or competition of synaptic weights: when one synapse strengthen a lot, the other synapses weaken to compensate. 



## BCM Rule





### Remarks

* Note, Hebbian learning requires there are some synapse there in the first place. No weights or 0 weights, will result in no activity => no learning could happen. 
  * This is the same for deep learning. If initial weight is 0, back propagation cannot work. 
  * Biologically, there need to be some synapse to be learned. 





## Content of Hebbian Learning



Hebbian learning is learning the first PC. 

If we average over different inputs, the Hebbian learning equation becomes 
$$
\tau_w \frac{dw}{dt} = Cw\\
C=<(u-<u>)u>
$$


## Sanger's rule



## References

* [handout-hebb-PCA.pdf (berkeley.edu)](https://redwood.berkeley.edu/wp-content/uploads/2018/08/handout-hebb-PCA.pdf)
* [CMU learning rule lec](https://www.cs.cmu.edu/afs/cs/academic/class/15883-f13/slides/learning-rules.pdf) 