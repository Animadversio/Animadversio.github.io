PyTorch 学习
=====
@(603机器学习 统计学习)[Deep Learning, Data Science]

transforms.Compose

[TOC]

https://medium.com/@radekosmulski/a-practitioners-guide-to-pytorch-1d0f6a238040



# 数据类型

## Tensor

基本数据类型, 类似ndarray, 只是在CUDA, GPU上可用了, 成员函数与ndarray类似. 

* `StimTsr = torch.from_numpy(Stimuli[:,:,:])` 是基本的从Numpy转到Torch的方法
* ​

###  数据类型运算

Tensor的DType?

* ByteTensor 做加减乘除都是整数加减乘除, 与Float运算就会报错! 
* ​

###数据类型转换

`x = torch.randn(N, D_in).type(dtype)` 用.type改

## Variable

是Tensor外的包装, 可以计算对Var的Grad, 

* data: 其中的数据
* grad: 反传之后到var的data
* `requires_grad`  是否给他算梯度
* `volatile` 

**Caveat:**

* 区分抽象Variable 与 其中的数 data Variable不能直接画图, data可以
* Parameter, Variable直接赋值有问题, 但对其中data直接赋值没事儿! 
  * `model.conv1.bias.data[1]=0`
  * `model.conv1.bias[1]=0` 会报错! 
* ​



* `style_img-> torch.autograd.variable.Variable`
* `style_img.data-> torch.FloatTensor`

### Parameters

是一类特殊的Variable, 在Module里声明可以自动加入model.parameter()

* `nn.Parameter(style_img.data)`另一类变量是parameter
  * `optim.LBFGS([nn.Parameter(style_img.data)])`此时才能用作优化器的参数
* `style_img.clone()`复制
* `style_img.detach()` 将一个var从一张计算图上分离出来，不同于冻结
* `torch.from_numpy` 变量类型转换 从numpy变成 tensor

### Grad

注意梯度是默认叠加的!! 

Backward两次就会得到两倍的Grad, 

```

```

`model.zero_grad()`清零所有参数的梯度

cnn
`.view(a * b, c * d)`
Reshape the data, provide another view
可以有一个维度是-1, 其他是整数

`isinstance` determine if it's a instance of a class
better than type



# Model

- `model(data)` runs the model
- `cnn.forward(style_img)`  use variable
  - input of a sequential model is variable

```python
def forward(self, input):
        for module in self._modules.values():
            input = module(input)
        return input
```

- `model = nn.Sequential()` initialize
- `model.add_module(name, layer)` 
- ``



`nn.Sequential` 是通用Container可以序列化装Modules. 逐个Forward, 逐个Backward~



### 模型的保存与重载



# Modules

* Module 类似某种集成化算符, 也类似一层Neuron
* `nn.MSELoss()` return an module object that can calculate Mean Square Error
* 注意可以引用一个model中的module从而get到其结果
* 初始化
  * Modules 自带参数以及参数初始化, 上来就可以Apply, 
  * 也可以自己手动随机初始化, 控制下模`model.conv1.weight.data.normal_(mean=0,std=1)`, 
    `model.conv1.bias.data.normal_(mean=0,std=1)` 
* Modules can be call by name, apply on variable , return variable
  * 不能给他裸的Tensor! 
```python
conv=nn.modules.Conv2d(3,10,(5,5))
conv(style_img)
```

## Conv Layer

* ​
* (batch_size, channels, width, height) 注意Input PyTorch默认是4个维度, Matrix进来要补两个维度! 
* Weight都是Float, 也只接受float输入, 整数不行, 使用Lowbit算法需要特殊模块!! 



## Parameters

* 给Module的参数, 会自动加入parameter list 最后可以在优化时顺次优化. 



# Functionals

* 功能与Modules类似! 但Weight是一个输入的参数, 而非上来初始化好的
* 可用来算数! 



# Training & Optimizing

* `optimizer.step(closure)` pass a closure function 
* `optimzer.zero_grad()` Clear the grad
* `optimzer=optim.LBFGS([nn.Parameter(style_img.data)])`

将parameter输入一个优化器, 优化器参数初始化时付给他, 然后每次`optimizer.step()`即可



# Autograd

>Backward computation is never performed in the subgraphs, where all Variables didn’t require gradients.
>For example if you want to finetune a pretrained CNN, it’s enough to switch the requires_grad flags in the frozen base, and no intermediate buffers will be saved

>Volatile is recommended for purely inference model
>Volatility spreads across the graph much easier than non-requiring gradient - you only need a single volatile leaf to have a volatile output

# Serialization

训练好模型 如何保存, 如何调用呢?

https://ptorch.com/docs/1/serialization#

保存整个模型

```python
torch.save(the_model, PATH)
the_model = torch.load(PATH)
```

或者 保存模型的系数!

```python
torch.save(the_model.state_dict(), PATH)
the_model = TheModelClass(*args, **kwargs)
the_model.load_state_dict(torch.load(PATH))
```

注意这些操作要求ModelClass没有修改过. 改了 加了层就毁了……



# Dataset

```python
import torch.utils.data as data_utils
train = data_utils.TensorDataset(features, targets)
train_loader = data_utils.DataLoader(train, batch_size=50, shuffle=True)
assert data_tensor.size(0) == target_tensor.size(0)
```

Note

``numpy.random.choice(*a*, *size=None*, *replace=True*, *p=None*)` 是用来分训练与测试集的好工具. 