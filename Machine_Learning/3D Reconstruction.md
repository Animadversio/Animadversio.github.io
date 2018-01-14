# 3D Vision

视觉如何得到3D信息?/ Depth perception

人有双眼视觉

双目视觉和Attention机制很有关系 : 

单眼视觉, 背景中的图像也能看清楚; 双眼视觉, Focus point处很Saliant, 背景自然会虚化! 





Algorithm

* Shape from motion (无源)
  * 三角测距: 观察者自身移动时 视差Disparity可以用于measure距离! 
  * 反比于Disparity, 近处估计较好, 远处较差! 
  * ~ 如果是刚性物体转个圈, 也可以重建出来
  * ~ 星系测距
  * ~ 因此扫近处的物品比较好. 
  * Con: 对于Texture较少 Feature较少的
* Flying time measure (有源)
  * 看光的飞行时间. 
  * 可以用相位测量, 精确到1cm -1mm精度
  * 无人车的激光雷达, 可以扫一个维度
  * Con: 阳光下会挂…..
* Shape from shading
  * 明暗变化
  * 亮度指数反比于 材料厚度
* 通过几张图像得到3D模型

## Epipolar Stereo

**Epipolar Constraint**

Steoreo Geometry: 

Epipolar line: 另一个观察者在, 本观察者

Rectification: 

每个点

神奇论文 : **Building Rome in One Day**  从图片来重建 对象

OpenCV中有现成的数据库可以搞~

## Traditional Surface Reconstruction

经典算法, 实体每点有一个法向, 相当于实体内部有一个示性函数, 可以在边界处梯度是法向. 最后做一个优化问题

Poisson Reconstruction https://en.wikipedia.org/wiki/Geometry_processing#Poisson_reconstruction_from_surface_points_to_mesh

## Active Sensing

Active sensor. 可以主动扫描物品, 得到每点深度信息



## Short Baseline Stereo

* ~ 对焦过程跟测距 很相关



## Shape from Shading

* Lambertian Law: 从亮度得到光源与面法向的信息
  * $I\propto <n,s>$   
* 假设发射光是各向同性的
* Bas-relief ambiguity — 浮雕的深度知觉的歧义
  * 由于只依赖法向 

注意: 

* 人眼和相机的 Dynamic range很不一样! 
* 阳光下, 黑屋子里, $10^7$ 个数量级范围, 人都能看清
* 但手机屏幕显示器, 最多是$10^2 , 10^3$个range

Data term + Shape prior (Fitting Error + Regularization term)

作优化

指纹识别: 通过光源和阴影 $50\mu m$ 很好用Solve很准

## Shape from texture

对桌布, 布料, 可以通过表面的纹理变化 解出来逐点法向, 然后

## Depth from focus

Focus 离远的比较虚, 能get到~

--------------

# Neural Network



Shape from prior!  Fan Haoqiang

* ShapeNet Dataset
  * 整出来20W个shape object
* 让Network怎么学一个三维表示?
  * Key: 怎么三维表示一个实体?
  * Volume Ocuppancy?: Predict per voxel
    * Fail
  * 3D Representation?
    * Point Set of Surface! 
    * 注意最后要sort下set才能算loss! 
* 然后训出来就好啦! 
  * 能学会 Texture, Shading inference



**Dispnet**, **Flownet** : 暴力给两张图, 卷一下出Depth! 

## Stereo

Stereo Matching Cost CNN  Bengio的工作

NCC: Normalized Cross Correlation

看双眼视觉



## MRF Based Stereo

Graphic Model 解Markov Random Field

Message passing机制: 



