Stochastic Process
==============

# Markov Chain
状态空间，(单步)转移概率
初分布

Markov Property(多种等价表述)

$$\mu_i^m P^n_{ij}=\mu^{m+n}_{j}$$

## Property Definition

* 可达性,互通性
  - 状态分类：闭集
  - 互通类：
  - 不可约：无非空,闭,真子集 iff. 只存在一个互通类
  - 但**不一定存在闭的互通类**。(一维确定飘动)
* 首入时$\sigma_i$ 首中时$\tau_i$
  - 首入时$\sigma_i=min(n> 0, X_n=i)$ 
  - 首中时$\tau_i=min(n\geq 0, X_n=i)$, 均为随机变量
  - 常返性$P_i(X_n=i, i.o.)=P_i(V_i=\infty)=1$ 从i出发沿着轨道访问i次数为$\infty$的概率为1
  - 格林函数$G_{ij}$
  - $\rho_{ij}$
* 周期性 非周期

## Major Problem

* 计算某时刻处于某状态集合的概率
* 不变分布的存在性 唯一性 收敛性
  - 不存在的反例
  - 不唯一的反例
* 常返性

## Examples

* Random walk
* Simple random walk (on different grids)
* 一维确定性漂移
* Random walk on Weighted Graph
* Random Tree


## Methods 

* Green Function method
* Electric net-Physics analogy 
* 平均首中时递推式(类比电网的差分方程)




# Renewal Process

Non-Markovian extension of Poisson Process



## Gamma Process

