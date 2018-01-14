# Text Recognition



问题 （通常是自然场景Scene Text 下）

* 检测Detection ：是否有文字
* 识别Recognition： 数字化



Problem； 与OCR比较

* 背景
* 字体 大小
* 颜色
* 排版多样Layout
* 扭曲



* 背景图案可能跟文字很像！！窗子 与 田



* 好处，文字形状相对确定，有很好的先验Prior
* 一般不会太拥挤，并排排列

# Traditional Method

**MSER (Maximum Stable Extremal Region) 2010**

* Algorithm
  * 假设 文字是自然场景中的 连通像素集
  * 提出候选区域
  * 用SVM强分类器筛选 (分类器可以换各种)
* Pro
  * 很容易并行处理，十分快！
  * Scale不敏感！多尺度同时能找到
* Bug
  * 分类器只能匹配正立的文字



**SWT (Stroke Width transform)**

* 笔画宽度比较连续，取了边缘之后可以很好的找笔画的法向
* 也只能找水平的文字



**识别——Top down and bottom-up**

* 基本想法是扫描窗
* ！可能把两个字之间的框识别为文字。



**Label Embedding**

* 图和标签嵌入同一个空间，然后用Nearest Neighburg 作inference
* ​
* ？？？？？？

# Deep Learning Model



Deep Feature：VGG-16

* “OOX”问题：尝试不同切分竖直位置 动态规划出最好的位置
* Deep feature学出来的Feature就跟1234567890差不多
  * 作为Kernel去扫描即可得到可能有文字的点



EAST detection

* 希望通过统一的神经网络来实现这件事——
* 省去中间步骤
* 只要设置不同的目标函数即可



 Gupta et al.. Synthetic Data for Text Localisation in Natural Images. CVPR, 2016.

* 没有样本怎么办！自己去生成自然背景的文字～
* 对自然图片 作块分割，探测其深度，根据深度估计平面法向量，作文字的Transform再贴上去
* 20W图像的800W样本



 Lee et al.. Recursive Recurrent Nets with Attention Modeling for OCR in the Wild. CVPR, 2016.

* Attention	: 不同像素赋予，不同权重



![Deep Direct Regression](https://i2.wp.com/syncedreview.com/wp-content/uploads/2017/10/image-24.png?resize=901%2C381&ssl=1)

 Ghosh et al.. Visual attention models for scene text recognition. 2017. arXiv:1706.01487

ICDAR 2015

MLT multilingual dataset

有先验 特定种类的图片 99.9可对

没有先验大概要70-80