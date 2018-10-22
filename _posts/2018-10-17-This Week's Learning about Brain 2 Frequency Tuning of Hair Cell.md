---
layout: post
title: This Week's Learning about Brain 2 Frequency Tuning of Hair Cell
author: Binxu Wang
use_math: true
comments: true
tags: [This Week's Learning, Auditory Neuroscience, Sensory System, Neural Circuit, Biophysics]
---

## 引言: 感觉系统
一直以来我都被这个简单的事实深深震撼: 我们的心智(mind)其实一直都生活在一个密不透风, 不见天日的黑匣子里(Skull), 但因为我们无比强大的感觉系统(Sensory System), 我们才能在神经信息处理的过程中渲染出这样清晰美妙的主观现实, 并无缝的与这个世界交互. 感觉系统就是这个探测外在物理环境转换成主观现实的存在呀. 
[^1]

在科学还属于哲学的时代, 人们就知道人的感觉至少是有5种主要模态(modality)的, 视觉, 听觉, 嗅觉, 味觉, 触觉.[^2] 对于任何一种感觉模态, 神经系统核心的问题都是, 如何快速(fast), 有效(efficient)的表征(represent), 分析(analyze)物理世界的刺激, 得到有用的信息. 类似于对电路的分析, 神经环路的分析(neural circuit analysis), 就在追问神经元内的分子机制, 及其连在一起组成的环路是如何解决上述信号处理中的"工程计算"问题的. 

而这篇post要科普的就是不同生物的听觉感受细胞是如何解决频率选择问题的. 

[^2]: 心理系教材上还会提到自身知觉, 以及平衡觉等. 

## 频率选择(Frequency Tuning)



这一图像十分经典, 此处不再赘述. 

## 听觉感受细胞: Hair Cell


然而对于那些并没有那么长的耳蜗基底膜(Cochlear Basal Membrane)的生物, 怎样才能解决这个问题呢? 

## Elegant Solution of Lower Vertebrate
在知道谜底时, 我对进化的足智多谋(resourceful)佩服得五体投地----用不了机械工程(Mechanical Engineering)的办法, 我们就用生化反应与电生理的办法. 让我们一点点揭开答案, 首先看这张图[^3], 

![Exp_data_1]({{ site.baseurl }}/assets/img/posts/hair_cell/Bull_Frog_Electric_Tuning.png)

衰减, 震荡, 频率选择特性, 这几个关键词放在一起, 是否让你想起了什么悠远的记忆呢? (比如大一学过的大学物理/电磁学? ) 对的, RC电路. 



在感知觉系统中, 不同生物都面临着相似的"工程"问题的挑战, 而就像其他工程问题一样, 问题总有许多的解决方案, 但最终选择哪一种, 依赖于许多物质条件的限制, 而不只是最优性. 

因而在一些更低等动物简单的狭小的神经系统中, 我们更会被那些有限资源下令人惊艳的"设计"所震撼, 比如这个故事中的"设计"----采用两个相互耦合的离子通道(电压依赖Ca2+通道与Ca+
依赖的K+通道) 组成震荡的动力系统已然让人惊叹; 而用细胞内在的震荡频率(intrinsic frequency)作为对输入频率的选频器更是让人击节称叹; 在这个设计下, 不同细胞里不同的通道的表达量(expression level), 即可调节通道密度(channel density)这个参数来调节动力系统的内在震荡频率, 从而组成空间分频阵列, 也即Frequency Place Code. 只能说, 如果让我解决这个工程问题, 我有限的知识与智力一定想不出这么简洁优美的办法, 在生物系统中实现(Implement). 

## 后记
这个故事是在Cell Neurobiology课上听到, 当时就被惊艳到, 并决定写个post督促自己学习下. 查了文章才发现, 这一系列的实验、模型工作是30年前的, 大致在1980-1990左右完成. (事实上, 那几年有大量关于听毛细胞的基本电生理属性的经典工作被完成. )完全可以想见那时人们第一次看到细胞膜上能记录到如电路般漂亮的震荡电压时的震撼与惊喜. 从这里得到了这样几个教训(lesson): 

1. 基于很好的单细胞电生理数据, 能做出很漂亮的单细胞动力学模型，进一步推断出通道的机制也就不奇怪了.  能遇到这样漂亮数据的生物物理学家真的三生有幸. (看到那样干净的电震荡数据, 哪怕是物理系的本科生, 脑子里大概也能立即蹦出几个电路模型来)
2. 而要实际验证这些模型的推断则需要精细的patch clamp实验, 确定每个电生理参数. [^4] 模型是一个开始, 而不是终结. 
2. 不同寻常的模型生物身上, 也许有着很不同的问题解决策略, (这个发现是在乌龟, 小鸡和牛蛙等生物身上得到的). 需要注意, 低等动物的问题解决策略不一定就简单, 反而可能更令人称叹! 高等动物的解决方案也不一定就复杂. (Cf. Sebastian Seoug, 一些Cortex也许比C Elegans和Retina更容易理解)
3. 硬币的另一面, 这个故事虽然极其美丽, 但可推广性也许比较有限, 应用价值也不一定就很大. (也许可以开发基因疗法帮助你家的乌龟治疗听力损伤?) 不过, 这也是在post里选择讲这个故事的原因: 我想去展现一些美丽而无用的东西, 而这是科学与自然(Science and Nature)本来的样子. 



[^3]: Fettiplace, Robert. "Electrical tuning of hair cells in the inner ear." Trends in Neurosciences 10.10 (1987): 421-425.
[^4]: Hudspeth, A. J., and R. S. Lewis. "Kinetic analysis of voltage‐and ion‐dependent conductances in saccular hair cells of the bull‐frog, Rana catesbeiana." The Journal of Physiology 400.1 (1988): 237-274.


[//]: # Auditory hair cells in lower vertebrates such as the turtle and bullfrog ([Fettiplace and Fuchs, 1999](https://elifesciences.org/articles/08177#bib18)), where the hearing sensitivity spans a generally low-frequency range (from around 100 Hz to 1 kHz), show intrinsic membrane tuning such that the membrane potential oscillates at the cells’ characteristic frequency (CF). In these animals, the interplay between the Ca2+ and Ca2+-activated K+ channels, which are differentially expressed along the auditory organ, are thought to be the main mechanism determining hair cell frequency selectivity ([Hudspeth and Lewis 1988](https://elifesciences.org/articles/08177#bib29); [Wu et al., 1995](https://elifesciences.org/articles/08177#bib57)). The mammalian auditory system has evolved to be able to encode a much wider dynamic range of sound frequencies and intensities. In order to do this, mammals have developed an elaborate auditory organ where much of the frequency tuning is carried out by the mechanics of the basilar membrane ([Robles and Ruggero, 2001](https://elifesciences.org/articles/08177#bib51)) and electromotility of the outer hair cells (OHCs) ([Brownell et al., 1985](https://elifesciences.org/articles/08177#bib8); [Ashmore, 1987](https://elifesciences.org/articles/08177#bib1)) driven by the motor protein prestin ([Liberman et al., 2002](https://elifesciences.org/articles/08177#bib38); [Dallos et al., 2006](https://elifesciences.org/articles/08177#bib15)). These morphological and functional differences along the mammalian cochlea produce a tonotopic place-frequency map that is preserved throughout the auditory pathway. Thus the main sensory receptors, the inner hair cells (IHCs), are believed not to show intrinsic tuning in mammals ([Marcotti et al., 2003](https://elifesciences.org/articles/08177#bib39)), although recent studies have shown tonotopic differences in the Ca2+ currents ([Johnson and Marcotti, 2008](https://elifesciences.org/articles/08177#bib33)), the size of Ca2+hotspots at ribbon synapses ([Meyer et al., 2009](https://elifesciences.org/articles/08177#bib43)), and Ca2+ dependence of exocytosis ([Johnson et al., 2008](https://elifesciences.org/articles/08177#bib31)) along the cochlea. 



[^1]: 这篇post是一系列试图以容易的方式解释Neuroscience的一部分, 大概也是我对自己写作能力的训练了. 



