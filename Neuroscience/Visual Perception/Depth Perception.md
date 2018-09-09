---
 typora-copy-images-to: ../../Wiki Img
---

Perceiving Depth and Size
========



聂荣臻上中学时的心理测试照片. 在重庆某中学校史馆里

所谓Stereo Vision

【空间知觉，现在最复杂的一个study 跟CV CS关系很巨大！

# Methods

深度知觉必然是一个重构，inference过程，因此需要各种不同cue

**Cue Based Methods**： 





## Oculomotor Cue





## Monocular Cue









注意不同线索适用于不同的深度范围. 



## Shadow





## Binocular Cue

两只眼睛看到的世界（特别是在近处）很不一样！

**Dominant Eye**：

* 双眼产生的整合Perception与某一只眼睛看到的更像，则该眼睛是Dominant的
* 比如
* 某一只眼睛是Dominant会削弱双眼时差 减弱Stereo VIsion
* 立体弱还是很厉害的，

**Strabismus**两只眼睛朝向不一样, 双眼得到的Visual Field 非常不一样. 

* 人小时候都是Misalignment的，小孩子的两只眼睛可以分开动~ 长大到3-4岁大概就会align到一起了

**Amblyopia**: 孩子成长时有一只眼睛比较弱, 则孩子会只用一只眼睛去看世界, 就有些问题.

【对孩子成长有所警觉!!







**Corresponding Retina Points**: 

**Horopter**: 

**Absolute Disparity**:当我们盯住外界的某一个点, 则视场中任何一个点都有了一个双眼视差

* 一般的讲, 双眼视差越大则距离越远. 
* 需要注意两只眼睛不是平行的观看世界的! 是有一个角度共同朝向注视点的. 
* 具体的! 相比于注视点的像(在fovea)，更靠近鼻侧的像是
* 所以交换左右眼的像会有很不一样的视觉的! 并非对称

**Relative Disparity**: 





**产生立体视觉的实验仪器** 双眼分别产生视觉刺激

* Stereoscope: 望远镜一般的双眼分别干涉
* 红绿眼睛: 相对比较简单, 颜色会干扰
* 偏振眼镜
* 双眼快速交替产生不同视觉刺激! 





**The Corresponding Problem**

Q: 双眼信息是怎么匹配的? 在Retina上? V1上怎么能做这种事儿?

**Exp** 双眼给随机点Graph, 在图形上无法匹配, 但可以做出来立体知觉与不同. 也许是在点的亮度层次上进行的匹配~



# Physiology

初级视皮层V1上, 存在对相对视差的选择性Selective的细胞(Disparity Selective Neuron)



**Blake and Hirsch** (Selective Rearing Experiments) 对猫的视力两只眼睛视觉交替剥夺, 于是V1上不会产生视差Selective的细胞





# Perceive Size

Size与Distance是根本上相关的. 【类比天文学中 对星体距离、大小、绝对亮度估计相关

【视觉实验需要报告视角最方便！而非pixel数

**视角**： 

* 例如: 伸直手臂，大拇指宽度大约是2度



(让被试Adaptively调整刺激大小 可以很有趣的了解被试perceive的世界~ )



**Emmert Law**: 利用视觉后效，用红色的○在Retina上Adapt一个区域，然后让被试盯着远处白屏幕看就能看到大的绿色像，近处看就能看到小的绿色像。

Size是被准确的表征在V1上的吗?

【超高分辨率的fMRI有一个问题是，其需要头动范围非常小0.75mm，否则。必须得带牙科学的口套

【扫6多个小时非常疯狂
疯狂的Psychophysics学家啊！！！【

知觉大小会影响V1反应的环大小，特别的报告出来的环大小与视皮层上的相关，`Fang, 2008, Current Biology`





[Cf. ML ](../../Machine_Learning/3D Reconstruction.md)

## Size Illusion



## Infant Depth Illusion

3个月时 孩子就可以双眼Fix在一个物上。



## Shadow perception

7个月能发育出来