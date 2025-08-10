---
layout: post
title: Debugging StyleGAN2 in PyTorch
author: Binxu Wang
date: June 10th, 2020 (Updates Sep 15th)
comments: true
categories: [machine learning, coding]
tags: [tech note, Machine Learning, Computer Vision, debug]
---

## Environment Bug

https://github.com/rosinality/stylegan2-pytorch/issues/70

**Compiler not found bug**

We need to change `compiler_bindir_search_path` in  `./stylegan2/dnnlib/tflib/custom_ops.py`Need to be changed to have the C compiler on the machine. Note Visual Studio 2019 is not supported so have to use 2017! 



**Tensorflow Header Bug** 

```log
Cannot open include file: 'tensorflow/core/framework/op.h'
```

So I have to rename `tensorflow_core` in `C:\ProgramData\Anaconda3\envs\tf\Lib\site-packages\tensorflow_core\include` as `tensorflow` . Then it worked. 

## Operators Bug

As torch cuda compilation of these pytorch operators doesn't work, one solution is to find and debug the **native pytorch implementations of it** and just use them. 

```python
import torch.nn.functional as F
def fused_leaky_relu(input, bias, negative_slope=0.2, scale=2 ** 0.5):
    return scale * F.leaky_relu(input + bias.view((1, -1)+(1,)*(len(input.shape)-2)), negative_slope=negative_slope)
```

```python
def upfirdn2d_native(
    input, kernel, up_x, up_y, down_x, down_y, pad_x0, pad_x1, pad_y0, pad_y1
):
    input = input.permute(0, 2, 3, 1)
    _, in_h, in_w, minor = input.shape
    kernel_h, kernel_w = kernel.shape
    out = input.view(-1, in_h, 1, in_w, 1, minor)
    out = F.pad(out, [0, 0, 0, up_x - 1, 0, 0, 0, up_y - 1])
    out = out.view(-1, in_h * up_y, in_w * up_x, minor)

    out = F.pad(
        out, [0, 0, max(pad_x0, 0), max(pad_x1, 0), max(pad_y0, 0), max(pad_y1, 0)]
    )
    out = out[
        :,
        max(-pad_y0, 0) : out.shape[1] - max(-pad_y1, 0),
        max(-pad_x0, 0) : out.shape[2] - max(-pad_x1, 0),
        :,
    ]

    out = out.permute(0, 3, 1, 2)
    out = out.reshape(
        [-1, 1, in_h * up_y + pad_y0 + pad_y1, in_w * up_x + pad_x0 + pad_x1]
    )
    w = torch.flip(kernel, [0, 1]).view(1, 1, kernel_h, kernel_w)
    out = F.conv2d(out, w)
    out = out.reshape(
        -1,
        minor,
        in_h * up_y + pad_y0 + pad_y1 - kernel_h + 1,
        in_w * up_x + pad_x0 + pad_x1 - kernel_w + 1,
    )
    # out = out.permute(0, 2, 3, 1)

    return out[:, :, ::down_y, ::down_x]
```

Note this native pytorch implementation will decrease forward and backward pass time by a large margin...

Finally the moment of faith! 

```bash
python generate.py --ckpt stylegan2-ffhq-config-f.pt --size 1024
python generate.py --ckpt model.ckpt-533504.pt --size 512
```



https://libraries.io/pypi/torch-dwconv

## Solving Compiling Issue

Major issue faced by this is the just in time compiler in pytorch will call C compiler in the process to compile the c code into library. On the windows platform it's using  `cl.exe` , while on unix `gcc` or `clang` may be used. 

But the `cl.exe` requires **several path variables to know where are the standard libraries**. Usually for `cl.exe` this is set by `vcvar64.bat` . or `vcvarall.bat 64` (use other config for other architecture.) Usually the work flow is to run `vcvarall.bat 64` in a cmd console and then run the python code in the same console, through this, the environment variables will be shared with `cl.exe` 

A possible command to call this `bat` is like 

````cmd
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
````

Thus you can load `StyleGAN2` easily in terminal. But in an IDE, it's harder to call on `vcvarall.bat` to set the environment variables.  As the environment variables will be set into a different process and `cl.exe` know nothing about it....



## Compile Extension Permanently on Windows

The major issue for the method used above is the extension needs to be compiled everytime you restart your process and load the model. So you need to setup `vcvarsall.bat` beforehand to run `cl.exe` . But that requires you to have a command line environment, and many IDE do not have the capability to run `vcvarsall.bat` and then keep all the environment variables set in it. 



So at the end I decided to **compile the extension into a package once and for all**! All we need is to write up a `setup.py` file and compile the `.cpp` `.cu` codes into a library. And then some linking packages will create interface in python to these library to use the compiled functions. 

Following the example in this [tutorial](https://pytorch.org/tutorials/advanced/cpp_extension.html)  the `setup.py` file reads like this, pretty simple. 

```python
from setuptools import setup, Extension
from torch.utils import cpp_extension
import os
module_path = os.path.dirname(__file__)
setup(name='op_cpp',
      ext_modules=[cpp_extension.CUDAExtension(name="fused",
                            sources=["fused_bias_act.cpp", "fused_bias_act_kernel.cu"], include_dirs=cpp_extension.include_paths(),),
                   cpp_extension.CUDAExtension(name="upfirdn2d",
                             sources=["upfirdn2d.cpp", "upfirdn2d_kernel.cu"],include_dirs=cpp_extension.include_paths(),),
                   ],
      cmdclass={'build_ext': cpp_extension.BuildExtension})

```

Note you need to choose `cpp_extension.CUDAExtension` if you are compiling some `.cu` CUDA code. If it's purely `c++` you can use `cpp_extension.CppExtension`. 

Note here you need to run `vcvarsall.bat` first to set up all the variables. And then run the command `python setup.py install` in the `op` folder, to compile the C++ code into a python library. 

```
running install
running bdist_egg
running egg_info
writing op_cpp.egg-info\PKG-INFO
writing dependency_links to op_cpp.egg-info\dependency_links.txt
writing top-level names to op_cpp.egg-info\top_level.txt
reading manifest file 'op_cpp.egg-info\SOURCES.txt'
writing manifest file 'op_cpp.egg-info\SOURCES.txt'
installing library code to build\bdist.win-amd64\egg
running install_lib
running build_ext
building 'fused' extension
creating D:\Github\stylegan2-pytorch\op\build\temp.win-amd64-3.7\Release
Emitting ninja build file D:\Github\stylegan2-pytorch\op\build\temp.win-amd64-3.7\Release\build.ninja...
Compiling objects...
Allowing ninja to set a default number of workers... (overridable by setting the environment variable MAX_JOBS=N)
[1/2] cl /showIncludes /nologo /Ox /W3 /GL /DNDEBUG /MT /MD /wd4819 /EHsc -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\torch\csrc\api\include -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\TH -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\THC -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\torch\csrc\api\include -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\TH -IC:\ProgramData\Anaconda3\envs\tf\lib\site-packages\torch\include\THC "-IC:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.1\include" -IC:\ProgramData\Anaconda3\envs\tf\include -IC:\ProgramData\Anaconda3\envs\tf\include "-IC:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\ATLMFC\include" "-IC:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\include" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\um" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\cppwinrt" "-IC:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\ATLMFC\include" "-IC:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\MSVC\14.27.29110\include" "-IC:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\include\um" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\ucrt" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\shared" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\um" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\winrt" "-IC:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\cppwinrt" -c D:\Github\stylegan2-pytorch\op\fused_bias_act.cpp /FoD:\Github\stylegan2-pytorch\op\build\temp.win-amd64-3.7\Release\fused_bias_act.obj -DTORCH_API_INCLUDE_EXTENSION_H -DTORCH_EXTENSION_NAME=fused -D_GLIBCXX_USE_CXX11_ABI=0 /std:c++14
cl : Command line warning D9025 : overriding '/MT' with '/MD'

[Thousands line of warning.....]

Generating code
Finished generating code
creating build\bdist.win-amd64
creating build\bdist.win-amd64\egg
copying build\lib.win-amd64-3.7\fused.cp37-win_amd64.pyd -> build\bdist.win-amd64\egg
copying build\lib.win-amd64-3.7\upfirdn2d.cp37-win_amd64.pyd -> build\bdist.win-amd64\egg
creating stub loader for fused.cp37-win_amd64.pyd
creating stub loader for upfirdn2d.cp37-win_amd64.pyd
byte-compiling build\bdist.win-amd64\egg\fused.py to fused.cpython-37.pyc
byte-compiling build\bdist.win-amd64\egg\upfirdn2d.py to upfirdn2d.cpython-37.pyc
creating build\bdist.win-amd64\egg\EGG-INFO
copying op_cpp.egg-info\PKG-INFO -> build\bdist.win-amd64\egg\EGG-INFO
copying op_cpp.egg-info\SOURCES.txt -> build\bdist.win-amd64\egg\EGG-INFO
copying op_cpp.egg-info\dependency_links.txt -> build\bdist.win-amd64\egg\EGG-INFO
copying op_cpp.egg-info\top_level.txt -> build\bdist.win-amd64\egg\EGG-INFO
writing build\bdist.win-amd64\egg\EGG-INFO\native_libs.txt
zip_safe flag not set; analyzing archive contents...
__pycache__.fused.cpython-37: module references __file__
__pycache__.upfirdn2d.cpython-37: module references __file__
creating dist
creating 'dist\op_cpp-0.0.0-py3.7-win-amd64.egg' and adding 'build\bdist.win-amd64\egg' to it
removing 'build\bdist.win-amd64\egg' (and everything under it)
Processing op_cpp-0.0.0-py3.7-win-amd64.egg
creating c:\programdata\anaconda3\envs\tf\lib\site-packages\op_cpp-0.0.0-py3.7-win-amd64.egg
Extracting op_cpp-0.0.0-py3.7-win-amd64.egg to c:\programdata\anaconda3\envs\tf\lib\site-packages
Adding op-cpp 0.0.0 to easy-install.pth file

Installed c:\programdata\anaconda3\envs\tf\lib\site-packages\op_cpp-0.0.0-py3.7-win-amd64.egg
Processing dependencies for op-cpp==0.0.0
Finished processing dependencies for op-cpp==0.0.0
```

After compiling and seeing lots of output we will be able to import `upfirdn2d` and `fused` anywhere in the python environment. 

And currently your folder `op` will look like 

```cmd
STYLEGAN2-PYTORCH\OP
│   fused_act.py
│   fused_bias_act.cpp
│   fused_bias_act_kernel.cu
│   setup.py
│   upfirdn2d.cpp
│   upfirdn2d.py
│   upfirdn2d_kernel.cu
│   __init__.py
│
├───build
│   ├───bdist.win-amd64
│   ├───lib.win-amd64-3.7
│   │       fused.cp37-win_amd64.pyd
│   │       upfirdn2d.cp37-win_amd64.pyd
│   │
│   └───temp.win-amd64-3.7
│       └───Release
│               .ninja_deps
│               .ninja_log
│               build.ninja
│               fused.cp37-win_amd64.exp
│               fused.cp37-win_amd64.lib
│               fused_bias_act.obj
│               fused_bias_act_kernel.obj
│               upfirdn2d.cp37-win_amd64.exp
│               upfirdn2d.cp37-win_amd64.lib
│               upfirdn2d.obj
│               upfirdn2d_kernel.obj
│
├───dist
│       op_cpp-0.0.0-py3.7-win-amd64.egg
│
├───op_cpp.egg-info
│       dependency_links.txt
│       PKG-INFO
│       SOURCES.txt
│       top_level.txt
```

And then you can modify the code in `fused_act.py` and `upfirdn2d.py` to import `fused` and ` upfirdn2d` directly instead of loading and compiling them on the fly! 

Through this PyCharm can run StyleGAN2 models as smoothly! 

```python
import upfirdn2d as upfirdn2d_op
# module_path = os.path.dirname(__file__)
# upfirdn2d_op = load(
#     "upfirdn2d",
#     sources=[
#         os.path.join(module_path, "upfirdn2d.cpp"),
#         os.path.join(module_path, "upfirdn2d_kernel.cu"),
#     ], verbose=True,
#     extra_ldflags=['c10_cuda.lib'],
# )
```

```python
import fused
# module_path = os.path.dirname(__file__)
# fused = load(
#     "fused",
#     sources=[
#         os.path.join(module_path, "fused_bias_act.cpp"),
#         os.path.join(module_path, "fused_bias_act_kernel.cu"),
#     ], verbose=True,
#     extra_ldflags=['c10_cuda.lib'],
# )
```





Seems like this is the first time I successfully build / compile a package! 

## Compiling Operator on Linux

Setup the environment and related packages. 

```
module load cuda-10.1
export CUDA_HOME=/export/cuda-10.1
module load cuDNN-7.6.0
module load gcc-5.5.0
```

cublas_v2.h not found error....found in cuda-10.0 folder.

So 

```
module load cuda-10.1
export CUDA_HOME=/export/cuda-10.0
module load cuDNN-7.6.0
module load gcc-5.5.0
python setup.py install
```

```
python generate.py --ckpt /scratch/binxu/torch/StyleGANckpt/ffhq-512-avg-tpurun1.pt --size 512

python generate.py --ckpt /scratch/binxu/torch/StyleGANckpt/stylegan2-ffhq-config-f.pt --size 1024
```



````
RuntimeError: CUDA error: no kernel image is available for execution on the device


````

```
This error is raised if some CUDA code wasn’t compiled for the compute capability of your device.
How did you install PyTorch and which GPU are you using?
```

This is related to the `from op import FusedLeakyReLU, fused_leaky_relu, upfirdn2d` operators. They are not well compiled on gpu

```
import torch
from op import FusedLeakyReLU, fused_leaky_relu, upfirdn2d
tmp = fused_leaky_relu(torch.randn(512,512),torch.randn(1))

tmp = fused_leaky_relu(torch.randn(512,512).cuda(),torch.randn(1).cuda())


upfirdn2d(torch.randn(1,3,10,10).cuda(),torch.randn(3,3).cuda())
upfirdn2d(torch.randn(1,3,10,10),torch.randn(3,3))


g_ema = Generator(
        512, 512, 8, 2
    ).to("cuda")
    checkpoint = torch.load(args.ckpt)
```



**Reference**

* About `vcvarsall.bat`
  * [List and Table of Environment Variables that are Set by VCVARSALL.bat](https://renenyffenegger.ch/notes/Windows/development/Visual-Studio/environment-variables/index) 
  * [Command Line Tools to Build on Windows](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=vs-2019) 
  * [Note for using ninja build on windows](https://github.com/ninja-build/ninja/wiki#windows) 
  * [How to run vcvarsall.bat in the same process as python?](https://stackoverflow.com/questions/14697629/running-a-bat-file-though-python-in-current-process)

> you will never get variables to persist after a process has terminated

* About general build C extension for pytorch
  * [Tutorial on CPP Extension](https://pytorch.org/tutorials/advanced/cpp_extension.html)