---
layout: post
title: This Week's Learning about Brain 0
author: Binxu Wang
date: '2018-09-01'
use_math: true
comments: true
categories: [科普, neuroscience, machine learning]
tags: [This Week's Learning, Visual Neuroscience, Connectomics, Machine Learning, Geometry]
---


## 题记
一直计划着博士期间定期写一点note把自己最近学到的有趣的, 美妙的东西记下来. 如果读得是一个数学物理的博士, 或者理论神经科学的博士, 那这种Note就像是在数学世界中的探险笔记, 可以叫This week's finding, 大约就是这周看了什么书, 学会了什么数学, 玩儿了什么Model, 发现了什么trick或者math game，做了什么优美的图. (可以参见之前挖出来好些有意思东西的一个站点 [This Week's Finds in Mathematical Physics](http://math.ucr.edu/home/baez/TWF.html) UCR一个数学物理教授坚持了十多年的每周数学笔记) 

不过现实中, 我读的是Neuroscience的博士, 大概只能写learning写不了什么finding了. (而对于Brain一周时间也学不了什么新东西...) 因此, Note的内容就会更庞杂: 一部分是技术性的, 新学会的数学、统计方法、机器学习方法, 也许会有新的实验技术以及相关的物理原理; 另一部分是理念类的，也许有最近听seminar听到的神经或者心理的实验结果，也可能是相关的有趣的哲学讨论。我想我会逐渐发现哪些内容更适合分享, 以及哪些内容写下来对自己以及对读者更有帮助, 经过一段时间的磨合，这个post series应该能形成自己的风格。

在介绍过程中, 我会尽可能强调每个piece of knowledge如何与整体的知识图景联系在一起. 我希望这一切内容能被嵌入一个更广阔的理解脑、理解我们自身的图景之中，希望学过的或将学的东西都能被共通的目标连成一体。我在写作中力求对更广一点的受众发言, 并力求写出每个idea最美最inspiring最摄人心魄的一面。而对于Textbook上很常见的Knowledge不会费太大的力气科普(也许会link上wiki)。另外, 由于知识所限, 而且由于Neuroscience巨大的知识跨度，总会有些涉及的知识(数学、计算机、机器学习、哲学)是我的盲点, 特别是生物事实的表述可能经常不够严谨, 因此欢迎博学的大家跟我讨论为我补充。

Doctor of Philosophy是向着人类知识边界闯荡的"孤独的"旅程, 那么自然需要一本旅行笔记记下旅途中的风景。既是为了把风光铭记在自己心中，也是希望其他人能通过我的眼睛看到我所见到的世界的美. 这一切与PhD是否能毕业, 是否会退学, 是否能发表文章并无关系, 只是纯粹的为了保持对这个世界的好奇. That's why I write this column, to remind myself of the original wonder about the world (esp. the brain). 

> 切勿要求胜利，只应要求有一往无前的勇气。
因为从坚忍不拔的奋斗中，你将为自己带来荣誉。
但更重要的，你将为全人类带来光荣。
----伍鸿熙《黎曼几何初步》前言,1985

So the Journey begins! 

## Feature Visualization 
本周内容首先是一个机器学习的topic, 这个topic与自己最近在Carlos lab有关视觉神经科学的rotation相关。在此简述下机器学习问题与Visual Neuroscience的关系. (想来也真是有趣, 一个原本学物理的人来医学院的生物项目研究机器学习写代码hhh) 

包括视觉在内的感知觉神经科学(Sensory Neuroscience)要研究的就是 刺激是怎样逐步被神经元群体处理, 变换成神经活动表征(Neural representation), 最后又怎么产生了知觉(Perception)，以及之后的行为与决策活动. 秉持着一种Rate Coding的假设, 哺乳类动物(如猴子和你我)的视觉系统中的神经元就可以看成将不同图像转换成动作电位发放率(firing rate)响应的元件。那么一个重要而又经典的问题就是，去寻找最能激发神经元的响应的刺激, 。比如传统的初级视皮层V1的Orientation Tuning, 以及高级视觉区域的具有特定客体识别功能的神经元(如Jennifer Aniston cell)[^1]都是这个提问框架下的著名结果. 

[^1]: 所谓Orientation Tuning就是初级视皮层V1的神经元大多喜欢特定朝向的bar/grating刺激, 而所谓Jennifer Aniston cell就是有个梗说Psychiatrist在病人脑袋里扎到一个神经元, 只对跟J.A.这个明星有关的东西有强烈反应, 无论是名字, 还是她的图片. 

有趣的是对于训练做客体识别任务的深度卷积神经网络(DCNN), 我们也清楚的知道其最后一层的输出神经元就像Jennifer cell一样, 每个神经元只对一类特定的客体兴奋. 也知道第一层的作用是对图片卷积提取局部低级特征, 而中间诸多层正如其名(Hidden Layer)一样, 难以被理解. 所以有了诸多试图理解DCNN(Understand DCNN), 开黑箱(Open Black-Box)的工作. [(参见Stanford的这个Note)](http://cs231n.github.io/understanding-cnn/)

因而去理解生物体视觉阶梯(Visual Hierarchy)中的一个神经元的"功能", 便与理解我们手中另一个黑箱----深度卷积神经网络中一个单元的"功能"十分相似了. 事实上, 深度学习研究者的许多开黑箱方法也借鉴自传统视觉研究(比如画一个人工单元的Tuning Curve, 遮挡视觉刺激看响应变化, 一年多前知道这个方法笑死我了). 而他们针对这个问题开发的诸多方法也能被迁移到视觉研究领域中(如本文涉及的Activation Maximization). 

注意到这里考察的都是单个神经元的功能, 对于多个单元的联合功能, 如Population Code则会更exciting, 更有趣, 我想以后做视觉肯定会涉及到这一主题. 

回到单个神经元编码的研究, 对于上述框架的数学化理解就是, 如果忽略随机性, 每个神经元即一个图像空间$\mathcal I$到响应强度(如Firing Rate)的映射, 即图像空间上的一个非负函数$f:\mathcal I\to R^+$. 图像生活在所有像素自由度组成的超高维空间里(320*320的相片就有90000+个像素自由度), 然而一般的自然图像自由度没有那么高, 我们认为他通常生活在一个嵌入进高维空间的低维流形$\mathcal M$上, 因而为了更快的获得好的高质量的图像, 去理解这个图像流形, 得到其流形坐标表示(Coordinate and Charts)就变得十分重要. 之前曾在会上听不少视觉研究者(如Doris Tsao, Dmitry Chklovski等)认为表示视觉处理可以抽象的看成对图像流形的坐标变换, 也是与这一观点一致的. 

在这个几何图像下, 上述理解视觉神经元功能的诸多方法都可以用数学语言更抽象更统一的表达出来. 所谓Tuning Curve分析就是考察$f$限制在某个低维图像空间(1-2维)上的函数形态; 而寻找这个神经元最喜欢的图像刺激的工作, 就是在做$f$在图像空间上的优化问题(Optimization).  而人们使用了不同的方法**正规化**(Regularization), 其实将图像限制在自然图像流形上, 就是为了使找到/生成的图像更真实自然. 

前两周看的一篇文章[Multifaceted feature visualization](http://www.evolvingai.org/mfv)就是讲如何在寻找CNN中一个Unit(类似神经元)最喜欢的刺激, 特别的他们试图展现出喜欢刺激的不同方面(multifacet), 而不只是一种. 在数学框架中理解, 即如何对一个可能多峰的函数$f$进行优化. 并展现出其每个峰值对应的图像, 基于现有的优化算法, 我们能做的就是, 更精细的进行初始化, 使得不同初始值出发的函数陷入不同的局部极值. 具体的做法在此不再详述, 之后可能会开technical note讲这件事~ 

## Preview: Connectomics Debate
所谓神经连接组学(Connectomics)就是测量神经元之间的连接拓扑，以及测量突触连接的性质, 从而直接获得神经环路/网络结构信息的研究. 方法上, 一般是用电镜扫描组织切片形成2维图像, 然后用算法在计算机上重构3维神经元形态及其连接, 是一个非常需要计算力以及手工工作的大数据工作。

最近几个月(Jun.-Aug.), 个人对Connectomics非常感兴趣, 部分是这里有一个做连接组的年轻教授. 再者就是, 对于像我们做模型间接推断神经网络, 推断神经环路工作机理的人, 能真的看到一个(重构出来的)神经环路结构, 这个吸引力实在太大了! 这些empirical data 或许能很大程度上改变人们对神经环路的图像, 从而让人们做出更靠谱的模型. 而这就是Blue Brain Project工作的方式. 

说远了, 那天见到Carlos跟他聊起连接组, 他笑而不语, 打开youtube指给我一个链接: [Connectomics: Sebastian Seung vs. Tony Movshon, Columbia 2012](https://www.youtube.com/watch?v=q4KrhDZQ088), 用这个Public Debate 提醒我这个领域的争议很大. Tony Movshon是建立NYU神经中心的教授, 老牌的视觉研究者, 曾在NYU的视觉Seminar上见过一面; 而Sebastian Seung是Princeton年轻的教授, 理论物理出身, 曾与我导Tao有一面之缘, 后改做计算神经, 现以他领导的连接组大众科学项目,[Eyewire游戏](https://eyewire.org/explore)出名. 辩论双方都是我仰慕的Neuroscientist, 于是看他们吵架也就非常有兴致了. 事实上, 16年又有一次连接组大辩论[The Great Debate on Connectomics: Anthony Movshon of NYU VS Moritz Helmstaedter of MPI, CNS 2016, ](https://www.youtube.com/watch?v=uSbNRyY2QH0), 反对方还是Movshon老爷子披挂上阵; 支持方是马普所连接组中心的Moritz Helmstaedter, 巧的是前段时间在北大刚听过他的讲座, 所以有幸见过辩论的双方~

上周看了视频, 发现这两次公开辩论的过程非常有趣[^2], 在下一个post里我会试图重构下这些辩论的一些关键证据以及论证(argument), 敬请期待. 

[^2]: 特别是第一次辩论, 两个非从事科研的公共协调人, 总试图让Debate更激烈一点, 而miss了两位Neuroscientist 的一些重要的信息. 可以关注下. 

### 补记
有趣的是，上周五和Tim Holy教授在Happy Hour 聊天, 他指出了另一个他认为更有希望的做连接组的策略, 即Anthony Zador提出的用[基因测序测量连接组(Sequencing Connectomics)](http://zadorlab.cshl.edu/index.html)的做法, 大致的动机是处理全脑的神经元连接的数据量与计算量, 大约只有基因测序的计算量能与之相提并论了, 所以他会想到能否借用基因组的算法处理连接组. Zador那边大致做法是, 如果能找到能跨突触传递的病毒, 并让病毒在其基因序列上记录下沿路经过的各个神经元的信息(某种Cellular Barcode), 那也就在神经网络中trace了一条轨迹. 如果又能同时trace许多条轨迹, 也许就能摸清一个网络的连接结构了. 这部分道听途说, 看过文章后再仔细写. 

最近发现RNA测序带来的海量数据真的是带来了疯狂的可能性. 这么想来花些时间了解下Genetics, 也会很有助益了. 大约会花业余时间看看这个. 以上. 





