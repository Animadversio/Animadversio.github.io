---
layout: post
title: Multi-platform Matlab compiling 
author: Binxu Wang
date: Nov 3rd, 2019
comments: true
categories: [coding]
tags: [tech note, matlab, compilation, multi-platform, C]
---

# Multi-platform Matlab compiling 


When trying to compile a matlab code, I faced and solved many errors either on the Windows platform and the MacOS platform. Here I note some prominent difference across platform and how to debug the compiling process.  

## Concept
There are 2 types of compilation in `matlab`. 
* Matlab compiler is compiling matlab code `*.m` into standalone executive files, like `.exe` such that it can run on its own. 
* `mex` is compiling code written in other languages into `mex` file such that it can interact with matlab code, through some `Matlab data API`

## Prerequisites
* If they use `mcc`, needs MCC (matlab compiler) add-on for matlab
* `mex` uses some compiler to compile the foreign code. 
* Choose the c compiler for  by checking `mex -setup` or `mex -setup c++` You will see. 
>  MEX configured to use 'Microsoft Visual C++ 2017 (C)' for C language compilation.
Warning: The MATLAB C and Fortran API has changed to support MATLAB
	 variables with more than 2^32-1 elements. You will be required
	 to update your code to utilize the new API.
	 You can find more information about this at:
	 https://www.mathworks.com/help/matlab/matlab_external/upgrading-mex-files-to-use-64-bit-api.html.
To choose a different C compiler, select one from the following:
**MinGW64 Compiler (C)**  *mex -setup:'C:\Program Files\MATLAB\R2019a\bin\win64\mexopts\mingw64.xml' C*
**Microsoft Visual C++ 2017 (C)**  *mex -setup:C:\Users\binxu\AppData\Roaming\MathWorks\MATLAB\R2019a\mex_C_win64.xml C*
To choose a different language, select one from the following:
 `mex -setup C++ `
 `mex -setup FORTRAN`


* On windows, you can change the compiler just by clicking the link! 
* On macOS you cannot. The gcc it use is usually the `Clang` compiler coming with `Xcode`. Thus it's different from `gcc` and some options are not supported by `Clang` like `gcc -fopenmp`. 
	* If you want to use authentic `gcc` instead, you have to install it yourself. Like `homebrew install gcc` or `homebrew update gcc`  
	* And then change the `mex`  command like `mex CC="/usr/local/bin/gcc-9 -fopenmp" LD="/usr/local/bin/gcc-9 -fopenmp" xxx.c`. Using the path to real `gcc` to substitute! (Note MacOS automatically alias `gcc` with the Clang compiler, so we have to use `gcc-9` for the real one.) 
* For official reference see [Change Default Compiler](https://www.mathworks.com/help/releases/R2019a/matlab/matlab_external/changing-default-compiler.html?lang=en) 

## Debugging Notes for multi-platform compiling

* Some library may have different names on different platforms like `winsock2.h` is used instead of 
* The pre-compiling flags are used to choose which lib / header to use `#if !defined(WIN32) && !defined(_WIN64)` so some win32 flag may not be identified in win64 machine. Needs to modify that to make it work. 
	* Note `WIN32` may not be recognized, so use `_WIN32` or `__WIN32__` instead
	* Look into [this table](http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system) for the difference
* The language and command in terminal is different in linux, mac and windows, should change for that. like `rm -rf` in unix and `DEL -rf` in windows
* The midfile generated in C code compilation differs in unix and windows. `.o` vs `.obj`
* Note if some external function is not found. It normally means some library is not linked or imported properly. So find the target library (which the function resides). and to include it! 
> Error using mex
   Creating library mslisten.lib and object mslisten.exp
mslisten.obj : error LNK2019: unresolved external symbol __imp_bind referenced in function mexFunction
mslisten.obj : error LNK2019: unresolved external symbol __imp_closesocket referenced in function mexFunction

Only `#include <winsock2.h>` will cause the error above. And we should import the corresponding library as well. 
`#pragma comment(lib, "Ws2_32.lib")`
(the meaning of `#pragma comment` is to add an additional dependent library to the object file, before going into linker.  [MSDN Doc](https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2013/7f0aews7(v=vs.120)?redirectedfrom=MSDN),  [Q&A](https://stackoverflow.com/questions/3484434/what-does-pragma-comment-mean))

So the final debugged C code header looks like, and it can be compiled via `mex -I. msconnect.c` 
```cpp
#if !defined(_WIN32) && !defined(_WIN64)
#include <sys/socket.h>
#include <unistd.h>
#include <sys/select.h>
#include <netdb.h>
#include <arpa/inet.h>
#else
#include <winsock2.h>
#pragma comment(lib, "Ws2_32.lib")
#endif
```