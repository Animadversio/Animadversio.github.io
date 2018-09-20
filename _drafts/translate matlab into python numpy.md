How to translate matlab into python numpy
=======

* General
    * Replace all the comment mark `%` with `#`
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
    * Matlab start from `1` end in `end`, numpy from `0` to nothing
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
    - 


