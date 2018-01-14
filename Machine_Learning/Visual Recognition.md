# Visual Recognition

[TOC]

如何表示呢？

* Bounding box — 框住人 狗 猫 车等
* Points — 一般称为Semantic Segmentation，下一讲讲

mmAP

## **评价标准（Detection Theory）**

* 真正框与检测框 Overlap>0.5 认为是True
  * True Positive 
  * False Positive
* Precision=TP/(TP+FP)
* Recall=TP/(TP+FN) 
* **AP**=$\int$  Precision dRecall 



![Wiki](https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Precisionrecall.svg/440px-Precisionrecall.svg.pngg)

# 传统方法(1999-2001)

* Sliding Window: 滑动窗 模式匹配，Scale 
* 处理时作级联判别Filter链 (Boosting)
*  Coarse-> Refine 迅速reject大量非人脸框图。

两方面工作

* Feature
  * HoG：
    * Normalize->
    * 上梯度算子->得到边缘Feature
* Classifier
  * SVM

评价

* 计算速度相对快！CPU即可，GPU加速因子很小
* 有限数据情况下，结果Reasonable；大数据泛化不太好
* Debug方便好分析结果。

# DeepLearning Method

 Fully Convolution Network 出现

* Intuition 计算复用！
* 邻接的框 可能计算结果很相近 ，Convolution

两大主线

* One stage detector
  * 提取特征-> 分类(T/F)->回归 localize(BBox)
  * 关键词 Anchor
* Two stage 
  * Proposal and Refine 
  * 两步骤
  * F RCNN系列

## One Stage method

### DenseBox

* 用训练好的CNN作Feature Extraction
* 作UpSampling  ( 弥补 CNN downsample的效果)
* 输出 4+1 (框的x,y,w,h, 是否)
* Supervised learning : 
  * 训练用一些Label，用有框有标记的图片，输出最后一层的(x,y,w,h,B)数据 
    * 在B维度计算分类误差 (Classifiction loss)
    * 在(x,y,w,h)计算框的L2误差 (Regression Loss)
  * 用有无框来训练，用
  * **Caveat！**Lost设计 注意到L2 正比于Scale，大脸的框贡献更大！
    * UnitBox-> $IoU Loss$  ln(Intersection / Union Area)
    * Invariant to scale
    * 不同方向共同优化
  * **Bugs** 一个点可能有许多的物框 覆盖-> 导致其目标function非单值不好定义
    * SSD想解决这个问题
  * Caveat！！多个Node可能Detect到相同的点

### YOLO： You only look once

固定大小的Grid

* 输出：20+2*(4+1) 
* 20维 0 1 是否属于该类 2类的
* Feature：使用FC层！沟通各个位置信息
  * 好处：全局信息沟通，更多的context信息
  * 坏处：不同于CNN层 输入图片大小需要固定 否则参数维度不对

### SSD (Single Shot Multibox Detector)

* **Anchor** :每个点有一些预设框： 3 scale * 3 Aspect ratio
  * 使得
* **Divide and Conquer**: 不同层出不同物体：期望小物体在前面输出小物体，后面输出大物体
  * Conv3 Conv4 Conv5 Receptive Field 越来越大，但Down sample越来越大，越发不清楚
  * 前面层设置一些输出 一些小物体的目标
  * 不过前面的Semantic 信息不那么多
  * **Solution**:  
  * Caveat: 该结构依赖于VGG，不好调整到Resnet上
  * VGG vs Resnet
    * VGG 当时Train的方法是不断加层，独立训练的。不同层的Weight差异很大
    * Resnet 是End to End一下Train的，各层很统一

**Reshape结构-目前比较通用的**

* Feature map变小再变大
  * 前面大Feature map的信息卷积之后传过来
  * Upsample
  * 语义与Spatial 都有的Tradeoff方案～

### RON

* 解决 pos ／ Neg imbalance（分类结果大多是Neg 少量是Pos）
  * 先作正负2分类
  * 再作类别分类

## 2-stage Detection



### RCNN

* 传统方法Propose框图
  * — Faster RCNN改变了这一点，用GPU上CNN处理 Propose框图
* 每个框作Resize 方便后面作FC层
  * — 但Resize很慢，Fast RCNN改正了这一点
* 对每个框图独立作CNN feature extraction 
* 方法

RFCN

大多数改进都在作提速

# Problems

* ​
* Detection in Crowd
* In video
  * 多frame如何做的更好

# Keypoint检测

检测人身上的骨架 手 鼻子等

各个模型通用的要点：

* 中间层就需要加一些监督信号！
* 希望前面检测出来一些信息，帮助后续信息
* 需要用Reshape Hourglass结构 先downsample 再upsample

Associative Embedding

Multiperson Skeleton

