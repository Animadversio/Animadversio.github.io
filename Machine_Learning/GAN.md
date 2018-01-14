# Generative model

## Motivation

学习一个distribution而非仅仅是平均 min (Min Square Error). 有时min是不好的, 而从分布中采样才好.—并不是某个空间中的Gaussian, 可能换一个空间能成为Gaussian. 

(每个样本都有用, 而不只有均值. )

Generative Model 的特点, 相同的输入可以有大量不同的输出

应用: 

* 预测转动后的人脸
* Image from sketch
* Interactive Photo Editing, 在修改时自动补全
  * 建模所有人脸的分布
  * 修改之后, 逼近到分布中最近的点
* Image 2 image translation

对Distribution建模即最大似然估计

* Maximum Likelihood

  * 直接能求density
    * Exact
      * ​
    * Approximate
      * Markov Chain
      * Variational 


  * 不能求Density
    * Markov Chain
    * GAN



### Exact model: NVP 

学习两个变量空间的映射 f, (相当于重新画坐标线, 划分相格) 使得原来的Gaussian分布后来在新的坐标下满足我们的分布. 并且**可逆**, 因此可以从Gaussian分布采样逆映射生成一个样本. 

直接映射方法

* Con :
  * Topology constraint of Multi-Gaussian
  * 通常神经网络不可逆….(ReLU, pooling, )

Invertible Nonlinear transform

受到密码学启发(MD5) 构建的一种可逆Transferm

**Note**: 人脸通常对Generative Model比较简单!! 方向, structure很简单, 接近单连通的一个Gauss分布, 扭一扭也就OK了

用这种transform搭建神经网络可以做Generative model

强行要求 invertible 不符合视觉系统的生物构造! 



## Variational Auto-Encoder

* 经典Auto-encoder 
  * http://kvfrans.com/variational-autoencoders-explained/
  * 将高维图片压缩成Code
  * 压缩之后一些主要的维度可以凸显出来!! 可能对应于Feature
  * But Code空间的Distribution通常非均匀. 作为Generative model. 不很好用
* Denoising autoencoder
  * 输入有Noise的图片, 与Ground Truth算Loss
* What is Varitional? 
  * 学习的是一个均值方差, 然后重采样, 去生成一个图片 Minimize Loss
  * ​



## Generative Adversarial Network

生成对抗网络

* Generator
  * 从低维gaussian分布 反卷生成图片
* Discriminator
  * 从图片开始卷, 输出真假
  * 分辨两者, 减少生成分布与样本分布之间的距离
* Train network
  * 同时train肯定训练不动!! 两者目标相反
  * G, D交替
  * 但不一定每个训一个Epoch可能一方面训多次

DCGAN生成室内图片

* 频率可能不一样, 但每个生成出的看起来都不错~ 
* 不一定能

**Ability**

* Feature vector manipulation
  * 一个feature vector直接对应一个semantic信息
  * Feature空间类似线性的, 可以加减
* 根据描述去画图
  * ​

边缘锐利! 色彩清晰, 色调好~ !! 

**Problem**

* Gan Training problem
  * Fluctuation很多, 需要动态平衡
  * 而且需要微调G train几次 D几次, 防止梯度消失, 一个训不动, 一个被一棍子打死
  * 很难看出收敛, 不知道什么时候停下来…训一会看一看



### Wasserstein GAN

* 思想很深邃! 
* 看起来能收敛了! 
  * 约束了dicriminator能力
  * 不会Variation那么大
* 试图用学会min Wasserstein Dis来解释效果变好
  * 然而数学分析发现, 肯定不是的! 高维空间的Wasserstein Dis 太复杂, 学不动



the GAN zoo 每年几百篇…..



### GAN 杂耍

* Cycle GAN
  * 寻找两个图片空间的对应关系 : 夏天变成冬天 冬天变成夏天 马-斑马
  * 训练两个$f\circ f^{-1}=id $ 
  * 相当于用另一个图片空间的特征(斑纹)来Code颜色
  * 说到底这里有信息量限制! 如果背景都是白的则没法encode什么东西
* DiscoGAN
  * 学习不同Domain的映射
* GeneGAN
  * Gene的杂交
  * 改变表情, 改变发型等

# Mathematic Aspects



## Method of Density Representation

* Sampling and Density estimation
* RBM: 
  * 不能获得一个样本概率, 但是能比较样本之间概率
  * 历史意义在于 Stacked RBM在早期帮助train了深层网络
  * http://blog.echen.me/2011/07/18/introduction-to-restricted-boltzmann-machines/
* MCMC Sampling: 
  * 只要能比较
  * 作随机游走, 通过这个MC的平稳测度获得一个分布
  * 不过行走足够长步数, Equilibrium才行



### Distribution 2 Sampling

任意的一个Distribution采样可以很难!! 

可以构造反例类似, $p(x)={MD5(x)==0}$ 必须要解方程才能求出一个sample

### Sample 2 Density

也非常难

### 从样本判别一个分布Uniform?

更Universal的问题, 有多少样本, 我们能判别两个分布一样? 或者一个是Uniform的

* KL Divergence需要所有样本
  * 如果用的Distance不太好, 则不可能
* L2 distance 
  * 判断两个样本重合概率!! Uniform分布重合概率平均而言最小! 
  * 不用那么多样本就能判断
* L1 distance
* Wasserstein Distance
  * Lifchiz连续的度量?!
  * 为何它能使训练稳定?!
  * 核心思想是二分图匹配
* High Dimension W-Dis?
  * 高维空间中的W-Dis是学不出来的!! 
  * 需要Exp级别的样本量.



### GAN~Game Theory

GAN as 0和博弈游戏

min G max D



