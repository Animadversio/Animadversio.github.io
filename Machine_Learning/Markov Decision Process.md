





Elements of a MDP

* Decision Epochs(time index set): $[0,T]$ or $\{0,1,2…T\}$ 
* System state set: $s\in S$ 
* Action set: $a\in \mathscr A_s$
* Transition probability: Transition $S\times \mathscr A_s\to S$ $p(s_{t+1}|s_t,a)$
* Reward function: $S\times \mathscr A_s\to R$ , may rely on next state but can be averaged out. 



寻找 Policy算法: 

* Markovian deterministic 
* Markovian randomized
* Historical deterministic
* Historical randomized



算法优化目标: Sum of Reward 



解决算法: 

### 确定性动态规划问题 Deterministic Dynamic Programming DDP

* 是一个确定性的映射转移映射 $S\times \mathscr A_s\to S$ 也可以定义相应的 0,1 tensor
* 动作直接决定了下个时刻的状态, 并不有分布 $|1_{p(s_{t+1}|s_t,a)}|=1$ 



**Example**: 图上最短路问题: 以节点为状态, 以可行路为action, 以路径消耗为reward. (然而为了定义Decision Epoches 需要近似stage)

* 事实上大部分DDP问题都可以被转化为最短路问题. 

定义有向无环图Directed Acyclic Graph, Node $N$ , Edge $E\subset N\times N$ 



最短路 - 最大割问题: 









如何确定 Uncertainty 中的决策. 

* 如何利用不确定性, 探索世界





Policy evaluation

Belman Equation