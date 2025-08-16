---
layout: post
title: 日常 (第一次Solo文章)
author: Binxu Wang
date: '2020-11-27'
# published: false
draft: true
use_math: false
comments: true
categories: [personal writing]
tags: [essay, personal writing, academia, feelings, career]
---

许久没有更新经历，最近改完了一篇ICLR文章交上去，处于Intellectual恢复期间 不如回顾下这个经历以及其中的感受。

## 工作的来龙去脉

应该感恩，这次工作真的机缘巧合中诞生的。

先是去年有几次闲着去找侯老师聊天聊数据和实验，他提了个建议让我们去测一测大脑中视觉表征landscape的Hessian，后来发现空间高维非常难做，于是准备计算上先看看CNN的landscape的Hessian。刚了一阵子之后终于知道了怎么autograd求二阶导，于是拿来计算了下我们的GAN发现Hessian的spectrum decay非常快，实质上局部有一个低维结构。不过低维结构在各种数据中很常见，于是没有太惊奇。再加上当时的计算方法特别缓慢，一个4-5年前8层的Generator算Hessian花了20min才算完，也没有看到提速的希望[^1]。于是当时挺灰心感觉这样的计算效率没办法应用到实验，以及跟脑子的实时交互中。

不过心中一直觉得这是个值得算的东西，以及作为一个计算问题也应该去解决。那阵子跟在NYU学应数的道道聊天，聊到这个计算问题，他推荐给我几篇算神经网络高维Hessian的文章，看过去有如醍醐灌顶。那几篇文章用Monte Carlo sampling, Lanczos Quadrature去估算Hessian的spectrum看得我击节称赞，虽然最后并未真的用这个办法。(对...本科时完全没有上过数院数值的课，计算是在物院学的2333) 圣诞的假期以及回国，中断了写code，当时心里依然在想这个问题，所以回P大见淘淘以及本科朋友们甚至还讨论了一下这个计算问题。印象深刻的是在北风嗖嗖的一天跟天一去我家边上的IKEA约饭，在IKEA餐厅里掏出那篇paper来读2333被科普了一下Lanczos Quadrature。以及记起来回到P大的地下打印店印了两本Matrix Computation准备回来参考。

回来便是一月中，紧接着疫情爆发shut down应付涌进来的实验数据以及新实验，忙乱中忘记了这件事。恍然5月底6月某天去公园散步回来晚饭时在网上闲逛，看到一种算hessian eigen的方法，跟自己心中设计的想法无比相似。于是瞬间被激起了斗志，把他们的计算方法链接到GAN的问题上。干了几天之后Hessian计算速度就突飞猛进，从20min降低到3min，如果不用计算整个矩阵计算速度就可以降到1min以内，之后就可以大规模计算Hessian了。

而这个计算效率的小突破让一连串问题变得容易回答：不同点的Hessian之间的相关性？GAN的流形的全局结构。接下来的几天惊心动魄而又让心脏提到了嗓子眼。每天都有一个新的idea突破



[^1]: 回看那时候的code慢的原因之一也许是过度包装，当时自己对DL框架的认识很粗浅，几乎只会用包装好的方法，于是只能用别人封装的code来解决每个部分。比如用别人的code来把caffe包装成torch，以及用别人写的Hessian computation。后来自己拿torch重新实现了网络，而Hessian computation现在自己写只用两行就解决了
[^2]:

## 反思

尽管自诩知识背景全面，但一直也知道对很多领域的知识流于表面。这次写ML的文章还是发现了许多知识漏洞。比如碰上一个数值计算方面非常扎实的reviewer，我response里写的一句不严谨的话(Lanczos algorithm比random sampling method更sample efficient)，于是就被放在地板上摩擦摩擦了。

说到底

## 学到了啥(Lessons Learnt)

并非第一次写文章或者改文章，不过的确是第一次从头到尾刚一个工作，如果说核心学到了什么，那就是怎样用数值实验去make a point以及用Figure来展现。

### 有关Writing

有关写作是这一次真真要感激庞老师的一点，无论是他在身边看着我写，还是我们一起互相改作文，都给了我很多精神以及技巧上的帮助

* Writing is not a single shot thing. You need space-time distance to evaluate yourself. 

  * 可能这是这一次从庞老师身上学习到的最重要的一点。

  > Writing continuously for long hours is not usually helpful, but writing persistently every day is usually helpful. 

  * 不太可能一次性写好一篇文章，所以每当写了一大段自我感觉不错时，不应该立即提交，而是睡一觉或者做一些别的。过几个小时再来回顾，通常能发现许多可以提高的点。
  * 所以每天接着写文章 写一阵子 通常能进展迅速，但连着写好几个小时未必会有效果。

* Actor与critic状态的分离

  * 写作时先忘记作为critic的那部分自己，即使有篇幅限制也先忘记篇幅限制，write clearly and explicitly and convey your idea. 
  * 但修改时也忘记actor的那部分自己，暂时忘记自己琢磨每一句话的努力以及brilliance，用力删减来保留意思最清楚的部分。
  * 这有点像Alternative Optimization algorithms, 它的核心是relax constraints, 对于一个复杂的约束优化问题，先忽略一部分constraint把优化做好，再加回来constraint解出真实的解。

* Say it and Write it

  * 对人或者对猫咪说出自己想说的事情，然后再写下来。
  * 如果有合适的listener让你可以解释清楚你的point，这个过程会非常享受。
  * 人用口语conversational表达一个idea似乎比书面写出一个idea更容易。

### 有关写code

许多coding的lesson在6-7年前的信科课上的确学过，但“纸上学来终觉浅”

* code的分类: 这回 至少明白了一个计算类project的基本结构. Basic infrastructure, Utility code -> Experiment code -> Analysis code 
  * Basic infra struct 写清楚模型以及最核心的方法，util做一些数据的基本处理以及输出的基本可视化。
  * 与发表相关还会有 把许多实验一起分析的synopsis / meta analysis code 以及 Figure generating code, 
* 不要过晚封装: Function, class 应当是人的mental instruction、manipulation的对应物，应当是你想干什么就能够用简短的命令 call function实现。(e.g. 我希望把这些图拼在一起，增加他们的行距，随机产生一些sample)
  * 封装的动力有时来源于对大段复制代码的本能痛恨。
  * 调用函数 对于大规模实验的代码简洁，节约内存(删除中间结果)都是重要的。
  * 对于Python，封装class, function无比简单。所以及早将一个well defined 功能变成一个function, class 是好的。
  * 有些功能简直是begging you to define a function for that.....
  * 好的函数是即使很久没有读那一段code，依然可以使用这个函数实现它的功能。因而doc string以及example demo很重要
* 抽象、通用接口: 
  * 通用接口的动力来源于对通用处理方案的渴望。 
  * 通用接口的意义在对许多不同对象做实验时体现出来。比如如果分析的数据又Calcium Imaging又有Electrophysiology spike rate，也许应当有一个封装以及一些通用的方法(他们身上你所关心的共同性质)。比如不同结构的GAN 可以有一个封装就是能生成图片以及sample noise。
  * 有了这样的封装，跟这些实体交互的code就可以通用化，无需为每一种GAN, 每一种neural data单独写code. 
  * 不过有时过于不同的实体也许不应该通用化。只能在下游写两种不同的处理code。
* 不要过早封装: 过早封装会隐藏中间结果
  * Python debug函数较不方便，特别是别的module的函数，没有经过充分验证的函数便是定时炸弹。(matlab debug函数就比较方便...)
  * 由于不清楚后续应用，过早封装可能会在函数里丢掉后续有用的信息引起重复计算。
  * 为了某个目的写的封装code也许assume了某种应用，后续其他应用也许就用不了，就得重写封装。
* 一路向前(Fast Forever)与 代码重构(code refactoring): 
  * test idea时不用太在意code的整洁，封装接口可能写的太多或者太少。但下一次应用时（一般是第二天起床）看到这些code就会头痛欲裂。( 感觉原因是一部分相关的working memory在睡眠时被扔掉了，再使用昨天的code就艰难了很多。
  * Refactoring、Documenting的最佳时间是第二天或者过几天醒来要重新使用这一code。
  * 在写实验code以及初步analysis时因为目标不明确，很难重构好，这时写的乱七八糟的script即可。但在写大规模实验code时就很希望能有模块化的组件方便一次性能尝试所有的参数组合，这时就很需要well wrapped code.

Related Read: [From Experimental Code to Package Product](https://towardsdatascience.com/building-package-for-machine-learning-project-in-python-3fc16f541693) 

### 有关paper

* Paper as a detective story / argument: 
  * 之前不是很认可，不过渐渐认可这一点。paper说到底是一篇文章，而不是实验结果的堆积，所以最后目标是要make a point clear。为了这个目的experiments, mathematical derivations, logical arguments and knowledge in literature都是可行的手段。 某种意义上是综合搏击，而不是击剑。
  * 所以两种结构一种是从一个有趣的现象观察开始，写detective story，看看什么是这种现象的原因。
  * 或者从一个一个自己认同的解释开始，来论证为什么这个理论是对的。
  * 有时这两种结构Observation / Hypothesis driven也会相互交织。

* What to show: 
  * 对于一个论点或者观察，一个常见的展现方法是展现一些例子，让读者视觉上接受冲击认同你的观点，然后显示population analysis说明例子的代表性。
    * 视频 图片的例子最有冲击力 让人一目了然，然而能展现得例子总是很有限，所以只用例子就会有人complain，所以需要population analysis来scale up。
    * 但population analysis需要设计特定的score index与statistics，然而抽象的statistics也容易让人怀疑，难以信服，
    * 虽然选择示例的时候可能会让读者对effect size有一点错误的认识。
  * 这种从细微具体到宏观抽象的展示可以层次递进，从一个图片，到一组参数的所有图片，到各种参数；一个细胞到所有细胞，到几只猴子。
* What to experiment: 
  * 正如所有的科学实验，即使是计算实验，我们也无法证明一个statement为真：因为大多数时候不可能穷记所有的sample。而这一点对于perception relevant statement就很要命，how to prove A is perceptually more xxx than B? 这时就需要有大量的人类sample来论证这一点。
  * 所以正如What to show所说，有时得到一个observation本身是很激动的事，但找到用index来quantify的方法以及这个observation与某种control的不同就比较难
* Schematics是很重要的，特别是你的point依赖一种直观，好的schematics的能convey things that are hard to express in words. 

* 有关作图：
  * 这回作图对Illustrator的使用纯熟了不少，虽然还不是信手拈来至少已经感觉到用AI的效率可以跟Powerpoint的效率相提并论，而且还比较flexible。
  * 

### 有关response

* 写response / defense 跟自己写essay / thesis真的很不同，后者可以面对想象中的读者构建结构自说自话，前者则有一个特定的读者无法忽视。