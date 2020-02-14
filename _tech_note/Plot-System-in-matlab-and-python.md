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



## Silent Plotting



### Python

```python
from matplotlib import use as use_backend
use_backend("Agg")
import matplotlib.pylab as plt
plt.ioff()

...
plt.show(block=False)
time.sleep(5)
plt.close('all')
```

Seems like a solution. Refer to [issue](https://github.com/matplotlib/matplotlib/issues/8560)

### matlab

Try to plot silently in matlab is much harder. It requires exotic reference manipulation of figure and axes objects using `set`. 

Instead of just `figure(1)` and `subplot(121)` The following will plot silently without popping up figure. 

```matlab
h2 = figure('Visible','off');clf; 
h2.Position = [  19         235        1779         743];
axs = {}; axs{1} = subplot(1,2,1); axs{2} = subplot(1,2,2);
set(0,'CurrentFigure',h2); %clf; %
set(gcf, "CurrentAxes", axs{i}); cla(axs{i},'reset'); 
% ploting, ploting
saveas(h2, fullfile(savepath, compose("score_traj_cmp_chan%d.png", channel_j)))
```



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