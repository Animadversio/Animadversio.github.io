---
layout: post
title: Compiling C Extensions for PyTorch
author: Binxu Wang
date: Sep 15th, 2020
comments: true
categories: [machine learning, coding]
tags: [tech note, Machine Learning, Computer Vision, debug]

---

# Note on Compiling Torch C Extensions

## Motivation

Sometimes fusing operations in C library without using python can accelerate your model, especially for key operations that occurs a lot and lots of data pass through. 

Here I'm taking notes from this [Tutorial on CPP Extension](https://pytorch.org/tutorials/advanced/cpp_extension.html), and experiment on it on my own. 

## Method

Basically 2 methods are provided, setup and compile the C codes into library beforehand or compile and load them as modules on the fly. 

### Pre-compiling

First you write a `setup.py` file, like this, to specify CUDA and cpp source code to compile. 

```python
from setuptools import setup, Extension
from torch.utils import cpp_extension
import os
module_path = os.path.dirname(__file__)
setup(name='op_cpp',
  ext_modules=[cpp_extension.CUDAExtension(name="fused",
         sources=["fused_bias_act.cpp",   "fused_bias_act_kernel.cu"], include_dirs=cpp_extension.include_paths(),),
                   cpp_extension.CUDAExtension(name="upfirdn2d",
         sources=["upfirdn2d.cpp", "upfirdn2d_kernel.cu"],include_dirs=cpp_extension.include_paths(),),
                   ],
      cmdclass={'build_ext': cpp_extension.BuildExtension})
```

And then build the module by running `python setup.py install` in the folder of the cpp and cu files, and then you will get your packages ready to be imported. 

For Windows users, commonly we compiled using `cl.exe` and we need to setup environment for it like running this. (For different architecture you can run `vcvarsall.bat [cfg]` + your architecture. )

```bash
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"
```

After compile succeeded you are finally done! 

When you are using the module it's super easy, and you get rid of the dependency on c things during compilation. 

```python
import fused
```

### Just in Time Compilation

This code will compile + load the module `fused` into the script and you can use it just like `fused.fused_bias_act(grad_output, empty, out, 3, 1, negative_slope, scale)` 

```python
import torch
from torch.utils.cpp_extension import load
module_path = os.path.dirname(__file__)
fused = load(
     "fused",
     sources=[
         os.path.join(module_path, "fused_bias_act.cpp"),
         os.path.join(module_path, "fused_bias_act_kernel.cu"),
     ], verbose=True,
     extra_ldflags=['c10_cuda.lib'],
)
```

Everytime when you are loading that module this will run (and compile is the compilation setting changed) . Output basically reads like this. 

```log
Using C:\Users\Public\Documents\Wondershare\CreatorTemp\torch_extensions as PyTorch extensions root...
Detected CUDA files, patching ldflags
Emitting ninja build file C:\Users\Public\Documents\Wondershare\CreatorTemp\torch_extensions\fused\build.ninja...
Building extension module fused...
Allowing ninja to set a default number of workers... (overridable by setting the environment variable MAX_JOBS=N)
ninja: no work to do.
Loading extension module fused...
Using C:\Users\Public\Documents\Wondershare\CreatorTemp\torch_extensions as PyTorch extensions root...
Detected CUDA files, patching ldflags
Emitting ninja build file C:\Users\Public\Documents\Wondershare\CreatorTemp\torch_extensions\upfirdn2d\build.ninja...
Building extension module upfirdn2d...
Allowing ninja to set a default number of workers... (overridable by setting the environment variable MAX_JOBS=N)
ninja: no work to do.
Loading extension module upfirdn2d...
```

