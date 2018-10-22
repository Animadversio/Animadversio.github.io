# BirdSong

[TOC]



## What is Bird Song

Bird Vocalization: 区分一般的鸣叫Call 与 歌唱Song

* Call
* Songs
  * 功能 用于求偶等
  * Complexity, Context
  * 音节结构 规则性

## Recording

Sonogram

## Structure

Motif & Syllable

## Learning from Tutors

* $30-45d$ Subsong
  * Subsong的时间Sturcutre很复杂
  * LMAN脑区对他形成很有用
* $45-80d$  plasticity
* $>80d$  crystalize

学习, 自然涉及听觉通路以及比较

## Song Culture

不同鸟之间唱歌共同的特点: 

**Interesting Case: Song的进化**

* Isolated bird第一代唱的很乱
* 以Isolated bird作为导师，N代之后收敛回Wild Type的Song类型
* 可能是优化过的唱法。



# Mechanism

## Circuit for Song Generation

HVC->RA->nXIIts

![](https://upload.wikimedia.org/wikipedia/commons/c/c8/Birdbrain.svg)





* **HVC**
  * 调节肌肉控制
  * 被发现是Sparse Firing Event (Bursting)，放电时间非常精确
  * HVC 是只编码时间？还是一个动作序列
* RA
  * RA 不会是single firing packet
* nXIIts, brainstem motor area

*Michael A. Long[1](http://www.nature.com/nature/journal/v456/n7219/abs/nature07448.html#a1) & Michale S. Fee[1](http://www.nature.com/nature/journal/v456/n7219/abs/nature07448.html#a1)， Using temperature to analyse temporal dynamics in the songbird motor pathwayNature* **456**, 189-194 (13 November 2008) | doi:10.1038/nature07448; Received 22 May 2008; Accepted 23 September 2008



基本连接通路：



## Circuit for Learning



* DLM
  * inactivation generate 


* area LMAN
  * 对早期subsong产生很重要，早期阶段去掉LMAN就不唱了
  * inactivation LMAN generate oscillation activity ~10Hz
  * 加入TTX阻断 LMAN对RA的投射可以逆转Reinforce出来的效果。
    * TTX是$Na^+$ 通道阻断剂。
    * Andalman Fee PNAS 2009
  * 认为LMAN有产生Variability的作用
* area X

## Reinforcement Learning Model

行为学实验可以在鸟Plasticity唱歌时播放噪音，使之之后唱到这块发声频率就改变



## Modelling Problems

Sequence Generation NN

* 固定一个网络Topology总能做！
* Sequence Learning？
* STDP Learn sequence？Not Backprop。
  * Learn Correlation-> sequence learning
* 为什么Crystalize? 为什么之后不太变了



