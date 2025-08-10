---
layout: post
title: Understanding conda and python package management (Updating)
author: Binxu Wang
date: 2019-07-25
comments: true
categories: [coding]
tags: [tech note, coding, Linux, python, environment]
---
* TOC
{:toc}

Python is a script language. 

Most of the packages are written in python, and they are just a bunch of script files in a folder hierachy. For these packages, it's just as easy as find the script file and run them. 

Some packages involves compiled binary files (maybe from C), `.exe` in Windows and no-extension in Unix. (you can see some of these in your `./anaconda3/bin` folder) These files can normally be run directly in the terminal. Some packages involves compiled library from C++ or something, these files are `.so` in Unix and `.dll` in Windows. (you can see some of these in your `./anaconda3/lib` folder) The python script files can import functions from dynamic library and call them during runtime. So it's crucial for the scripts to know where these libraries / binaries are. 

## Background: Python Importing Mechanism
When using python packages or modules, we type `import pkg`

**Package Searching** Then it will search in the following folders (`sys.path`) (cf. path in `matlab`). And all the folders with a `__init__.py` file in it will be identified as a package. All the `.py` script will be seen as a module so it can be imported as well. 

*Note*: The first term `''` in the `path` list is the current directory. You can see where you are by `os.getcwd()`. This can be helpful esp. when you are in a IDE like `SPyder` or `PyCharm` or `Jupyter`. When you are in terminal that's just where you call `python`.    So what's in the current folder will affect what you can import! 

For example for Windows, 
```python
>>> sys.path
['', 'C:\\Users\\john\\Documents\\Python\\doc', 'C:\\Python36\\Lib\\idlelib',
'C:\\Python36\\python36.zip', 'C:\\Python36\\DLLs', 'C:\\Python36\\lib',
'C:\\Python36', 'C:\\Python36\\lib\\site-packages']
```
Ubuntu Anaconda python3.7
```python
>>> sys.path
['', '/disk1/home/wangbx/anaconda3/lib/python37.zip', '/disk1/home/wangbx/anaconda3/lib/python3.7', '/disk1/home/wangbx/anaconda3/lib/python3.7/lib-dynload', '/disk1/home/wangbx/anaconda3/lib/python3.7/site-packages']
```
Ubuntu System python3.6
```python
>>> sys.path
['', '/usr/lib/python36.zip', '/usr/lib/python3.6', '/usr/lib/python3.6/lib-dynload', '/disk1/home/wangbx/.local/lib/python3.6/site-packages', '/usr/local/lib/python3.6/dist-packages', '/usr/lib/python3/dist-packages']
```

If you want to change this, use `sys.path.append(r'C:\Users\john')` Or add path to environment variable `PYTHONPATH`.

## Objective: What is package installation

The package could be written in pure python (most of the small packages), then all is well, all you need is a bunch of `.py` in a zip or `tarball`. In this case, the management system just needs to unzip the source and place it in the right place. (sometimes it needs to track meta-data and solve dependencies.)

However sometimes it contains functions written in `C` and needs compiled `binary` and `lib`. However, as we all know these compiled `bin` and `lib` is platform-dependent and CPU architecture dependent, and the most robust method is to compile them (with C++ compiler) from source code to binary. But compilation is painful and can usually cost much time and energy from newbies without deep knowledge in it. So a workaround is to download these compiled `bin` and `lib` directly, and these files must match your system and CPU well! This is why your OS and CPU architecture matters for some basic numerical package (esp. those involving numerical operation), as they usually involves C functions / routines for speed, and these packages' `Wheel` are quite large. However generic compiled `lib` and `bin` may not use the deepest potential of your machine[^1], So if you really care you may compile the source on your machine for yourself (*with the rigth configuration.*)!

[^1]: For example, you may see `The TensorFlow library wasn't compiled to use AVX2 instructions, but these are available on your machine and could speed up CPU computations.` this means your machine (CPU) support some new operations, but the code are not compiled to use these.... 

To wrap up, the same Package/Project could be disributed in multiple formats, the source distribution (which may need compilation) usually published on `Github` or the `built distribution` which contains compiled files. [`Wheel`](https://wheel.readthedocs.io/en/latest/) and [obsoleting `Egg`](https://setuptools.readthedocs.io/en/latest/formats.html) are such built distribution, such that it could be used after moving to the correct system. As we can see, these wheels are platform-dependent (Cf. [PyPI Tensorflow](https://pypi.org/project/tensorflow/#files) and [Performance-optimized wheels for TensorFlow](https://github.com/mind/wheels)). 

For more information, explore [Glossary](https://packaging.python.org/glossary/)

Last but not least, one package does not work on it's own. It usually requires other python packages, and dynamic libraries or probably shared C libraries. **How do we specify these dependencies?** For other python packages, it's sometimes specified in `requirement.txt` in the python package[^3]. Or it's written in `setup.py` in the folder. For more complicated cases, you needs an engine to determine which is the best version for each package[^2]. 

For C libraries, to check what shared library a binary file depends, use `ldd /path_to_binary_file` (Linux system). 

[^2]: Comparing to Julia, it has an in-built package management syste. `] add xxx` and it's much cleaner than python. Besides, the index system for packages is called `Registry`, and it has one global Registry and multiple private and local registry for some organization.

[^3]: Generate your own `requirement.txt` following this [guide](https://www.idiotinside.com/2015/05/10/python-auto-generate-requirements-txt/) (Use `pip freeze > requirements.txt` or Use `pipreqs` to generate from script)

```bash
$ ldd /disk1/home/wangbx/anaconda3/bin/python
    linux-vdso.so.1 (0x00007ffc18dbc000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f50c0d00000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f50c090f000)
    libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f50c070b000)
    libutil.so.1 => /lib/x86_64-linux-gnu/libutil.so.1 (0x00007f50c0508000)
    librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f50c0300000)
    libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f50bff62000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f50c1290000)
```

## Package Management System
The **objective** of python package management is to let python find the script files and the dependent files (which can be compiled binary or library). 

Besides, it should have a good **category / repository** of packages so that when you let it install something, it know where it exists online and know how to choose the right version (of wheel) according to your system. 

Moreover, packages are developped and upgraded asynchronously and distributedly, and they depends on each other (sometimes specific version of some package) in a complicated way. To find which version of package can live with other packages, it needs to solve the **dependencies** of the current packages and to upgrade or downgrade other packages to match. This is intrinsically a [Boolean Satisfiability Problem (SAT)](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem), which is NP-hard. And the solver's objective is to find the feasible and newest version of every packages in the environment. We can easily imagine that this problem could have no single solution or multiple solutions. For this problem, `pip` takes a cheating way, just use eager algorithm to solve dependency one by one and it can fail. `conda` really has a solver, but we know it's [quite slow](https://www.anaconda.com/understanding-and-improving-condas-performance/). (However, it can fail as well, as sometimes there is conflicting requirement and no-solution...)

## What does pip do?
`pip` is the default package management system, it's basic and robust, ([User guide](https://pip.pypa.io/en/latest/user_guide/))but does not come with a virtual-enviroment system with it! 

**Dependency Solving** Till now it **does not** have a [real dependency solving system](https://github.com/pypa/pip/issues/988)! It just make use of `requirement.txt` in the package folder, you can do `pip install -r requirements.txt` to install the required packages line by line (seems equivalent to run `pip install` for it line by line). And it can induce conflicts. However it's fast and work in most cases[^4]. 

[^4]: For most small projects on github, having a `requirement.txt` is enough and usually work~

**Repository** As for package coverage, there are far more packages on the default repository of `pip` - [python package index](https://pypi.org/). So if you cannot find the package in `conda install xxx` you can try `pip install xxx`. 

**Install pip** Normally it is installed in the system. But if there are multiple version of python (esp. you have system python and anaconda python), the `pip` must be the right one corresponding to the right python version. Use `pip -V` to see where the pip file is and which python it correspond to. 
```bash
pip -V
pip 19.1.1 from /disk1/home/wangbx/anaconda3/lib/python3.7/site-packages/pip (python 3.7)
```
Or for system wide python
```bash
pip3 -V 
pip 19.1.1 from /disk1/home/wangbx/.local/lib/python3.6/site-packages/pip (python 3.6)
```

It can be installed by fetching the `get-pip.py` script from web and running `python get-pip.py` using the right version of python (check the version by `which python`). 
```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

`pip show numpy` To see where you've installed the package, and what are the dependency and dependant of the package, which is highly useful! 

## What does Conda do
Conda provides well isolated environments, and has a real dependency solver [solving SAT problems](https://en.wikipedia.org/wiki/Boolean_satisfiability_problem) so we usually use it for complex version configuring. 

**Dependency Solving** To understand the inner mechanism to the conda solver, see [understanding-and-improving-condas-performance](https://www.anaconda.com/understanding-and-improving-condas-performance/)

**Repository** There are multiple channel / repository of packages for `conda`.Although the default channel does not provides as many packages as `PyPI`, it has [conda-forge](https://conda.anaconda.org/conda-forge) as a custom built wheels. 

**Check Info** The `conda search numpy --info` and `conda info numpy` are nearly equivalent to `pip show numpy`

**Structure** Some important structure in anaconda folder, you can explore the structure and the format of the files with `file` command. See `conda info` for more specs. 

- `anaconda3`
    - `include` # all the C header files
    - `bin` # binary files, including python / jupyter / spyder usually you can use these utilities in shell / console
    - `lib` # some dynamic libraries collection. (ending in `.dll` in Windows, `.dylib` in OSX in `.so` in Linux)
    - `envs` contains the environments, each has the same structure as the basic anaconda folder 
```bash
bin     conda-meta  include     lib     share       ssl
```


# Reference 
* [Introduction to python packages](https://realpython.com/python-modules-packages/)
* [Better Python dependency while packaging your project](https://medium.com/python-pandemonium/better-python-dependency-and-package-management-b5d8ea29dff1)
* [setup.py vs requirements.txt](https://caremad.io/posts/2013/07/setup-vs-requirement/)
* [What is setup.py?](https://stackoverflow.com/questions/1471994/what-is-setup-py)
* [Distribute your package on PyPI--Guide to setup.py](https://pythonhosted.org/an_example_pypi_project/setuptools.html)
* Check out `Pipdeptree` package
