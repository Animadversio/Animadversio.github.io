---
layout: post
title: Hybrid Programming Matlab and Python
author: Binxu Wang
# use_math: true
math: true
comments: true
date: 2020-05-15
categories: [coding]
tags: [python, matlab, data, machine learning]

---

## Motivation

This is one step forward from [Data transport between python and matlab]({{< relref "Data-Transport-Python-Matlab.md" >}}), since sometimes you not only want to transport data, but want to share some code in python or matlab. How can we do so?

## Using Python in Matlab

Matlab has official support for python and you can set your python environment within and then code python in matlab. 

**Caveat**: python env is set in a matlab session, you cannot reset it! 

But it's handy if you would like to have some io function or some programming tricks in python but don't want to open a new python for it. 

### Handling Python modules

`import` in matlab means aliasing, not the same as `import` in python. Here is a matlab example. 	

```matlab
import matlab.io.hdf4.sd.readChunk
data = readChunk(ID,[n m]);
```

For real importing you can do `py.importlib.import_module('lucent');` or just type `py.lucent` and the package will load for you. 

To import arbitrary package or module you need to modify path in the matlab python environment like this. 

```matlab
syspath = py.sys.path(); % add the official stylegan2 repo. 
syspath.append("E:\DL_Projects\Vision\stylegan2-pytorch");
py.importlib.import_module('model');
```

Direct append like `py.sys.path.append` does not work! `py.sys.path = syspath;` will create something worse!





*Note*: Currently, matlab can import pytorch 1.3.1 but not 1.5.0. It will throw an error when importing latter. But it seems everything we used are compatible with 1.3.1 . 

```bash
conda install pytorch=1.3.1 torchvision cudatoolkit=10.1 -c pytorch
```

[Supported Python Operators](https://www.mathworks.com/help/matlab/matlab_external/how-matlab-represents-python-operators.html)

[强行混合编程：MATLAB 中调用 .py 脚本函数](https://zhuanlan.zhihu.com/p/42598340)

## Using Matlab in Python

I feel there is less case for this but it's doable. If you really need it, check this out! 

[Python与Matlab混合编程](http://zhaoxuhui.top/blog/2017/12/14/Python与Matlab混合编程.html) 
<!-- [http://zhaoxuhui.top/blog/2017/12/14/Python%E4%B8%8EMatlab%E6%B7%B7%E5%90%88%E7%BC%96%E7%A8%8B.html] -->

```python
import matlab.engine
import time

# 第一步，初始化Matlab的Runtime
t1 = time.time()
eng = matlab.engine.start_matlab()
t2 = time.time()

# 第二步，调用Matlab函数
res1 = eng.sqrt(16.0)
t3 = time.time()

res2 = eng.abs(-8.6)
t4 = time.time()

# 第三步，退出Runtime
eng.quit()
t5 = time.time()
```

```python
import matlab.engine
A = matlab.int8([1, 2, 3, 4, 5])
print(type(A), A.size, A)
```

Plotting is supported as well! 



[Official Doc for language interface](https://www.mathworks.com/help/matlab/external-language-interfaces.html?s_tid=CRUX_lftnav)

