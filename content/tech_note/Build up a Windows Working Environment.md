---
layout: post
title: Windows Working Environment Build Up (Updating)
author: Binxu Wang
date: Dec 19th, 2019
comments: true
categories: [machine learning, coding]
tags: [tech note, coding, Windows, environment, Computation, Machine Learning]
---
* TOC
{:toc}
# Deep Learning Environment

Currently we find that multiple version of CUDA could be installed on windows. And different frameworks could use different CUDA version nicely together. 

## PyTorch Tensorflow Co-environment

Currently, we can have 

* `pytorch 1.3` `torchvision 0.4.2`and `tensorflow 1.15` live together, 
* with 
  * Python 3.7
  * CUDA 10.0 and CUDA 10.1 both installed. 
  * NVIDIA Driver Version: 432.00. 
  * `numpy` version 1.16.4
* `cudnn` version
  *  `<unknown>::cudnn-7.6.4-cuda10.0_0 --> anaconda::cudnn-7.6.5-cuda10.1_0`

## Keras Tensorflow co-environment

If we want `keras` as well, refer to [this post](https://github.com/antoniosehk/keras-tensorflow-windows-installation) for installation guide on keras-gpu installation on windows.

**Note**, never open 2 tf instances at once on a computer, if so, try to kill the new tf by using `nvidia-smi` and `kill`

## PyTorch Caffe Co-environment

See [Working with Caffe](Working-with-Caffe.md) for more info! 

The easiest way is using the the conda export file to copy the same environment. See the attached [caffe-torch](..\assets\resource\caffe-torch.yml)  [tf-torch.yml](..\assets\resource\tf-torch.yml)  for more information. 

```bash
conda create --name caffe36 --file caffe36_spec-file.txt
conda create -f caffe-torch.yml
```

Then it will download and install all the packages with the required source and version

```bash
conda activate caffe36
```



To export such files there are usually 2 ways, switch to the environment you wish to export and use these commands. 

```bash
conda list --explicit > spec-file.txt
conda env export > environment.yml
```

https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#

[Post on export environment with conda.](https://medium.com/@shandou/export-and-create-conda-environment-with-yml-5de619fe5a2) 



# GFW evading

If you are in China and you need to use a GFW censorship evading tool, see this, 

https://blog.hiaoxui.com/blog/post/hiaoxui/ssr-manual-zh