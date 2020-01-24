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



## Export and Editing in Illustrator



[Graphing General Tutorial](https://www.blakeporterneuro.com/wp-content/uploads/2019/04/Graphing-and-Inkscape_webSafe.pdf)

Note that publication usually requires post plotting editting. And usually people do it in Adobe Illustrator. 

Export the figures into pdf and read properly in Illustrator requires some tweaks in the plotting system 

### **Python**

```python
import matplotlib
import matplotlib.pylab as plt
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
'''Ploting ploting ploting'''

plt.savefig("image.pdf", transparent=True)
```

You need to change the default setting to save the pdf correctly ! 

Ref to http://jonathansoma.com/lede/data-studio/matplotlib/exporting-from-matplotlib-to-open-in-adobe-illustrator/

More options and file formats see, 

https://futurestud.io/tutorials/matplotlib-save-plots-as-file



### **Matlab**

Same as python the default behavior of export fig is not good, pdf can have bizzare layout and size! 

### Plotly

For the modern `plotly` package, see 

https://plot.ly/python/static-image-export/

Please install the dependent packages 

`conda install -c plotly plotly-orca psutil requests`

And 