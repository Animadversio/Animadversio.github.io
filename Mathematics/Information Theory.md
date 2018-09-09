# Information Theory



## Information Entropy

Core idea, **Surprisal**: How a random events happen surprise us. A small probablity event surprise us most!! 

$$
H(X)=-\sum_x p(x)log(p(x))
$$

* Positive: 
* Additive: 对独立随机变量$H(X,Y)=H(X)+H(Y)$  
* Convex to $p$



~Statistical Mechanical Boltzmann Entropy

## Mutual Information

MI of 2 Random Variables: 

$$
I_M(X,Y)=H(X)+H(Y)-H(X,Y)=H(X)-H(X|Y)=H(X)-\sum_y p(y)H(X|Y=y)
$$
平均而言,  给出了Y变量取值之后, X的信息熵(不确定性)减小多少. 


$$

$$




## Comments and Issue

**Disambiguous of entropies**

- the **self-information** of an individual message or symbol taken from a given probability distribution
- the **entropy** of a given probability distribution of messages or symbols
  - **Differential entropy** of continuous R.V. 
- the **entropy rate** of a stochastic process. 

**Prior knowledge constraint ~ entropy**

* 对于一个Distribution/ Stochastic Process 的概率模型，Entropy Well-defined
* 但对于随机过程的一条轨道(一个实现)，一个样本/案例，其Self-information 完全取决于这一事件发生的概率，从而取决于概率模型，或者对可能世界／可能状态空间的估计。
  * 字符集选取，alphabet ，constraint 
  * *"Hamlet"* 以字符为单位, 以Word为单位, 以整本书作为单位计算Entropy结果会很不一样. 
* ​



## Fisher Information

In **Statistical Estimation theory:** the information an observation $X$ carries about the parameter $\theta$ of underlying model $ f(X,\theta)$. **How the change in parameter $\theta$  change the probability density function.** !!! It's the function of underlying parameter $\theta$ . At different parameter, the sensitivity differs. 
$$
f(X;\theta)=\\
\mathbb E[\partial_\theta log(f(X;\theta))]=\partial_\theta\int f(x;\theta)dx=0\\
I_F(\theta)=\mathbb E[(\partial_\theta log(f(X;\theta)))^2]=\int \frac{(\partial_\theta f(x;\theta))^2}{f(x;\theta)}dx=-\mathbb E[{\frac {\partial ^{2}}{\partial \theta ^{2}}}\log f(X;\theta )|\theta]\\
$$
一个随机变量的观测能对一个随机模型的隐变量提供多少信息. 

**Comparison**

* **Fisher Information**: 描述的是一个样本 对一个分布参数提供的信息!! 
  * 注意Fisher information是一个局部量, 与$\theta$ 取值有关! 
  * 二阶近似下 二阶偏微分决定Likelihood Function在Peak/Critical Point 附近有多么的sharp! 
* **Mutual Information**: 描述的是两个随机变量之间的Dependent 关系 
* 两者可以有关联!!

对于一个多维参数, 则生成一个矩阵

$$
I_F(\theta)=\mathbb E[(\partial_\theta log(f(X;\theta)))^2]=\int \frac{(\partial_\theta f(x;\theta))^2}{f(x;\theta)}dx=-\mathbb E[{\frac {\partial ^{2}}{\partial \theta ^{2}}}\log f(X;\theta )|\theta]\\
$$
Brunel 2009



Locally Optimal Linear Estimator







### Cramer Rao Bound

Inverse of Fisher information is the lower bound of variance of any **unbiased estimator**. 







### Multi parameter extension

Fisher Information Matrix











