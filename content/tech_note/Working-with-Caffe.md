---
layout: post
title: Working with Caffe
author: Binxu Wang
date: 2019-10-27
comments: true
categories: [machine learning, coding]
tags: [tech note, Machine Learning, Computer Vision]
---

## Installation

Official note on installation https://caffe.berkeleyvision.org/installation.html

### Installing CPU version on CHPC

* Install [Miniconda]()

* Install caffe using conda`conda install -c intel caffe`



> lsb_release -d
> Description:    CentOS release 6.10 (Final)

### Building GPU version on CHPC

(Not succeeded yet.... aborted)

1. Check `gcc` version to be 4.8.5 `module load gcc-4.8.5`
2. Check cmake version to newer than 3 `module load cmake-3.14.5`

**Reference** 

 http://www.andrewjanowczyk.com/installing-caffe-on-the-ohio-super-computing-osc-ruby-cluster/ 

http://homepage.cs.uiowa.edu/~zli79/notes/Installation_Caffe_on_Argon_Cluster.pdf

### Installing GPU version on CHPC

https://anaconda.org/anaconda/caffe-gpu

Just use miniconda, and `conda install -c anaconda caffe-gpu`

### Installing GPU version on Windows machine

The easiest way is using the the conda export file to copy the same environment. See the attached [caffe-torch](..\assets\resource\caffe-torch.yml)  [tf-torch.yml](..\assets\resource\tf-torch.yml)  for more information. 

```bash
conda create --name caffe36 --file caffe36_spec-file.txt
conda create -f caffe-torch.yml
```

Then it will download and install all the packages with the required source and version

```bash
conda activate caffe36
```

Check onenote for more debugging note. 

If some dlls are missing `MSVCP140D.DLL, VCRUNTIME140D.DLL`, download them from net and put it in  `C:\Windows\System32`. 

## Testing Installation

If on CHPC, start by submitting a gpu job `qsub -I -l nodes=1:ppn=1:gpus=1,walltime=01:00:00 `

After downloading some weights for models by using 

```bash
python download_model_binary.py ../models/bvlc_reference_caffenet/
```

We have enough material to test loading a network into memory. 

Test CPU installation, 

```python
import caffe
import os.path
caffe.set_mode_cpu()
net_weights = os.path.join("/home/binxu/caffe/models/bvlc_reference_caffenet/", 'bvlc_reference_caffenet.caffemodel')
net_definition = os.path.join("/home/binxu/caffe/models/bvlc_reference_caffenet/", 'deploy.prototxt')
net = caffe.Net(net_definition, caffe.TEST, weights=net_weights)

net.blobs['data'].data[...] = 1
net.forward(end='fc6')
```

Test GPU installation, just use `caffe.set_mode_gpu()`

[Berkeley Model zoo](http://caffe.berkeleyvision.org/model_zoo.html )



## Converting Caffe Model to PyTorch

As some operations are much easier in some newer frameworks like `PyTorch`, there is a need to convert existing model in `Caffe` to `PyTorch`. 

There is some existing packages target at interpret `proto` of caffe and build network according to that in PyTorch, e.g. [pytorch-caffe]( https://github.com/marvis/pytorch-caffe ). However, to support some layer specific to Caffe, we need to add some modification to the package! See [LRN](#Local Response Normalization)

```python

```

### Data loading and transformation

From the documentation of `caffe.io.Transformer` we can see that 

> Format input for Caffe:
> - convert to single
> - resize to input dimensions (preserving number of channels)
> - transpose dimensions to K x H x W
> - reorder channels (for instance color to BGR)
> - scale raw input (e.g. from [0, 1] to [0, 255] for ImageNet models)
> - subtract mean
> - scale feature
> 
> Parameters
> in_ : name of input blob to preprocess for
> data : (H' x W' x K) ndarray
>
> Returns
> caffe_in : (K x H x W) ndarray for input to a Net
>

The input convention for Caffe is 4 dimension array in the order of [B, C, H, W]. And for color image, the color channel is in the order of BGR. 

So the output from a network built in Caffe have to be transformed by a function to visualize. 

### Pipelining Caffe networks in PyTorch

However, if that output is directly sent into the other network, then the 2 networks can pipe into each other except for one thing. 

Standard `preprocess`

* `resize`
* `transpose` the axis to C,H,W
* `swap` the channel to BGR
* `scale` by * 255
* centralize by `-meanBGR_value`

Standard `deprocess`

* de-centralize by `+ meanBGR_value`
* `scale` by `/ 255`
* `swap` the channel to RGB
* `transpose` the axis to H,W,C
* `clip` the tensor to be within `(0,1)` 

So the 2 process are inverse to each other except for `clip` part. 



### Local Response Normalization

This is an ancient module exists in AlexNet and CaffeNet, but largely abandoned in more recent network architectures. At first, it's inspired by lateral inhibition just like those happened in biological visual networks. However, it's not very stable, and help only in certain cases but not others. 

Thus, it's not officially supported in PyTorch for a long time, but currently it is supported. 

[Caffe LRN Doc](https://caffe.berkeleyvision.org/tutorial/layers/lrn.html )

[PyTorch LRN Doc](https://pytorch.org/docs/stable/nn.html#localresponsenorm) 







