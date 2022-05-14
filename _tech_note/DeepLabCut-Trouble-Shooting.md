---
layout: post
title: DeepLabCut Trouble Shooting
author: Binxu Wang
date: July.2nd, 2019
comments: true
categories: [Neuroscience, machine learning]
tags: [tech note, Image Analysis, Machine Learning, Behavior]
typora-copy-images-to: ..\assets\img\notes\dlc
---

DeepLabCut Trouble Shooting
======
@(Ponce Lab)
* TOC
{:toc}

# Install DLC
Windows machine, follow the steps in 	[install tutorial](https://github.com/AlexEMG/DeepLabCut/blob/master/conda-environments/README.md) to establish the whole conda environment in the machine. 
## Fail at first step
Many of us just fail at first step, some error message like 
```tex
Solving environment: failed

ResolvePackageNotFound:
  - msvc_runtime
```
According to some [reference](https://blog.csdn.net/langjijianghu_123/article/details/80923293#comments), you can just hack the YAML file and move the error related lines down to `pip:` part. It will look like this 
```yaml
name: dlc-windowsGPU
dependencies:
  - python=3.6
#  - msvc_runtime
  - tensorflow-gpu==1.13.1
  - cudnn=7
  - wxpython
  - jupyter
  - pytables==3.4.4
  - pip:
    - deeplabcut
    - msvc_runtime
```
For other errors like conflicting requirements, you should do 
```tex
Error message to be added
```
This 

# Runtime TroubleShooting

## Jupyter notebook environment checking
Note `DeepLabCut` lives in a `conda` environment so we have to check if Jupyter notebook is using python and packages from the correct environment! Or the import will be problematic. 

So normally we activate the environment first and then start the notebook. 
```bash
conda activate dlc-windowsGPU
D:
jupyter notebook
```
First we would like to install the extension for notebook `conda install nb_conda` so that you will have link in jupyter to start a notebook in the environment
![Alt text](..\assets\img\notes\dlc\1562091943732.png)

## Check Training progress
Change into the log directory (which contains all the `events.out.tfevents` files) and use `tensorboard` to check the log file. 
```bash
cd D:\MacaqueFaceRecogition\MacaqueFace-DLC2\Head-Free-Viewing-CRP-2019-07-01\dlc-models\iteration-0\Head-Free-ViewingJul1-trainset95shuffle1\train\log
tensorboard --logdir=. 
```

## DLC installation issue
If there is a previous version of DLC reside in somewhere in conda, you'd better uninstall it totally. 
Use 
```python
import deeplabcut as dlc
dlc.__file__
```
To check you are importing `dlc`  from the right place. If not you may encounter an error here. And you'd better reinstall the deeplabcut and the environment. 

## Pytables Issue
When running the `label_frames` or 
```tex
ImportError                               Traceback (most recent call last)
C:\ProgramData\Anaconda3\envs\dlc-windowsGPU\lib\site-packages\pandas\io\pytables.py in __init__(self, path, mode, complevel, complib, fletcher32, **kwargs)
    444         try:
--> 445             import tables  # noqa
    446         except ImportError as ex:  # pragma: no cover

C:\Users\ponce\AppData\Roaming\Python\Python36\site-packages\tables\__init__.py in <module>()
     92 # Necessary imports to get versions stored on the cython extension
---> 93 from .utilsextension import (
     94     get_pytables_version, get_hdf5_version, blosc_compressor_list,

ImportError: DLL load failed: The specified procedure could not be found.
```
The result is it will save your points coordinates in a `csv` file but cannot save it in the `h5` file which is needed for training and evaluation. 

It's majorly a `pytables` version problem. 

Current solution 
```bash
conda uninstall pytables 
conda install -c conda-forge pytables=3.4.3
pip install --upgrade deeplabcut
```
And don't panic if you encounter this bug, your label coordinate does not lost but is stored in the `csv` file. So using `dlc.convertcsv2h5(path_config_file)` will rescue the `csv` file and generate `h5` file. You may debug the `pytables` problem and then run this command. 

## CUDA Issue 
When running `train_network` you may encounter the error
```tex
InternalError: cudaGetDevice() failed. Status: CUDA driver version is insufficient for CUDA runtime version
```
https://blog.kovalevskyi.com/multiple-version-of-cuda-libraries-on-the-same-machine-b9502d50ae77

**Solution**: Install CUDA 10.x and most recent GPU driver and **restart** your system
### Additional Note: How to specify CUDA version for the environment
In some system, we may need to set the environment variable to notify Tensorflow of the correct CUDA to use in the current environment. 
```bash
#!/bin/sh
export LD_LIBRARY_PATH=$ORIGINAL_LD_LIBRARY_PATH
unset ORIGINAL_LD_LIBRARY_PATH
```
```bat
set ORIGINAL_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
set export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:/usr/local/cuda-9.0/extras/CUPTI/lib64:/lib/nccl/cuda-9:$LD_LIBRARY_PATH
```
https://stackoverflow.com/questions/31598963/how-to-set-specific-environment-variables-when-activating-conda-environment


## Test GPU availability to Tensorflow
To test the the GPU acceleration for Tensorflow is working I recommend [this scipt](https://stackoverflow.com/questions/38009682/how-to-tell-if-tensorflow-is-using-gpu-acceleration-from-inside-python-shell). 
```python
import tensorflow as tf
tf.logging.set_verbosity(tf.logging.DEBUG)
with tf.device('/gpu:0'):
    a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
    b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
    c = tf.matmul(a, b)

with tf.Session() as sess:
    print (sess.run(c))
```
Then you will see things in the notebook or the console like this, showing that the GPU is utilized and visible to tensorflow. 
```tex
2019-07-02 12:54:46.169115: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX AVX2
2019-07-02 12:54:46.328165: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1433] Found device 0 with properties:
name: GeForce GTX 1060 6GB major: 6 minor: 1 memoryClockRate(GHz): 1.835
pciBusID: 0000:01:00.0
totalMemory: 6.00GiB freeMemory: 4.97GiB
2019-07-02 12:54:46.332011: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1512] Adding visible gpu devices: 0
2019-07-02 12:54:46.780035: I tensorflow/core/common_runtime/gpu/gpu_device.cc:984] Device interconnect StreamExecutor with strength 1 edge matrix:
2019-07-02 12:54:46.782437: I tensorflow/core/common_runtime/gpu/gpu_device.cc:990]      0
2019-07-02 12:54:46.784090: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1003] 0:   N
2019-07-02 12:54:46.785529: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1115] Created TensorFlow device (/job:localhost/replica:0/task:0/device:GPU:0 with 4716 MB memory) -> physical GPU (device: 0, name: GeForce GTX 1060 6GB, pci bus id: 0000:01:00.0, compute capability: 6.1)
```
Similarly using this line can also tell you what device is available 
```python
from tensorflow.python.client import device_lib
print(device_lib.list_local_devices())
```
Output like 
```tex
[name: "/device:CPU:0"
 device_type: "CPU"
 memory_limit: 268435456
 locality {
 }
 incarnation: 5904775635136544004, name: "/device:GPU:0"
 device_type: "GPU"
 memory_limit: 4945621811
 locality {
   bus_id: 1
   links {
   }
 }
 incarnation: 6075035587783531498
 physical_device_desc: "device: 0, name: GeForce GTX 1060 6GB, pci bus id: 0000:01:00.0, compute capability: 6.1"]
```

### Show debugging information from Tensorflow

If you cannot see the debugging information either in notebook or in the console, you may need to add this line to the front of the code. 
```python
import tensorflow as tf
tf.logging.set_verbosity(tf.logging.DEBUG)
```
We should do this line before importing the `deeplabcut`(DLC imported tensorflow inside the package, so import it again will not change the settings.). Thus we will see the debugging information in the console! 

