---
layout: post
title: Transporting Data Between Matlab, Python
author: Binxu Wang
# use_math: true
math: true
comments: true
date: 2020-04-26
categories: [coding]
tags: [python, matlab, data]
---

## Motivation



## Common Formats

Some formats are really common, so that python and matlab both have standard way to import, read and write. So these can be a common 

### json, yaml

Simple python dictionary could be easily dumped in `yaml` `json` formats, which record the hierachical structure and can store small amount of array data. The best part is it's human readable. So it's really suitable to  store short configuration files. 

For matlab, you need some extra script to write them



For python, you need



### csv, excel

These are common format the store well structured data. 

Matlab has `readtable`, `writetable` 

Python has the various `io` functions in `pandas` 

### Image formats

Images are well supported in both. Thus store a large array as a raw image is a thinkable way. 



## Matlab 2 Python

Matlab has its own format `mat`, which is default serialization choice. Note that it has multiple versions, `v6` and `v7.3` are quite different. The former could be easily read in Python, but the latter couldn't. 

So if we could, we should store data in `-v6` to import in python. 



Read `scipy` 's tutorial for more info of how different structures in matlab could be imported. 

https://docs.scipy.org/doc/scipy/reference/tutorial/io.html



### H5py

If we could not read through `scipy.io.loadmat` then we have a bigger problem. 





## Python 2 Matlab

Python's default serialization choice is `pickle` thought `h5py` and `npy` `npz` are popular as well. 

Matlab has function to read `npy` 

