

## Perceptron to MLP

Single layer perceptron is a linear classifier, which can not solve XOR. 

Multi layer perceptron to solve XOR problem!!! 

可以detect difference. 隐藏层增加了一个强大的 difference neuron. 对输出有Excitatory 输出. 而两个输入与输出之间也是Difference detection 的关系. 

+5 -5 
$$
logit(x)=\exp(x)/(1+\exp(x))\\
logit(x)'=(1-logit(x)) logit(x)\\
$$

$$
dy/dh=y(1-y)*w\\
dy/dx=y(1-y)*w*h(1-h)w_x
$$

Activation function?

* ReLu : faster, and easy to calculate grad. **And can die forever!** 传输的grad量很小! 
* Sigmoid: 全是正的
* Tanh: 有正有负 对称 

Actication 有正有负 / Weight 有正有负是不是好事?

如何几何的理解MLP? (Geometric Picture of NN)

* 线性操作$wx+b$ 定义了一个超平面! 
* 非线性操作是对该超平面的弯曲 
* 再一步叠加是对这些超平面超曲面的叠加. 
* 因此是一个线性 非线性 线性非线性的过程. 



## RNN

Use time course as a vector to input! Discard time connection/sequence/proximity. 

初始文章是Jeffrey Elman cognitive science paper 

Predict next object in time course~ 

时间上的平移不变!Cf. CNN空间上的平移不变 
$$
h_t=g(Wx_t+Vh_{t-1})\\
\hat y_t=g(Uh_t)\\
$$
求导时 要级数求和!! 

Q: 求导快 还是 wiggle weight 快一点? 后者也能找一个下降的方向呢. 前者是Backward pass, 后者是Forward pass , 其速度不知道谁快一点. 

### LSTM Long Short Time Memory



### GRU Gated Recurrent Unit

2 RNN+memory+attention -> Google Translation





## CNN

