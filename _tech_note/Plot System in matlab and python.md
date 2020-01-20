---
layout: post
title: Note on Matlab and Python (matplotlib) Plotting system 
author: Binxu Wang
use_math: true
comments: true
date: Jan. 20th, 2020
categories: [coding]
tags: [matlab, python, coding, Visualization]
---

## Motivation

`Matlab`  and `matplotlib` in `python` are plotting packages of daily usage. They share lots of structures but also have minor differences. 

For beginners using the plotting routines can suffice most daily needs, but for more refined control over layout, fontsize and so on, we need to better understand the object structure in `matlab` and `matplotlib`. 

This note will summarize the structures that they both share and also note the differences between them. 

## Object Structure

Both `matlab` and `matplotlib` have 2 layer of structure for plot, `figure` and `axes`, the latter is kind of like a panel or subplot in the figure, but note that `colorbar()` can be it's own axes. 

**Properties for figure**



**Properties for axes**



## Export and Editting

Note that publication usually requires post plotting editting. And usually people do it in Adobe Illustrator. 

Export the figures into pdf and read properly in Illustrator requires some tweaks in the plotting system 

**Python**

```

```

Ref to http://jonathansoma.com/lede/data-studio/matplotlib/exporting-from-matplotlib-to-open-in-adobe-illustrator/



