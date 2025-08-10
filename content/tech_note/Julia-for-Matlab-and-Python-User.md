---
layout: post
title: Julia for Matlab and Python Users (Updating)
author: Binxu Wang
use_math: true
comments: true
date: 2021-10-15
categories: [coding]
tags: [julia, python, matlab, programming languages]
---

## Motivation

Julia is a very fast language. 

Julia hybrids many features from many sources. Here I'm taking note on its syntax and features by comparing to Python and Matlab. 

## Basic Functions

* `print` is like in `python` BUT, no `\n` added at the end of each line. `println` has the `\n` 
* String formatting is super easy, we can just use values of expressions.
  * `"$greet, $whom.\n"`
  * `"1 + 2 = $(1 + 2)"`



## Operators

* `.` operation extend its usage in `matlab` it means to vectorize sth. or broadcast one operation to all the element of the argument. 
  * This is super powerful, extending beyond arithmatics. You can broadcast everything by putting a `.` there. 
* `...` is like `*` in python, it could de-bundle a tuple or list into lots of variables. 



## Types

* `::` signify the type of sth. 
* `<:` signify the type is a subtype of X. 
* `nothing` equiv to `None` in `python` 
* Similar to matlab `true` `false` not capitalized. 



## Control Flow

* Control flow syntax is much like matlab `if...elseif...end` no indentation or `:`. 
* Loop syntax is a bit like Python `for .... in ...`, with some caveat
  * But if there are two things being looped, there needs to be a `()` , not like python. 
    * `for (i,x) in enumerate(L)` 



## Functions

* Syntax is like 

  * ```julia
    function f(x,y)
        x + y
    end
    ```

* Lot's of ways to write inline functions
  * `f(x,y)=x+y` defines a function! 
  * `x -> x^2 + 2x - 1` is a nameless function, useful for `map` or `filter`
* Return values
  * `julia` default supports no return, it automatically returns the output of last expression.
* Type decoration and Argument types. 
  * Here keyword arguments are separted by `;`, not like python. 
    * `function plot(x, y; style="solid", width=1, color="black")` 
  * Giving a default value for arguments will not make it a keyword argument. 
    * `Date(y::Int64, m::Int64=1, d::Int64=1)` 
* Docstring
  * Unlike python, docstring lives above the function signature not below. 

##  ~~`class`~~, `struct`

There is no real `class` in julia as in python or matlab. There is only `struct` and the methods. This is a design choice. 

> struct *owns* the data it has, but does not own the methods or functions of it. Functions have the freedom to change. 
>
> You do not need to re define a class for re define one of its method. 

The `constructor` syntax is like. 
