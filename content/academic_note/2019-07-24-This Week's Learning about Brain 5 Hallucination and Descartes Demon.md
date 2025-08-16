---
layout: post
title: This Week's Learning about Brain 5 幻觉与笛卡尔的幽灵 Hallucination and Descartes' Demon (II)
author: Binxu Wang
# published: false
draft: true
use_math: true
comments: true
tags: [This Week's Learning, Visual Neuroscience, Consciousness, Cortex, Sensory System, Philosophy, Concept, Computation, Sleep, Dream, Hallucination]
typora-root-url: ..\assets\img\posts\Visual_consciousness
typora-copy-images-to: ../assets/img/posts/Visual_consciousness
---

[上一篇post]({{page.previous.url}})介绍到了与视觉意识相关的一些神经活动

## 做梦, 幻觉与意识(Dream, Hallucination and Consciousness)

笛卡尔在第一哲学沉思集的第一卷设想各种自己的知识可能出错的情形时, 想到了经典的做梦案例: 我以为我看到了燃烧的火炉, 但实际上可能我在被窝里呼呼大睡呢! 像笛卡尔一样, 对大多数人, 做梦是强烈的视觉过程, 我们会觉得自己在睡梦中看到了些什么. 某种意义上说这也是一种不同状态的视觉意识. 

那么一个有趣的问题就是睡眠过程中的大脑活动和醒来时有什么不同呢, 而做梦时和不做梦时的活动有什么不同呢? 由于没有外界输入也没有行为输出和基于任务的认知活动, 做梦中的脑活动似乎可以干净的与梦中的视觉意识挂钩. 这样看来做梦似乎是研究视觉意识的神经对应的良好范式. 

经典研究中, 睡眠可以依据脑电(EEG)频谱, 波形和眼动活动进行分段, 大致可以分成非快速眼动睡眠(NREM)与快速眼动睡眠(REM). 前者还可以分为N1, N2, N3-慢波睡眠, 随数字增大睡眠加深. 传统上认为, 大多数做梦发生在快速眼动睡眠期间, 而且REM期间的脑电活动与觉醒时的活动很像. 经典的功能磁共振-脑电联合测量(fMRI-EEG)发现[^73], 在快速眼动睡眠(REM)时初级视皮层的神经活动被抑制, 而高级/联合视觉皮层(如fusiform gyrus and medial temporal lobe)的活动被大大加强. 反过来在慢波睡眠(SWS)中, 有观测到初级听觉 视觉皮层的激活, 而高级区域(如medial temporal)则被抑制了. 这么看来似乎而视觉联合/高级皮层与视觉意识的关系更紧密.  

对于脑损伤的病人的观察也得出了类似的结论. 失去部分或全部初级视皮层的病人还是能做有视觉表象的梦(visual dream); 单侧额叶与顶叶损伤(prefrontal & prietal 一般认为是复杂认知与控制的中心)的病人会整体上停止做梦; 有趣的是, 那些双侧颞枕叶切除的病人(medial occipitotemporal region 一般认为的高级视觉区域)会特异性的失去做视觉梦的能力!! 而且那些只会做非视觉梦的人, 也总是同时患有视觉回忆障碍, 以及某种视觉认知障碍(visual agnosia)比如脸盲症(prosopagnosia)等. 这些症状也通常与视觉高级皮层有关[^0]. 

[^73]: Hobson, J. A., Pace-Schott, E. F., Stickgold, R. & Kahn, D. To dream or not to dream? Relevant data from new neuroimaging and electrophysiological studies. Curr. Opin. Neurobiol. 8, 239–244 (1998).; Maquet, P. Functional neuroimaging of normal human sleep by positron emission tomography. J. Sleep Res. 9, 207–231 (2000).  
[^0]: Rees, G., Kreiman, G., & Koch, C. (2002). Neural correlates of consciousness in humans. *Nature Reviews Neuroscience*, *3*(4), 261–270. https://doi.org/10.1038/nrn783074 

而更进一步, 我们能否从睡觉的被试的脑活动推测出他们在经历什么视觉表象呢? 2013年一组日本科学家[^8]做了这件事! 首先他们选取的是在人即将睡着时(Sleep Stage N2)经历的视觉幻象(Visual Imagery)作为研究模型(术语叫[Hypnagogia Hallucination](https://en.wikipedia.org/wiki/Hypnagogia) , 正如我们预期的网上查这个现象可以搜到一堆灵修方面的文章2333). 主要原因是他们可以更频繁的获取这种幻象的报告——让被试在fMRI仪器中睡觉, 当EEG信号中出现某种特定模式, 被试就会被唤醒, 并报告自己刚才经历了什么幻象. 这一过程大致10min一次, 相比于等睡觉时半夜唤醒这种方法可有效率多了. 每个被试都要经历250-300次这样的实验(zhe mo), 其中每4次有多于3次被试都会报告一些视觉表象. 接下来, 他们将被试的报告提取关键词(我猜是物体名词), 放进著名的WordNet里找到这个词对应的概念树(如 男人<人<生物 这一概念层级), 来构建一个共同概念集, 然后再用著名的ImageNet数据集找到这些概念对应的一些标志性图片, 然后把图片呈现给清醒的被试看, 获取他们的大脑对这一图片数据集的响应模式. 利用这一数据集他们训练了一个分类器, 来根据血氧活动(BOLD)模式分类被试观看的物体种类 (平均cross-val 正确率85%). 

![image-20190723145216587](/image-20190723145216587.png)

当实验者把在清醒数据上训练的二分类器用来识别睡眠状态的神经活动时, 二分类平均正确率60%, 的确超过随机水平. 如果挑选一些能激活特定模式的图像类别, 正确率达到了70%以上! 而且与前面讲述的一致, 空间上高级视觉区域的活动模式相比于低级区域能更好的分类视觉表象. 而一些特定区域如与脸部识别相关的FFA则能更好的解码出不同类的人. 时间上, 醒来前10s的神经活动模式的分类效果最好, 这也非常符合我们的直觉—— 人醒来时记住的基本是最后的神经活动对应的图像.  

![image-20190723165002753](/image-20190723165002753.png)

[^8]: 2013, T Horikawa, M Tamaki, Y Miyawaki, Y Kamitani, Science, Neural Decoding of Visual Imagery During Sleep

除了正常人都会经历的做梦, 一些人会经历更为病理性的视觉幻象(Hallucination). 这种现象也是研究视觉表象的良好平台. 

在1998年UCL的一组神经成像学家[^12]就利用当时非常新鲜的功能核磁共振(fMRI)技术扫描了一些有视觉幻象症状的病人(Charles Bonnet Syndrome Patient). 这些病人通常患有视网膜与视神经病变, 因此一般视觉受到了损害, 然而他们能不时的看到一些自发出现的幻象——幻象比真实的视觉刺激更加鲜活生动. 科学家让被试报告自己幻象出现的时间点, 位置以及视觉形态, 然后就可以比较发生特定幻象时的将全脑的血氧活动信号(BOLD signal)与正常状态有何不同. 下图中的红色区域都是在出现幻象时特别的激活区域. 这种图像与脑区的空间激活模式与清醒时的激活模式大体上相似—— 一些比较专业化的高级视觉区域. 如幻象中看到的脸与Fusiform Gyrus (包含著名的FFA脸部区域)激活相关, 而看到砖块, 材料纹理额被试有在collateral sulcus的激活(对纹理刺激很敏感). 而相比于正常观看图片刺激的被试(同样患有视网膜疾病, 但没有幻象症状), 这些患者的初级皮层反应最为不同——V1的视觉激活远低于一般的被试, 而且不稳定. 

![image-20190723180707593](/image-20190723180707593.png)

而且在时间上, 以患者报告的幻象开始时间作为基准去平均神经活动信号, 可以发现, 幻象开始10s左右开始有明显的活动升高——说明时间上神经活动变化与主观意识变化可以很好地吻合. 总的来说, 这一结果也与前文描述的, 高级皮层的活动与视觉表象更相关. 

![image-20190723181935345](/image-20190723181935345.png)

[^12]: 1998, The anatomy of conscious vision: an fMRI study of visual hallucinations

## 

## 后记碎碎念: 被忽略的意识(The Neglected Consciousness)

突然想起来写这个主题的post, 一个是资格考试(Qualify Exam)期间的主题Recurrent Computation恰巧把自己带到了与视觉意识相关的文献海洋里, 又听了Christopher Koch的科普讲座, 于是出于兴趣自己研究写了个小文章. 

另一点是, 这个主题的确对神经科学家既熟悉又陌生. 我相信, 许多Neuroscientist投身这个领域是有一些出于想要了解人类自己的动机的, 而我们每天都接触到的这个主观世界, 这个让笛卡尔说出 *Cogito ergo sum* 的主观世界[^10], 这个与物理世界相似却又不完全相同的主观世界是怎么来产生出来的, 我相信一定引发过许多爱智慧 爱自己的人的沉思. 那种把自己想象成黑镜中一样自己坐在黑屋子里观看外界摄像机, 作出操纵和决策的感觉相信也不少人会有~ 

[^10]: 笛卡尔在 第一哲学沉思集 第二篇 中为了证明自己的存在诉诸于自己的思想过程和主观现实. 当我质疑自己不存在时(*Dubito*), 那质疑就已经包含了一个质疑者因而印证了自己的存在. 当我感觉到自己在走路时(*Ambulo*), 我也许在做梦—— 我并没有真的走路, 但我感觉到自己走路这一主观现实(或是幻视visual hallucination) 同样证明了我的存在. 

然而这个概念又对神经科学家十分陌生, 很少有人真的敢在研究中触及他. 其一是对于大多数神经科学的研究模型, 果蝇, 鱼, 老鼠, 猴子, 他们能主观报告的内容十分有限, 于是我们并不能区分什么是被"意识到"的. 又他们的学习能力参差不齐, 希望他们通过学习来报告自己意识到了什么也并不总能实现. 而对于人类被试, 意识的神经相关物问题(Neural Correlate of Consciousness), 最近二十年被提出但距离解决还有许多路要走, 而大多数神经科学家没什么办法触碰这一领域. 于是就有了那个经典的笑话, "要想和神经科学家谈论意识, 最好是在酒后. "

因而我个人不太喜欢一些系统神经科学家将神经科学的使命定义成 "生物怎样利用感觉系统感知这个世界, 并转换成行动(action)与之交互", 虽然这个使命听起来似乎简单而且可以实现. 许多研究低等一些动物(如斑马鱼幼鱼Larval Zebrafish)的科学家甚至会直接谈 感觉-动作映射(Sensory Motor Mapping / Transformation). 几乎是将生物理解为一个硬件决定的*有限*状态机, 甚至是没有内在状态的*刺激-响应*机器. (也许是由于先贤的努力, 我们对人性的理解还没有还原到如此机械的层次……)

相比于此, 对决策(Decision)以及对主观感知(Perception)的研究就更符合人的视角一些, 更有心理学而非生理学的味道. 

