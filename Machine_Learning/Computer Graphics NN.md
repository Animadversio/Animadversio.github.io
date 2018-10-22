## Computer Graphics 基本问题

Graphics  and  CV 是一件事的两个方向 语义-图像/图像-语义

### Rendering

模型-物理->图片

应用: 

* 动画电影: 能渲染出来就好 怎么fancy怎么来
* 游戏: 要实时渲染! 要保证fps

关键词: Ray tracing, Photon mapping



### 3D modeling

3D建模, 从实物->计算机可处理的数据模型

建模空间复杂曲面 (Complex), 体

关键词: Mesh, grid, geometry, voxel, point cloud, 三角剖分

### Visual media retouching

图像再处理, 图片-图片

有大量的变换, 人手写的公式不一定普适

## Neural Network Application

### Monto Carlo Ray tracing

* Rendering 的一种方法, 从物理空间 $\{人眼,光源,物理空间,表面属性\}$ 生成焦平面上的图像
* 相当于从相机发送光子追踪其结果
* Monto Carlo是一种实现算法, 很难直接去建模概率, 只用去多次试验sampling即可
* 迭代次数越多 越好! 越光滑

**NN rendering**? 

* 将上述MC过程看作denoising过程, 噪声逐渐降低
* CNN for denoising Monte Carlo Rendering
* 用CNN去fit denoise 核
* 计算机图形学中 NN的好处是不缺乏数据!! Graphics自己就能生成图片进行训练



### Real time rendering

$$
L_e() + \int_\Omega f_r() L_i()(n\cdot\omega_i)d\omega
$$

https://en.wikipedia.org/wiki/Rendering_equation

BRDF function

**NN shading**?

* 能大大加速上述Evaluation
* ​



### Shape understanding

* NN shape understanding 就需要先找到一个3D模型的可接受表示(定长表示)
  * Point Cloud
  * Mesh Representation很tricky但也是key!



### Visual Retouching/ Stylization

* Photo修正问题 一个问题是数据量
  * 数码相机的像素本身太高, 很难处理. 不好直接resize
  * 可以学一个Map
* ​
  * ​

### NN 3D face

逆渲染问题

* ​

人脸3D重建问题好做在于

* Strong Prior 
  * shape变化不会那么大!
  * Albedo
  * Expression
  * BRDF也很好确定
* 曲面本身比较Smooth, 颜色也揭示了许多曲面变化信息(皱纹)
* shape 大小很invariant

### **3D face prior distribution **

* 人脸关键点 3D情形 关键点较多
  *  取了50000个关键点, (3*50000个数据)
* 对1000张脸, 150000个系数的向量们 PCA 
* 前5个特征值对应几个主要的变动维度! 前五个变动维度都有语义信息
  * 注意到皱纹一般会被PCA干掉
* 表情同样可以PCA~
* 因此有了这种比较好的基 用几百个参数最多就能定下来一个人脸了. 

$$
S=\bar S + A_{id} \alpha_{id} + A_{exp} \alpha_{exp}
$$

* Prior的好处就是找到了人脸空间的一组比较好的基底



###**Face Fitting**

有了上述基底, 可以给定一张人脸去Fit

* Optimization 
* Parameters
* Objective
  * 全局Loss
  * 关键点Loss
  * Regularization
* 可以用梯度下降优化Fit此

**NN fitting**? 

* 训练NN去更快的解上述优化问题 (现在也能解了…..)
* 很难直接Train 系数语义信息比较强!!
* 而且无法Account 皱纹等等
* Solution
  * ​



**NN fitting without prior**

用网络来学习先验进行估算. 



## CG application In CV



CG可以提供大量的数据(CG Synthesis for Ground Truth)

* Augmentation很好做! 可以多渲染出来一些图像
  - 改一改参数就能造出无穷的数据
  - 但需要渲染结果足够逼真才行!! 
* 游戏中解析渲染引擎可以得到 Semantic Segmentation的数据
* 从人的渲染去解析人的姿势
* ——这类任务核心是去破解渲染
* ​





