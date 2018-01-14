行人追踪, 动物追踪, 细胞追踪……

客体追踪问题是其他基本CV问题的组合! 

* Appearance特征提取, 识别比较
  * CNN
* Detection检查是否有物体/ 输出框
* Alignment 多个物体之间的匹配, 连路径

各个组分之间相互弥补! 一个做的强一些 其他组分可以弱一点



# Optical Flow

最经典的估计运动的方法, 光流算法? 上百种算法

* But, Motion Field不总等于Optical Flow! 
* 理发师的旋转灯 是著名的反例 有Ambiguity 平动还是旋转



### KLT Tracker:

1981年提出, 十分成熟, OpenCV就有

* 寻找Corner Feature Point
* Calculate Optical Flow $I(x,y,t)=I(x+dx,y+dy,t+dt)$  
* 约束?
  * ​

## Optical Flow with CNN

FlowNet 2.0

这个问题人可以用计算机图形学Simulation! 产生大量数据! 

Note: 思想很有趣! 我们可以用简单算法方便的计算出一个正映射$f(I_1,V)\mapsto I_2$, 生成大量的$\{I_1,I_2,V\}$, 去用机器学习逆映射. $f^{-1}(I_1,I_2)\mapsto V$. 

* FlowNetS
  * 两个图片一起一通卷
  * 最后有个上采样, Deconv1
* FlowNetC: Correlation操作!! 
  * 关键不同: 两个相同大小的Feature Map, 用一个Map的Channel维度作为核去卷积另一个Map
* Con! 
  * 不包含客体识别, 算的是点对点的映射. (最新的Optical Flow可以与Semantic Segmentation结合)
  * Occlusion
  * 很难长时间跟踪



# Single Object Tracking

问题描述: 

* 短时间跟踪: 从第一帧给个框. 
* Causality: Online 因此不能预知未来, 只能看历史



## Correlation Filter

相关滤波 基本数学原理: 

Cross Correlation $f*g(\tau)=\int f(t)g(t+\tau)dt$ 

与Convolution很像! 只是相差一个翻转

卷积定理:时域卷积等于频域乘法! 

 $f=g*h\rightarrow F(f)=F(g)F(h)$ 于是在频域上计算复杂度 Scaling是$O(nlog(n))$ 而非$O(n^2)$ 快得多!

基本算法非常快! 600fps

大多是最后求解一个优化问题! 

### Tracking by Detection: Discriminate Based:

提出一个框, 判定是不是对象. 最后是一个Detection问题. 

### Kernalized Correlation Filter

用循环矩阵性质(, 循环矩阵与循环Convolution等价的)! 数学形式上Close form解

很有趣的数学问题! 有显示解

程序实现可以很短

### Deep KCF



用了更多的CNN提特征(比如VGG提几层Feature map) 高层次Feature

### Convolution Operator Tracker

做的越来越慢!! 1FPS

还容易过拟合. 

## Deep Learning

端到端的模型, 全是Deep Network



### FramesFCN



## BenchMark 体系

VOT

OTB

# Multi Object Tracking

* 一般非单个物体, 不提前给定, 可以增减
* 长时间
* 非Causality, 非实时, 可以用历史与未来信息

大多是Tracking by Detection!每幅图整个画面Detect物体 

核心问题是Alignment.

## Alignment

**Features**

* IOU 重合面积大小
  * Distance
* Motion Modeling: Kalman Filter
  * 可以最好的预测一个线性动力系统的接下来的状态! 有预测方便
* Appearance Features
  * 用CNN Feature map. 或者手动特征(Image Statistics)

整合这几种Feature, 作判断! 



## Association as optimization

* Local解法: 二分图匹配
  * Hungarian Method
* Global解法: 
  * Clustering
  * As Nework flow, Max flow Min Cut Algorithm

模型是用上述Feature作为C给网络的边赋值. 在网络上解最短路, 从物体出现到物体消失. 

# Challenge

## Fast Moving

如果一个物体快门时间内位移超过其长度



Optical