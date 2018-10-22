



## Setting

* ​


## Questions

* Decoding
* Filering: Bayesian Filtering 用地推方法估计后验
	* Kalman Filtering
* Prediction



## Basic Example of HMM

* ​



### Loss function Setting

Scalar function 

* L2 loss (Mean Square Error): 得到 Mean
* L1 loss (absolute): 得到 Median
* 0-1 Delta Loss : 得到 Mode




$$
s_t= E[s_t| y_{1...t} ] =\int s_t p(s_t| y_{1...t})ds_t
$$
**Bregman Loss** 

定义可微凸函数$\phi: R^p\mapsto R$ , 有Bregman距离 $L_p(\theta, a)=\phi(\theta)-\phi(a) -(\theta-a)^T\nabla \phi(a) $ 

**好性质**

* ​


* $\phi(a)=a^2$ 诱导的就是2范数
* 对于一个离散分布$a$向量, 如果$\phi(a)=-\sum a_i\log(a_i)$ 诱导的就是K-L Divergence: 分布之间的距离

$$L_p(\theta, a)=\phi(\theta)-\phi(a) -(\theta-a)^T\nabla \phi(a)\\=$

* 一范数是否能表示成Bregman距离?



## Filtering Algorithm
$$bel(s_t)=p(s_t|y_{[0-t]})$$

$$\bar{bel}(s_t)=\int p(s_t|s_{t-1})bel(s_t) ds_t$$

$$bel(s_t)=\eta p(y_t|s_t)\bar{bel}(s_t)$$


## Probability Calculation
$\alpha,\beta,\gamma,\xi$ iterative method. 


## Parameter Learning

[EM Algorithm](Expectation Maximization.md)
Balm-Welsh ALgorithm: 

一种近似优化方法







**Example** 递归算法 与 批处理
对于一个线性 Gaussian Noise模型
$$y=X\theta + \epsilon$$

显然有: 
$$p(y|\theta)=\mathscr N(X\theta, \sigma^2 I_p)$$
可以求其参数的后验分布(Batch算法)

$M_N=
$\Sigma_N


也可以每个样本逐个Update进行Recursive计算
$$p(\theta|y_{[0-t]})=p(\theta|y_{[0-t-1]})p(\theta|y_t)$$







