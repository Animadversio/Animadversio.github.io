---
layout: post
title: How to translate matlab code into python (numpy)
# img: "assets/img/portfolio/WormHoleVisualize2.png"
# feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
use_math: true
comments: true
date: Sept. 10th, 2018
tags: [matlab, python, coding]
---
Just like written languages, different programming languages have different innate styles, which suit different needs. Like Matlab love matrix, love script; python favors tensor, favors subfunction, favors objective-oriented programming; Mathematica are muchly functional; R are better at datatable demonstration. 

But if we just want to translate an algorithm from one language to another, we can do so. 

**Objective** : If we have a script in matlab, how can we translate that into python. (`numpy` and `matplotlib`)

* General
    * Replace all the comment mark `%` with `#`. use `''''''` for multiline. 
    * Discard all `end` and corret the indentation by tab
    * Line break `...` in mat , `\` in python
    * `lambda` is protected in python, use another var name
* Operators
    * `^` in matlab = `**` in python
    * `.*` `./` `.^` in matlab = default operator in `numpy`
    * Matrix transpose `'` into `.T`
    * Matrix multiplication `*` in matlab, `.` in Mathematica, but not easy in python. Seems for 2 `ndarray`, `A@B` do the job in numpy! 
+ Indexing
    + Matlab indexing using `( , )`, python using `[ , ]`. Mathematica using `[[, ]]`
    * Matlab start from `1` end in `end`, numpy from `0` to ``(nothing)
+ Number Array
    * Matlab use `strt:step:end` numpy use `range(strt,end,step)`
    * And use `np.arange` for actual array. 
    * `size` in matlab, `len()` in python
    * `[;]` can represent break the row in matlab, but cannot do so in python. 
+ Flow Control 
    * `for i=1:2:10` to `for i in range(1,10,2): `
    * Note add `:` to any control command. 
+ subfunction define
    + in matlab 
```matlab
    function out=Y(in) 
                    .... 
    end 
```
    + in python
```python
def Y(param):
    return out
```
* Complicated control of `ndarray` and `matrix` in numpy
    - Reduce into 1D: `M.flat` return iterator, `M.flatten()` return a 1_D array



