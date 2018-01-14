# Neural Style transfer

元培物理 王彬旭 1300017619

# 问题描述

绘画风格迁移，直白的说就是让一张图片看起来像是某风格画家画的，这个问题在直观上很好理解，但其数学表述并不显明。

直观上可以理解，表明人能根据图像视觉特征，分辨不同画家艺术风格(Discriminate)并有对画进行分类标签的能力的(Classify and Labelling)。数学形式不清晰，带来的更深层问题在于这个问题未良定义，也没有直观唯一解，而解的好坏是由人的审美来判断的[^1]。不过由于我们的是 人看来像是相同风格的图片，那就应该从人所认为的标志着图像风格的视觉要素入手。

风格迁移这一问题能被提出来，其隐含的就是，对人来说图像的**内容**与**风格**(Content and Style)可以分开的，前者直白的说就是“画了什么”，学术的说是图像的语义内容(Semantic Content). 后者则是“怎么画的”，一般的我们区分不同绘画风格所用的要素包括：线条笔触、所用色彩类型等等。因此更明了的表述风格迁移问题就是，保留内容图像的语义内容情况下，使用风格图像的色彩分布(Color Statistics)以及纹理(Texture)等特征。

[^1]: 存在更复杂的评价方式， 参见 Jing, Y., Yang, Y., Feng, Z., Ye, J., & Song, M. (2017). Neural Style Transfer: A Review. *arXiv preprint arXiv:1705.04058*. 5

# 方法综述

上述问题可以用优化的语言形式的表达，
$$
\hat{x}=arg\min_x E{total}(x) = arg\min_x \alpha E{c}(x, x_c) + \beta E_s(x, x_s)+ \gamma \Gamma(x)
$$
式中s代表风格(style)，c代表内容(content)，$x,x_c,x_s$为待生成图片以及内容、风格图片，最后一项为对生成图像本身的正则项，用于增加平滑性等。因而后续问题就是如何定义这两个损失函数，以及正则项。

而目前的图像风格迁移算法主要分为两大类：图片迭代算法，直接求解此优化问题，也称慢算法；模型迭代算法，训练前馈生成网络间接解决该问题，也称快算法。

## 图片迭代算法(Descriptive Neural Methods Based On Image Iteration)

这一节以原始的Gatys[^2]文章中的算法为样本，介绍这类算法，及一个变种。

在之前的纹理生成领域中，一个认识是纹理信息被记录在局部图像块的各种统计量中(矩，关联函数，)，通常使用手工选择的局域统计量来概括纹理信息。因而使待生成图片的局域统计量逼近纹理图像即可生成类似的纹理。而Gatys算法核心的观察是，已经训练好用于图片分类的深度卷积神经网络(dCNN)，是一个泛用型的多层级特征提取器，其前几层的卷积核对应的就是局域的图像信息，即纹理。因而相比于手工选择的统计量更能概括局部特征。所以直观的讲使得训练好的dCNN对风格图片与待生成图片的响应(即特征地图 feature map) 在前几层上相近，那么图像内容及纹理也会相似。他们的算法结果很有力证明了这一直观。

另一个重要的发现是，dCNN中不同卷积核生成$C^l$个通道的特征地图，通过匹配不同通道间的Gram矩阵$G^l\in \mathbb{R}^{C^l\times C^l}$，可以使生成图片的风格接近原图。下面详细介绍这一结果。图片$x, x_c, x_s$张量形状为$(C_i,H_i,W_i)$, $i\in{_,s,c}$ (风格图片与内容图片大小不需要一致，输入图片通常与内容图片同尺寸，下省略标记$i$)。 该张量经过dCNN的卷积层形状变为$(C_i^l,H_i^l,W_i^l)$的特征地图，$C_i^l$也即该层的卷积核数目。将特征地图的空间维向量化，长为$N^l=W^l\times H^l$，则有2维特征地图矩阵$F^l\in\mathbb{R}^{C^l \times N^l}$。点乘缩合空间维得到Gram矩阵$G^l_{ij}=\sum_k F^l_{ik}F^l_{jk}$。风格损失函数即，
$$
E^l_s(x, x_s)=\frac{1}{(2C^lN^l)^2}\|G^l-G^l_c\|_F^2=\frac{1}{(2C^lN^l)^2}\sum_{i,j}^{C_l}(G^l_{ij}-G^l_{ij,c})^2
$$

$$
E_s(x,x_s)=\sum_l^n w_l E^l_s(x, x_s)
$$

其中以$(2C^lN^l)^2$作为归一化，不同层间权重可根据需要自行定义。

内容损失函数，定义为特征空间上特征地图间的距离。
$$
E^l_c(x, x_c)=\frac{1}{2}\sum_i^{C_l}\sum_k^{N_l}(F^l_{ik}-F^l_{ik,c})^2
$$
注意到这两个损失函数都很好计算相对于特征地图元素$F^l_{ik}$的偏导，
$$
\frac{\partial E^l_c}{\partial F^l_{ik}}=F^l_{ik}-F^l_{ik,c}
$$

$$
\frac{\partial E^l_s}{\partial F^l_{ik}}=\frac{1}{(C^lN^l)^2}\sum_j(G^l_{ij}-G^l_{ij,s})F^l_{jk}
$$

因而可以用CNN现成的反传算法，计算图片每个像素的误差量以及修改量。

那么怎样理解Gram矩阵的含义呢？考虑特征地图$F^l_{ik}$，$l$层$k$位置的激活相当于图片局部的一个描述性统计量(Descriptive Statistics)。例如dCNN第一个卷积层的激活是图片局域与不同卷积核的点乘，即局部的线性统计量。而更高层的dCNN则是图片局域的一个非线性统计量。$F^l_{. k}$即k位置的描述统计量向量，根据$l$不同，局域块(神经元的感受野)大小不同。不同位置的统计量向量$F^l_{. k}$，可视为从一个分布空间中作采样的结果。统计中有，对于一个随机向量$n$个样本的样本矩阵$X$, 行向量$X_{.,k}$为一个样本, $\bar{X}$为样本均值行向量，$1$为全1列向量，则协方差矩阵记作
$$
Cov(X)=\frac1n (X-1\bar{X})^T(X-1\bar{X})=\frac1n X^TX - \bar{X}^T\bar{X}
$$

$$
G(X)=X^TX=nCov(X)+\bar{X}^T\bar{X}
$$

因而Gram矩阵，包含了各个统计量在此多维分布中的相关及自身均值方差的信息。因此，粗略的说，匹配Gram矩阵相当于匹配局部图像的特征$F^l_{. k}$分布。

根据[^3]，修改下形式，可以发现逼近Gram矩阵等价于最小化两个多元分布之间使用多项式核的最大平均偏差MMD(Maximum Mean Discrepency)。特征空间上的$MMD$定义为
$$
MMD(X,Y)^2=\|E\phi(x)-E\phi(y)\|^2=\|\frac 1n \sum_i\phi(x_i)-\frac 1m \sum_j\phi(y_j)\|^2 \\ 
=\frac 1{n^2}\sum_{ij}\phi(x_i)^T\phi(x_j)+\frac 1{m^2}\sum_{ij}\phi(y_i)^T\phi(y_j)-\frac 2{nm}\sum_{ij}\phi(x_i)^T\phi(y_j)\\
=\frac 1{n^2}\sum_{ij}\kappa(x_i,x_j)+\frac 1{m^2}\sum_{ij}\kappa(y_i,y_j)-\frac 2{nm}\sum_{ij}\kappa(x_i,y_j)
$$
其中$\phi(.)$ 是显示定义的从样本到特征空间的映射，再用特征空间的内积诱导度量。$\kappa(.,.)$是核函数，隐式定义特征映射与特征空间上的内积与度量。

而Gram矩阵，以行向量$f_k=F^l_{. k}, s_k=F^l_{. k,s}$代指图片局域统计量向量，则
$$
\|G^l-G^l_c\|_F^2=\sum_{jk}\kappa(f_j,f_k)+\kappa(s_j,s_k)-2\kappa(f_j,s_k)
$$
其中$\kappa(x,y)=(y^Tx)^2$为多项式核函数。在这个意义上，我们可以将Gram矩阵匹配这一想法放到更广的在核空间上最小化最大平均偏差，以匹配两个分布的框架中。并可以尝试其他核函数[^3]。

而定义了损失函数即可用非线性优化方法求解，当前最常用的就是 L-BFGS 。可以从白噪声图片或者内容图片本身开始，逐个改变像素来匹配原图与风格图片的Gram矩阵。

[^2]: Gatys, L., Ecker, A. S., & Bethge, M. (2015). Texture synthesis using convolutional neural networks. In *Advances in Neural Information Processing Systems* (pp. 262-270).
[^3]: Li, Y., Wang, N., Liu, J., & Hou, X. (2017). Demystifying neural style transfer. *arXiv preprint arXiv:1701.01036*.

## 模型迭代算法(Generative Neural Methods Based On Model Iteration)

另一种思路即使用一个前馈网络来生成图片(Neural generative model)，提前训练一个深度网络使得在大量训练集上述损失函数最小化，那么在测试图片上可以仅通过一次前馈输出达到风格迁移的效果。下面参照文章[^4]，简单介绍该算法。

文中所谓知觉损失函数(Perceptual Lose)并不神奇，他们的思路与Gatys[^2] 相同，即在超大数据集上训练好的dCNN可以作为特征提取器，因此比较dCNN前几层的特征地图及其统计量如Gram矩阵，即可检查生成图片的局域特征与风格图片符合的情况。

![@算法示意图](/Users/binxu/Documents/Markdownimg/8A99F075-5699-49DA-BFFF-D3B50F790B91.png)

事实上他们的损失函数与Gatys[^2] 完全相同。但两者优化对象不同，将所要训练的dCNN抽象的记为映射$f_W$，则网络训练时优化的问题是
$$
W=arg\min_W \mathbb{E}_{y_{c,i}}[\alpha E_c(f_W(y_{c,i}),y_{c,i})+\beta E_s(f_W(y_{c,i}),y_s)]
$$
即对于同一风格图片$f_s$, 从训练集中取大量不同 $f_{c,i}$ ，考察其生成图片$\hat{y}=f_W(y_{c,i})$ 相对于$f_{c,i},f_s$的损失。以此损失作为生成网络的损失函数，对$W$ 作优化使得训练集上损失函数最小。算法期望可以生成网络可以将生成风格图片的能力泛化到其他未见过的输入上。

两种算法相比较，图像迭代算法是$arg\min_{\hat{y}}$，而模型迭代算法是优化生成$\hat{y}$ 的映射$arg\min_W $，实践结果发现在大训练集上得到的$f_W$ 网络也很容易风格化其他图像。后者利用已有dCNN风格化一张图片的确远远快于前者直接求解一个复杂函数的优化问题。（事实上优化的每一步都需要前传与后传一次CNN，相差200-1000倍的速度并不奇怪。）然而在庞大的训练图像集(如COCO)上训练dCNN十分耗时，通常是没有显卡的一般人做不到的，因此模型迭代算法对能迁移的风格有了很大的限制，适合对选定的风格作实时风格化。而对于个人用户前面的“慢算法”更适用。

[^4]: Johnson, J., Alahi, A., & Fei-Fei, L. (2016, October). Perceptual losses for real-time style transfer and super-resolution. In *European Conference on Computer Vision* (pp. 694-711). Springer International Publishing.

# 算法实现

在此项目使用PyTorch框架作，参考链接[^5] 的教程。

项目采用的是Gatys[^2] 中的方法，即第二节中图片迭代算法。使用训练好的VGG网络的前五个卷积层输出作为提取出的风格特征，与待优化图片的特征地图作Gram矩阵匹配。使用VGG网络第四个卷积层输出作为图像内容的代表，直接作特征地图逼近。使用 PyTorch的L-BFGS优化器作优化。以内容图片作为初值进行优化。算法输入为内容$x_c$与风格图片$x_s$，大小任意，输出为以风格图片的纹理以及色彩渲染过的内容图片，大小与之相等。

本项目主要改进是，修改了其模型搭建子程序的一个bug，使得算法可以处理不同大小的内容与风格图片[^6]。使用 Intel core i5 CPU 训练，600*450尺寸三通道的风格图片约1小时训练完成。算法输出效果如下图。

![VanGogh_Pei_in_Moonlight](/Users/binxu/Documents/Style Trans/Life img/Pei_in_Moonlight_Cut.jpeg)

![River_Light_3_4](/Users/binxu/Documents/Style Trans/Life img/River_Light_3_4.jpeg)

![VanGogh_Pei_in_Moonlight](/Users/binxu/Documents/Style Trans/Output/VanGogh_Pei_in_Moonlight.jpg)



目前发现的问题包括：

- Gatys的风格迁移算法是内容不敏感的，即渲染纹理时不管背景的图片内容，因此用纹理图片作人像渲染时会有较差的效果。
- Gatys的算法会匹配输出图片的颜色与风格图片一致，因而作人像渲染时色彩很不和谐。可以使用保留颜色的算法[^7]来解决这一问题。





[^5]: Neural Transfer with PyTorch http://pytorch.org/tutorials/advanced/neural_style_tutorial.html
[^6]: 教程[^5]的实现无法处理不同大小的风格与内容图片，主要原因是模型搭建中，计算输入图片$x_s,x_c$ 的特征地图（定值），使用的是新搭建的模型，而该模型加入了Gram矩阵误差与特征地图误差计算模块，因此在$shape(x_s)\neq shape(x_c)$ 时两者特征地图尺寸不匹配，则会报错。项目的改进在代码中标出。
[^7]: Gatys, L. A., Bethge, M., Hertzmann, A., & Shechtman, E. (2016). Preserving color in neural artistic style transfer. *arXiv preprint arXiv:1606.05897*.

