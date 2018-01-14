

人脸识别

* 应用
  * 1-1: 刷脸支付 刷脸解锁
  * 1-N: 识别名字, 逃犯追踪
  * N-N: 照片聚类, 标记相同人脸
* 挑战
  * 遮挡 墨镜和口罩对

人的识别

* 不只是脸
* 应用
  * 跨摄像头进行监控? 连续监测. 抓小偷 逃犯
  * 注意到监控摄像头不能分辨率太高! 否则要登记. 一般是看不清人脸的
* 挑战
  * 遮挡
  * 光线
  * 衣服改变

## Deep Metric Learning

### Classification~ Metric Learning

通常的Classification

CNN->Pooling/FC->Softmax输出

* 人脸识别作为Classifcation要求的是CLass 已经确定了!!! 
* Closed Work, 并不能任意扩展识别新人脸

### Metric Learning

* $d(f(x),f(y))$  
* 如何使得相似的人 出来的f(x)就相似, 不同的人出来的f(x)就不同. 
* 相当于找一个embedding, 使其上Metric 接近人识别的空间的

加入一个Metric Loss Function! $\delta(A,B)$ 相当于人脸标记空间上的Metric 离散度量
$$
\mathcal L = \delta(A,B)\|f(I_A)-f(I_B)\|_2+ (1-\delta(A,B))(\alpha-\|f(I_A)-f(I_B)\|_2)
$$
使得相同对象的不同Image 接近, 

Triplet Loss ($C_N^3$ )
$$
\mathcal L=\sum (\|f(I_A)-f(I_{A'})\|_2 - \|f(I_A)-f(I_B)\|_2 +\alpha)_+
$$
相比于2元组, 提升很明显, 4元组Quadrapole Loss亦可, 但注意Pole越多样本越多
$$
\mathcal L=\sum (\|f(I_A)-f(I_{A'})\|_2 - \|f(I_A)-f(I_B)\|_2 +\alpha)_+ + \sum (\|f(I_A)-f(I_{A'})\|_2 - \|f(I_C)-f(I_B)\|_2 +\beta)_+ 
$$


### Hard Sample Mining

如何找到困难的, 不好区分的人脸三元组, 
$$
\mathcal L=\sum (max_{A'}\|f(I_A)-f(I_{A'})\|_2 - min_B\|f(I_A)-f(I_B)\|_2 +\alpha)_+
$$
(当然用Softmax/Weighted Average也可以)

所有图片在Feature空间的Distance Matrix. 同一个人的排在一块, 能形成一个 分块小矩阵. 于是可以去



### Margin Sample Mining

$$
\mathcal L=\sum (max_{A,A'}\|f(I_A)-f(I_{A'})\|_2 - min_{B,C}\|f(I_A)-f(I_B)\|_2 +\alpha)_+
$$



### Distill

* 刷比赛时网络会很大很复杂, 应用要用小的网络! 
* 用Teacher Network 教Student Nework, 逼近Teacher Network的最后层输出
* Student中间层

### Mutual Learning

* 学生网络之间相互学习, Deep Mutual Learning, 
* 减少最后输出一层的Distance/ KL Divergence
  * 网络做Ensemble肯定更好! Mutual相当于互相反馈, 学到彼此相似的方面, 减小Noise
* 也能学到一个效果不错的小网络~
* Deep Mutual Metric Learning
  * 让两个Metric Learning相互比较



上述方法在人脸上很好用!! 

## 行人ReIdentify

非常困难! 人都不一定能做到

### Evaluation Criterion

从一溜中推荐最相似的, 排序, 看



### DataSet

* 数据集 CUHK03 通常是某个大学的摄像头 做了bounding Box输出的结果. 



* 不应该整个人直接CNN提取feature
* 应当用局部Feature! 
  * 颜色
  * Texture
* Local Feature From Local Region
  * 切开头身子腿分别训练比较, 然而直接去切容易切错! 
  * 用LSTM, 从上往下过, 训练准确的切分头身腿
  * LSTM来预测下一个次Attention位置! 
  * 但不前看不太成功

2015年Top1还是40%左右正确率 16-17年现在已经99%多了, 可以实用化了! 

### Alignment

* Unsupervised Part Detection 
* 发现Feature map上激活最大的部分都是集中在身体的一部分! 头身子 腿等
* 因此只要做聚类 再出Bounding Box即可
  * ROI pooling, Part 和Global Loss一起做

**AlignedReID**

http://export.arxiv.org/pdf/1711.08184

* 计算各个part distance Matrix
* 做一条最佳匹配路径
* ​

人脸识别, 物品Recognition可能超过人脸. Surpassing



### Re-Ranking技术

有了最初的结果之后, 重新排序使之结果更稳定. 可以很方便的加在最后输出Ranking处 加点还比较明显. 

Smoothed Manifold

* Supervised Smoothed Manifold
  * 有了一个SImilarity Matrix在加权图上做随机游动 $P_{ij}=$
* K-reciprocal Encoding
  * ​
  * 【效果很好！

### Pose Estimation

加入骨架监测?出了14个骨架点之后 再出不同部分框

### Semantic Attributes

* 不再是简单的图像对比, 加入语义信息, 训练识别一个人的Attribute
  * 性别, 衣服, 鞋子, …..
  * 然而Attribute通常很不Balance!! 很Sparse
  * 加入Attribute Weighted Loss
  * ​

【Metric Learning 来做视觉Encoding？ 

