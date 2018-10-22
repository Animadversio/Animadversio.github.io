---
typora-root-url: ../Machine_Learning
---

Capsule Network
===========



一组对立与统一的量: 不变性Invariance 与 同变性Equivariance

* 存在不随着位置改变
* 位置信息也需要被encode



### Transforming auto encoders
http://www.cs.toronto.edu/~fritz/absps/transauto6.pdf
2012年工作: 

让AE学习如何生成 平移距离 平移量之后的图片
即让Compressed code中编码把x,y平移信息. 

Semantic Coding: 让AE generate一个压缩Code, 在Code上加入$\Delta x.\Delta y$ 让他输出一个

Capsule 就是一个有10个 input端20个输出端, 中间加入additional input

### Generalized Capsule
使每个单元输出 是一个可理解的property




**CapsNet**: 

https://arxiv.org/pdf/1710.09829.pdf
2017 11

* Squashing Function: 激活饱和函数
	* $v_j=\|\|$
* Dynamic routing: 
	* feedforward 中每一层的gate可以动态调整
	* 每次
	* Dynamic routing 在局部Iterate几次形成Weight . 局部routing在一个很大的
	* Winner Take all? 每次挑选某几个channel输出?
	* ​
* 





