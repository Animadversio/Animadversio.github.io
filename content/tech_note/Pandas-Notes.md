---
layout: post
title: Note on Pandas
author: Binxu Wang
use_math: true
comments: true
date: 2019-12-10
categories: [coding]
tags: [python, coding]
---

## Motivation

`pandas` is a great tool for representing structured data in python, similar to `Table` in `matlab` and `dataframe` in `R` . 

Using it to interact with table data (like experimental records) on hard drive and process it in python is also great! 

## Create Dataframe

Source: 

* List of tuples
* np.ndarray
* dictionary 

## Read / Write

* [`read_excel`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_excel.html#pandas.read_excel)

* [`read_csv`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html#pandas.read_csv)

* [`to_excel`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_excel.html#pandas-dataframe-to-excel)

* [`to_csv`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_csv.html#pandas.DataFrame.to_csv) 

## Data Structure

* `pandas` `array` 
  * Can be transformed into `numpy` by `.to_numpy()` . Or to normal `list` by `.to_list()` 

## Interaction

* Slicing using boolean array. and `df.index` is the normal row number starting from 0. 
  * `ExpTable[ExpTable.index == 100]`
  * Selecting rows using condition
    * `color_and_shape = df.loc[(df.Color == 'Green') & (df.Shape == 'Rectangle')]` 
  * `ExpTable.index[ExpTable.comments.str.contains("Evolution")]`
  * **Caveat**: you cannot use `np` type array to directly slice a `dataFrame`. But you can use it to slice the individual columns. 
* Filtering using sub-string pattern
  * `ExpTable.Expi[ExpTable.comments.str.contains("Evolution")]`
  * Or `df.ephysFN[df.ephysFN.str.contains("Alfa")==True]`
* Remove lines containing any `nan` or all `nan`
  * `df = df.dropna(axis=0, how='all')`
  * `df = df.dropna(axis=0, how='any')`
  * **Note**: `dropna` will not move the index of the original array! Thus the index of the original lines will not be changed. However there will be gap in index space. `reindex` will close the gap! 
    * `df = df.reindex(index=range(df.shape[0]))`
* Fill `nan` with value
  * `df.comments.fillna(value="", inplace=True)` 
  * **Note**: just like numpy, df function usually returns a new view or object instead of write inplace! Unless you specify that!

* Concatenate 2 tables together 
  * `pd.concat([df_old,df_new], axis=0, ignore_index=True)` 