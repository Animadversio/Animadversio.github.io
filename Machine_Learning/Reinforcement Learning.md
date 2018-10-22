## 何谓强化学习

决策问题：Agent与环境之间的交互，增加Reward 减少Punishment
可以看成介于无监督与有监督之间 的 问题，通过交互 产生监督
产生的是策略。在什么条件下做什么操作？

基本问题：Explore and Exploit 的“矛盾”
探索世界 获取信息/利用已知的信息 去最大化利益 两者有基本矛盾

基本特征：训练和测试 合一

考虑闭环体系，产生的system直接可用

Setting：

* 环境特征已知？Planning
* 环境特征未知？Learning enviroment and  policy to react

**相关学科**

* 控制论 Control theory
    * 连续状态情形 — 微分方程语言
* 运筹学 operatics 主要模型
    * Markov Decision Process 决策过程
    * Hidden Markov Model
    * Partial Observed MDP 部分可观测
    * 若模型可知
        * 动态规划 Dynamic Programming
        * 近似动态规划 
        * MC sampling
* 人工智能 AI

可以区分连续与离散模型 

Neural Dynamic Programming 
Dynamic Programmming and Optional Control
Approximate Dynamic Programmming

## Elements
强化学习问题的要素 Agent Enviroment and action
在时间中决策。

* Policy：面对情境如何行动 $\pi: S \to A$
* Reward：每个时刻情境如何给予reward, 可能与当前action有关 $r: S\times A_t \to R$
* Value function：类似长期Utility，是Reward的结果，是直接决定选择的量。比较有远见。但很难估计。
* Model of enviroment：环境在action下如何变化。有Model based与Model free之分


### Case Tic-Tac-Toe


* Policy：map each configuration to action
* Value: 




