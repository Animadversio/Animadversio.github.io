Recurrent Network Dynamics
=========

许多初期人工智能 人工神经网络模型 都是RNN, Hopfield, Bolzmann Machine, 等等

## Continuous model



### 少体神经元动力系统分析


[On the dynamics of small continuous-time recurrent neural networks](https://pdfs.semanticscholar.org/c9c1/098ae21681851b41a115e4628f3932692329.pdf)

$$\tau \dot y_i=-y_i+W_{ij}\varphi(y_j+\theta_j)+I_i$$

做了1个Neuron, 2个neuron, 3个neuron的case study, 比较exclusive的研究. 发现3个neurons已经能产生Chaos了. 会有Strange attractor

做了很详细的动力系统分析, 分岔分析, 相空间分析. 然而很难得到很general的结论. 似乎对于RNN, 什么都是可能的! 

因此做一个Unified theory of Neural Dynamics 大约不太可能. 但可以考虑对于特定系统 分析其动力学 相空间.



### 关于其fitting能力的数学证明

Ken-ichi Funahashi and Yuichi Nakamura. [Approximation of dynamical systems by continuous time recurrent neural networks](https://www.sciencedirect.com/science/article/pii/S089360800580125X). Neural Networks, 6:801–806, 1993.

> under fairly mild and general assumptions, such RNNs are universal approximators of dynamical systems. 

可以将n-d动力系统嵌入高维空间, 被neural的internal state dynamics 来fit. 

> Any finite time trajectory of a given n-dimensional dynamical system can be approximately realized by the internal state of the output units of a continuous time recurrent neural network with n output units, some hidden units, and an appropriate initial condition. The essential idea of the proof is to embed the n-dimensional dynamical system into a higher dimensional one which defines a recurrent neural network. As a corollary, we also show that any continuous curve can be approximated by the output of a recurrent neural network.

可以fit 任何动力系统, 于是其动力学没什么constraint也就不是很奇怪的事情, 很难得到很general的结果. 从响应反推动力系统或许不很成功. 但总能做所谓动力系统fitting. 因而也是Reservoir computing的一个思想基础. 



### How to learn?

[Generalization of back-propagation to recurrent neural networks](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.59.2229)http://brainmaps.org/pdf/pineda1987.pdf



## Discrete model





## Reservoir Computing 

Use a random RNN to generate many dynamic traces, but only train the readout part, without train the RNN part. 

**Note**: a direct application of, RNN can do any kinds of things but we only extract certain facet of it. 

> 弱水三千 我只取一瓢饮

http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.470.843&rep=rep1&type=pdf



