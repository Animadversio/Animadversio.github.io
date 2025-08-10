---
layout: post
title: How to translate matlab code into python (numpy)
# img: "assets/img/portfolio/WormHoleVisualize2.png"
# feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
# use_math: true
math: true
comments: true
date: 2018-09-10
categories: [coding]
tags: [matlab, python, coding]
---
Just like written languages, different programming languages have different innate styles, which suit different needs. Like Matlab love matrix, love script; python favors tensor, favors subfunction, favors objective-oriented programming; Mathematica are muchly functional; R are better at datatable demonstration. 

But if we just want to translate an algorithm from one language to another, we can do so. 

Note: An official table of translation could be looked up here. [numpy for matlab users](https://numpy.org/doc/stable/user/numpy-for-matlab-users.html) . 

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
    
+ Numpy functions 

    * `min` in matlab works element wise, the corresponding function in `numpy` is `minimum` not `min`
    * `numpy` is more sensitive to data type, sometimes you don't need to change data type to `int` to run in matlab. But you have to cast to `int` to run in python. Esp. when doing indexing! 
    + Argument format is quite different for quite a few common functions 
        * `np.zeros` only takes list or tuple of size. if only input one value `np.zeros(3)` it outputs a 1d array
        * `zeros` takes both list and individual values, if only input one value `zeros(3)` it outputs a square mat
    * `norm` in matlab doesn't work for vector norm along 1 axis. `np.linalg.norm` can do this. 

+ Dictionary and Struct and Cell
+ * In matlab, no `dict` to use! `struct` is similar, you can add fields to a `struct` object
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
    
+ Subfunction define
  
    + in matlab 
```matlab
function out=Y(in) 
.... 
end 
```
in python

```python
def Y(param):
    return out
```
## Tricky points

* Complicated control of `ndarray` and `matrix` in numpy
    - Reduce into 1D: `M.flat` return iterator, `M.flatten()` return a 1_D array
    - In matlab `A(:)` will give you a 1d array, but in python `A[:]` will return the same shape.  
    - Aside from reshape there are quite a few handy functions in matlab [See this.](https://www.mathworks.com/help/matlab/math/reshaping-and-rearranging-arrays.html) 
* Array Storage in Memory
    * A subtle difference is the convention of storing multidimensional array in matlab or python. As matlab use column major order, and numpy and torch use row major order. [Major order](https://en.wikipedia.org/wiki/Row-_and_column-major_order) 
    * Note row major is the convention of C, Pascal etc. Column major is the convention of Fortran. (Matlab and Julia inherit this) So in python you can specify these 2 conventions by `C` for row major and `F` for column major. `output=output.reshape((row*col, depth), order='F')` (Really confusing....)
    * Because of this, the 2 language can have very different result when applying `reshape` operation. If you really want to match the result from 2 languages, carefully match your input and then: 
      * See which numbers come consecutively on the first dimension.
      * And then permute those axis to left most and then do reshape. 
      * For python, you should look at the right most dimension, entries will be stored in that dimension first. 
    * See the following corresponding code in matlab vs python

```python
def pixelshuffle(inputs, upscale_factor=3):
    batch_size, channels,  in_height, in_width = inputs.size()
    channels //= upscale_factor ** 2  #*3 if 3D
    #out_depth = in_depth * self.upscale_factor  if 3D
    out_height = in_height * upscale_factor
    out_width = in_width * upscale_factor
    input_view = inputs.contiguous().view(
        batch_size, channels, upscale_factor, upscale_factor, in_height, in_width)
    #shuffle_out = input_view.permute(0, 1, 5, 2, 6, 3, 7, 4).contiguous() if 3D
    shuffle_out = input_view.permute(0, 1, 4, 2, 5, 3).contiguous()
    return shuffle_out.view(batch_size, channels, out_height, out_width)
```

Corresponds to matlab code

```matlab
function [out] = pixelshuffle(input, upscale)
    if nargin == 1
        upscale = 2;
    end
    H = size(input,1); W = size(input,2);
    Ch = size(input,3) / upscale.^2;
    B = size(input,4);
    input_fact = reshape(input,[H,W,upscale,upscale,Ch,B]);
    out = reshape(permute(input_fact, [4,1,3,2,5,6]), [H * upscale,W * upscale,Ch,B]);
end
```

[Slide of Reshape function](http://www.cs.utsa.edu/~cs1173/resources/CS1173ReshapeFunction.pdf) 

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

For more detailed exposition on this topic, see the other notes [Data Transport between Python Matlab](Data-Transport-Python-Matlab.md), [Matlab Python Hybrid Programming](Matlab-Python-Hybrid-Programming.md)