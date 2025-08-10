---
layout: post
title: Linux Working Environment Build Up (Updating)
author: Binxu Wang
date: 2019-07-25
comments: true
categories: [machine learning]
tags: [tech note, coding, Linux, environment, Computation, Machine Learning]
---
* TOC
{:toc}

# Objective
Build the software environment for **Scientific Computing** **Data Analysis** and **Deep Learning** for a GPU enabled Linux work station. 

This post majorly summarizes the tools and references for building up a Linux Working Environment. I'll update the errors and trouble shooting notes as I encounter them. 

# Software System
* Anaconda (python)
	* tensorflow
	* keras
	* pytorch
		* https://pytorch.org/get-started/locally/
* Matlab
* Julia

The software above can all be installed easily, even without using `sudo`. The binary files of them can be written in the home folder of your user. 

Other utilities
* `htop` like the task manager in Windows.

## Caffe
**Caffe is the most difficult platform to build and install!!!!!** 

Ubuntu 18 install is just as easy as `sudo apt install` https://caffe.berkeleyvision.org/install_apt.html 
Other version Ubuntu needs `make` and `compilation`

After that you can use `caffe` command in your terminal to use the binary (language independent). If you want to use it in `Python` or `Matlab` more work should be done. 

conda can install `caffe` and `caffe-gpu`
`conda install caffe`

## Tensorflow
uninstall and reinstall tensorflow in conda environment could solve many problems. 

**Testing**: `import tensorflow as tf; tf.Session()` usually is enough. 

## Deeplabcut
[Linux install guide](https://github.com/AlexEMG/DeepLabCut/blob/master/docs/installation.md#step-3-easy-install-for-windows-and-macos-use-our-supplied-anaconda-environments)

Using 3.7 may encounter error in `pip install deeplabcut` so it may be better to open a `python=3.6` environment and install deeplabcut there. 

## Torch

Torch is another super popular system and install it seems much simpler than the other 2 frameworks. 

```bash
conda install -c anaconda pytorch-gpu
conda install -c anaconda torchvision
conda install pillow=6.1 # in case of PIL import error
conda install matplotlib
```



# CUDA and GPU
CUDA and GPU is a major source of trouble in building a workstation. 

Download the CUDA and the driver could be installed with CUDA. (In our case `CUDA 10.0` is totally usable)
Linux system seems to be very sensitive to GPU driver, CUDA version and driver version must match quite well. 

## Trouble Shooting
if 
`NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA driver`
Reinstall Nvidia driver and CUDA and the package will be fine. 
Install packages may broke some of the kernal / driver. 
[](https://stackoverflow.com/questions/42984743/nvidia-smi-has-failed-because-it-couldnt-communicate-with-the-nvidia-driver)

## Useful testing binaries
Used to query the state and driver and compatibility of programs and other specs. 
```bash
(base) wangbx@tao-cbi315:~/NVIDIA_CUDA-10.0_Samples/bin/x86_64/linux/release$ cat /proc/driver/nvidia/version
NVRM version: NVIDIA UNIX x86_64 Kernel Module  410.48  Thu Sep  6 06:36:33 CDT 2018
GCC version:  gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1) 
```
Check [cuda-installation-guide-linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#running-binaries)

After installation, the [samples](https://docs.nvidia.com/cuda/cuda-samples/index.html) src file will be put in `/usr/local/cuda/samples` binary file is not accompanied in the folder, so you should compile it to somewhere. (if you don't have `root` authority, then somewhere in your home folder is fine~)
Use `cuda-install-samples-10.1.sh <target_path>` to install

Some useful testing binaries like `./deviceQuery` 
```bash
(base) wangbx@tao-cbi315:~/NVIDIA_CUDA-10.0_Samples/bin/x86_64/linux/release$ ./deviceQuery
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce RTX 2080 Ti"
  CUDA Driver Version / Runtime Version          10.0 / 10.0
  CUDA Capability Major/Minor version number:    7.5
  Total amount of global memory:                 10986 MBytes (11519983616 bytes)
  (68) Multiprocessors, ( 64) CUDA Cores/MP:     4352 CUDA Cores
  GPU Max Clock rate:                            1605 MHz (1.61 GHz)
  Memory Clock rate:                             7000 Mhz
  Memory Bus Width:                              352-bit
  L2 Cache Size:                                 5767168 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  1024
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 3 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.0, CUDA Runtime Version = 10.0, NumDevs = 1
Result = PASS
```

[`CUDA_VISIBLE_DEVICES` EV](https://www.jianshu.com/p/0816c3a5fa5c) is used to tell programs like tensorflow which GPU to use (and which not to use). 

# Status Checking Commands
## Check Library
`ldconfig -v`
export relevant dir of lib by `LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/lib/opencv-3.4.6/'`

## Disk usage and mounting
```bash
du * # disk usage
	-s #summarize the files in the folder
	-h #human readable
df # disk free space(for mounted file system), very helpful
	-h #human readable
fdisk # display partitions (may need sudo)
	-l # list
```

# Remote Working

## ssh solution
`ssh -X ....` `ssh -Y ....` Graphic interface forwarding. Requires the remote machine has graphical interface like `gnome`! 

## Jupyter notebook
Most generic, even with GUI-less server. 
[Reference](https://towardsdatascience.com/running-jupyter-notebooks-on-remote-servers-603fbcc256b3)
Open the jupyter notbook in one terminal 
`nohup ssh -f username:password@remote_server_ip "cd project_folder; . virtual_environment/bin/activate; jupyter notebook --no-browser --port=8889"`
Port forwarding 
`nohup ssh -N -f -L localhost:8891:localhost:8891 wangbx:wangbx@tlab.ink`

Then you can see your jupyter notebook in any browser by `localhost:8891`

### Conda env selection in jupyter notebook
Many times, we work with multiple conda env in python, we can use this `nb_conda` package to enable environment selection
`conda install nb_conda`

## PyCharm Remote Interpreter / Environment
Quite generic, just use environment, can be used without graphics. 

## Remote Desktop Solution
* TeamViewer (QUITE GENERIC! ALL PLATFORM)
* Google Remote Desktop (*Need google connection....* Relatively high speed flexible!)
* MobaXterm (Only available to Windows.)
* VNC (Mac √ )
* x2go (Mac √ )


# File transfer 
Direct disk mounting like `mount` 

`scp` file transfer

* FileZilla
* TeamViewer
* GoogleRemoteDesktop


Ref https://blog.csdn.net/marchfaith/article/details/7562442