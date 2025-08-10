---
layout: post
title: Comparison of Major Deep Learning Frameworks (Updating)
author: Binxu Wang
date: 2019-12-18
comments: true
categories: [machine learning]
tags: [tech note, Machine Learning, Deep Learning, Computation]
---

# Objective

Here I want to compare several common deep learning frameworks and make sense of their workflow. 

# Core Logic

## Tensorflow

**General Comments**:  TF is more like a **library**, in which many low-level operations are defined and programs are long. In contrast, `Keras` which can use `tensorflow` as backend has the similar level of abstraction as `PyTorch`, which is a higher level deep learning package. `TFLearn` may also be a higher level wrapper. 

Besides, the design logic is quite different. TF is designed for static graph. Construct the computational graph first, and then put in data, and operate really in Session.  It normally follows *lazy execution* instead of *eager execution*. 

So it's more like a compile and run language like C++ or Julia, than script language like Python. 

* General Programming Model: Graph and Execution
  * Use tensorflow `operations` to create a computational Graph
  * Evaluate / Run the graph in `session` . 
    * Input can be feed into a graph, and results could be fetched in `sess.run(fetches,feeds)` . 
    * Example: `sess.run([output, intermediate], feed_dict={input1:[7.], input2:[2.]})` 
    *  `Session` is interacting with the C++ runtime evaluating the graph. 
* [Basic TF usage](https://chromium.googlesource.com/external/github.com/tensorflow/tensorflow/+/r0.10/tensorflow/g3doc/get_started/basic_usage.md) 
* Data Structure
  * Tensor. the basic datatype in computational graph. 
    * `tensor.eval()` will evaluate the tensor by evaluating all the operations along the graph. 
    * `tf.convert_to_tensor` is the way to convert other things into `tensor`
    * `tf.constant` is just a type of tensor. not really special. 
  * Variable, like old `PyTorch` it's a wrapper over tensor. It can keep states over several `run` call. 
    * [Tensor vs Variable](https://stackoverflow.com/questions/44167134/whats-the-difference-between-tensor-and-variable-in-tensorflow/44167844) 
    * Varibales have to be `initialize` to use. You can do that by executing `tf.global_variables_initializer()`. 
  * Placeholder, is a way to let user inject data into computational graph. You have to specify this when run a computational graph
    *  `placeholder(dtype, shape=None, name=None)`
* Gradient Computation
  * `tf.gradients` can explicit compute gradient like `torch.autograd.grad`. see [official note](https://www.tensorflow.org/versions/r1.15/api_docs/python/tf/gradients). 
    * `z = tf.subtract(tf.sin(x), tf.pow(y,3));
      grad = tf.gradients(z, [x, y])` 
  * Loss variables can be sent into `optimizer` so that gradient could be computed towards target variables. Useful functionalities like 
    * `optimizer.compute_gradients(L,var_list=[v1,v2])`  returns the variable and gradient pairs for each variable in `var_list`! Good to see the gradients if you want to manipulate it. 
    * `optimizer.apply_gradients(grads_and_vars,)` will apply gradients to update variables.
    * `optimizer.minimize(L)` combines the 2 steps and update the variables. 

```python
vstr = tf.Variable([1,2,3.0],dtype=tf.float32) 
vstr2 = tf.Variable([3.0,2,1.0],dtype=tf.float32)
L = tf.tensordot(vstr, vstr2, axes=1) 
optimizer = tf.train.AdamOptimizer(beta1=0.9,beta2=0.8)
cG = optimizer.compute_gradients(L,var_list=[vstr2,vstr])
Min = optimizer.apply_gradients(cG)
with tf.Session() as sess:
	sess.run(tf.global_variables_initializer())
	print(sess.run(L))
	print(sess.run(cG))
	print(sess.run([vstr,vstr2,L,Min]))
	print(sess.run([vstr,vstr2]))
	print(sess.run(L))

```



* Neural Networks
  * 

[Tensorflow Notes](https://tensorflow-notes.readthedocs.io/zh_CN/latest/index.html)

[Tensorflow tutorial](https://www.toptal.com/machine-learning/tensorflow-machine-learning-tutorial)

## PyTorch 

Logic of pytorch is quite intuitive. PyTorch is designed for dynamics computational graph, very useful for debugging, try out things and for RNN training. 

Generally, `PyTorch` is a great tool for general purpose differentiable computing, not just deep learning. 

* Data Structure
  * `torch.tensor` is the basic data type, which is quite similar to `np.array` format in `numpy`
    * `tensor` behave much like `numpy` so many basic visualization tool can still work with tensor! 
    * But `tensor` only interact with `tensor` don't add `np.array` with `tensor`
    * (For ancient `PyTorch` versions, Tensors could be wrapped up as `Variable`, and for `Variable`  you can set the `requires_grad` flag as `True` to enable gradient computation, [now tensor also support gradient computation](https://www.quora.com/What-is-the-difference-between-a-Tensor-and-a-Variable-in-Pytorch). )
    * `tmp = torch.tensor([1.0,2,3], requires_grad=True)`
  * Just as `numpy` there are different datatypes of data in `tensor` like `torch.float` 
    * `tsr.type(dtype)` will returns you a copy of tensor in the given format. 
  * `tensor` can live in different devices, and only tensor on the same device could operate with each other. 
    * `tsr.device` show you the device it lives in. 
    * `tsr.cpu()` and `tsr.cuda()` returns you the same object if it's already on that device. It will returns you copy if it's not! 
      * `tsr=tsr.cuda()` will transfer data to gpu, but  `tsr.cuda()` itself will not. 
* Gradients computation

  * `requires_grad` could be set for `tensor` (and `Variable`) to enable gradient flow. 
    * This flag will propagate automatically when other variables are constructed depending on a `Variable` that requires gradient. 
    * i.e. Computational graph is generated while performing operation. 
  * `detach` gives you a tensor detached from the computational graph! `.detach()` gives you a copy, and `.detach_()` just modifies the target tensor. 

  * `tensor` s could be put into `torch.autograd` machinery or `torch.optim` optimizers to compute gradients and optimize! 
    * `optimizer = torch.optim.Adam([img_tensor], lr=0.1, weight_decay=1e-6)`
    * `torch.autograd.grad(loss,img_tsr)`
* Neural Networks

  * Basic component of PyTorch is `module` , it normally implements a `forward` and a `backward` function. 
    * Note, as `autograd` is available, you don't always need to write a `backward` function explicitly. You can `loss.backward()` then the gradient just flow back on the graph constructed during `forward` pass. 
  * `module`s could be chained or constructed together to make `models` which we usually call networks. 
  * Flags
    * `model.cuda()` returns you a copy of model with all parameters living on gpu
    * `model.eval()` set the flag into evaluation mode instead of training mode. 
* Serialization
* Torch save model with 2 formats, serialize whole model object with `torch.save` or save weight through `torch.save(model.state_dict())` See the [recommended method ](https://pytorch.org/docs/stable/notes/serialization.html#recommend-saving-models) 
  * The former method mandates you have the class of the model defined or loading will fail. 
  * The latter is more general, as long as you have the class definition for the model. 
* Conventions 
* Axis convention `B,C,H,W` same as caffe, but the channel is in `RGB` order. 

[Starting Tutorial to Learn Pytorch](https://github.com/jcjohnson/pytorch-examples/blob/master/README.md)

[How and When to use Module, Sequential, ModuleList and ModuleDict](https://github.com/FrancescoSaverioZuppichini/Pytorch-how-and-when-to-use-Module-Sequential-ModuleList-and-ModuleDict)


## Caffe

* Data Structure 
  * Basic datastructure in Caffe is just `numpy.array` nothing special. 
  * The input and output to layers are `blob` s 
* Neural Networks
  * [Net Layer Blobs](https://caffe.berkeleyvision.org/tutorial/net_layer_blob.html)
  * Neural Network structure could be specified in [`caffe.proto`](https://github.com/BVLC/caffe/blob/master/src/caffe/proto/caffe.proto) format, which is a form of google `protobuf` 
* Conventions 
  * Axis convention `B,C,H,W`  and also the channel direction for images are flipped, so the `[0,1,2]` channel is `BGR` 

## Matlab

* Data Structure
  * Basic data structure in matlab deep learning toolbox is `dlarray` . You have to wrap your normal matrix into `dlarray` to use as input to models. This is like `torch.Tensor` in pytorch, this wrap is needed to compute gradient and ease gpu acceleration. 
  * `extractdata` is like `torch.Tensor.numpy()` that you can get your data back from the wrap, but this also breaks the gradient trace for your `dlarray` 
  * `dlarray` has a labelled version and a un-labelled version. Labels will tell the framework whats the meaning of each axis. 
    * Some operation requires a un-labelled `dlarray` some requires a labelled `dlarray` 
  * Note the order of dimension in matlab is different from most python frameworks. Matlab uses `[H,W,C,B]` torch uses `[B,C,H,W]` . Besides, matlab is row (first dim) major array storage, python is column (last dim) major storage. So reshape can be very different in 2.
  * As for weight of conv layer, matlab stores it as `[FilterSize(1),FilterSize(2),NumChannels,NumFilters]`
  * In comparison, PyTorch uses `[out_channels(NumFilters), in_channels(NumChannels), kernel_size ]`
* Neural Networks
  * Neural Networks have `Layers` and a `graph` 
  * `predict` and `activations` seems like the function that calculate the activation like `forward`  
    * `calculateActivations` is the core function underlying it. 
* Gradient Computation
  * In 2019b, matlab auto differentiation is done through `dlgradient` which could compute first order gradient for multiple input function using `dlarray` . However its current usage is not like `torch.autograd` see [example](https://www.mathworks.com/help/deeplearning/ug/include-automatic-differentiation.html ) . It has to be used in a function that gets passed to `dlfeval` . 
  * Currently **it doesn't support higher order derivative** in the backward mode! (like Hessian. So still needs pytorch for Hessian computation. )
    * However if you do artificial forward differentiation to approximate the Hessian! There you only first order gradients. 

```matlab
[f,g] = dlfeval(@model,net,dlX,t);

function [f,g] = model(net,dlX,T)
% Calculate objective using supported functions for dlarray
    y = forward(net,dlX);
    f = fcnvalue(y,T); % crossentropy or similar
    g = dlgradient(f,net.Learnables); % Automatic gradient
end
```
```matlab
x0 = dlarray([-1,2]);
[fval,gradval] = dlfeval(@rosenbrock,x0)

function [y,dydx] = rosenbrock(x)
% calculate the dlgradient inside the function within dlfeval
    y = 100*(x(2) - x(1).^2).^2 + (1 - x(1)).^2;
    dydx = dlgradient(y,x);
end
```

* Weight Initialization
  * Matlab provides some init algorithms like `glorot` (`Xavier` in torch) `He` (`Kaiming` in torch). 
* Learning Control
  * `WeightLearnRateFactor` can control the weight learning in each layer. like `requires_grad` in pytorch.


# Peripheral Functionalities

##  Tensorflow

* `Tensorboard`  awesome visualization for the training phase! 
  * It can also visualize the computational graph as well! 
* `Lucid`  awesome infrastruture to visualize and interpret deep neural networks. 
* Input pipeline of Tensorflow, is well handled by `tf.data` 
  * [Build tensorflow pipeline](https://www.tensorflow.org/guide/data) 

## PyTorch

* `torch.nn.DataParallel` is a great tool, makes parallelized training at almost no cost! 
* PyTorch support tensorboard now! (Through tensorboardX in older versions.)
* In parallel `Lucent` came out in May 2020 as a pytorch version of `Lucid`. 



## See also

[Pytorch vs Tensorflow](https://towardsdatascience.com/pytorch-vs-tensorflow-spotting-the-difference-25c75777377b)