---
layout: post
title: Debugging StyleGAN2 in PyTorch
author: Binxu Wang
date: June 10th, 2020
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

As torch cuda compilation of these pytorch operators doesn't work then I choose to find and debug the native pytorch implementations of it and just use them. 

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





Finally the moment of faith! 

```bash
python generate.py --ckpt stylegan2-ffhq-config-f.pt --size 1024
python generate.py --ckpt model.ckpt-533504.pt --size 512
```



https://libraries.io/pypi/torch-dwconv