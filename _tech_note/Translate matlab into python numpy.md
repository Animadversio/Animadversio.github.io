---
layout: post
title: How to translate matlab code into python (numpy)
# img: "assets/img/portfolio/WormHoleVisualize2.png"
# feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
use_math: true
comments: true
date: Sept. 10th, 2018
categories: [coding]
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
    
    * Note one of the super useful thing in matlab is `find` i.e. find all the none zero entries' index. **Python doesn't have function with exactly the same functionality**.  
    
      * `np.non_zero`, `np.where` may be a choice for numpy arrays, but the indices it returns are more complex, you need to extract it from tuple.  `ii = np.where(values == searchval)[0]`
    
      * `[i for i, x in enumerate(my_list) if x == "whatever"]` may be a quick way to do so for lists. 
    
+ Number Array
    * Matlab use `strt:step:end` numpy use `range(strt,end,step)`
    * And use `np.arange` for actual array. 
    * `np.array` has a little bit complex control of dimension: all 1-d array (even vertical ones) are neither 1*n nor n*1 thus has to be reshaped to do matrix multiply! 
    * `size()`, `length()` in matlab, `len()` in python
    * `[;]` can represent break the row in matlab, but cannot do so in python. 
    * Append with `+` or `[].append()` in Python; `list = [list, new_itm]` in Matlab
    
+ Dictionary and Struct and Cell
  
    * In matlab, no `dict` to use! `struct` is similar, you can add fields to a `struct` object
    * `struct` is also good for structured array data! 
      * `repmat(struct('image',[],'eig',[]),1,10)`  can create an array of structure which is easy to 
    * Matlab `cell` is like the python `list` which is a universal container for any heterogenous things. 
    
+ String and Printing

    + Python string is so easy to use `"%s-%d" % (str,int)` syntax can perform string formatting anywhere; Matlab has more cumbersome syntax, with several choices
        *  `sprintf(%s-%d", (str,int))` 
        *  `compose(%s-%d", (str,int))` 
    * Python print function `print` is so flexible. Matlab counterpart is `disp` but more for display array and structure instead of string
    * Python `print(str)` will implicitly add `\n` to the end to change line. For Matlab, `fprintf` will not add `\n` you have to add yourself. But `disp` will change line automatically 

+ Flow Control 
    * `for i=1:2:10` to `for i in range(1,10,2): `
    * Note Python add `:` to any control command; Matlab don't
    
+ Common command
    * Print out words: In Python, `print("%.f, %.d".%( x, arg2))`; In matlab `fprintf("x: %.1f, arg1: %d", x, arg2)`. Or using `disp(var)`
    * Formatted string control: In python, `"%.f, %.d".%( x, arg2)`, in matlab `str = sprintf("x: %.1f, arg1: %d", x, arg2)`
    
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

## Let Matlab and Python Talk to Each Other

* For common non-binary file types, they usually have good readers like 
  * `csv` , python `import csv`
  * `json` 
  * Which are good for exchange of configurations and string information
* `.mat` format could be read in python, with some drawbacks
  * Old simple `.mat` files could be read by `scipy.io.loadmat`
  * new `.mat` files (v7.3+) could be read by `h5py.File`
    * The matrix and tensor will be read directly as datasets
    * But the objects will be formed in a reference array, and you feed the reference back to the file to get the object into python. See [Refs in h5py](http://docs.h5py.org/en/latest/refs.html). 
* `.npy` format could be read in matlab 

