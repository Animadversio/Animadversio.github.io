---
layout: post
title: Dynamic Visualization in Python
author: Binxu Wang
date: Nov 17th, 2019
comments: true
categories: [coding]
tags: [tech note, coding, Visualization, Python]
---

## Motivation

Unlike `matlab`, plotting dynamics in python is not as easy or straight forward to use. And to interact with the figure is not always as simple as matlab native plotting routines. 



## Interactive Usage Supported by Plotting Library

### Notebook backend of matplotlib

Note, the 

```python
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import ipywidgets as widgets
from IPython.display import display
%matplotlib notebook

# generate test data
x = np.random.rand(100)
y = np.random.rand(100)
z = np.random.rand(100)

fig = plt.figure(figsize=(6,6))
ax = fig.add_subplot(111, projection='3d')
ax.set_xlabel('X axis')
ax.set_ylabel('Y axis')
ax.set_zlabel('Z axis')
ax.scatter(x, y, z)
ax.view_init(20, 40)
# show plot
plt.show()

def update_plot(angle1 = 20, angle2 = 40):
    # set view angle
    ax.view_init(angle1, angle2)
    fig.canvas.draw_idle()

# prepare widgets
angle1_slider = widgets.IntSlider(20, min = 0, max = 60)
angle1_label = widgets.Label(value = 'Angle 1 value is: ' + str(angle1_slider.value))
display(angle1_slider, angle1_label)

# handle angle 1 update
def update_angle1(value):
    update_plot(angle1 = value['new'])
    angle1_label.value = 'Angle 1 value is: ' + str(value.new)

angle1_slider.observe(update_angle1, names = 'value')
```



### Qt backend of matplotlib



### Plotly

`Plotly` is designed for web based visualization, so it strongly emphasize on interaction 





## Using IPython.display.clear_output

```python
fig = plt.figure()
ax = fig.add_subplot(1, 1, 1) 

for i in range(21):
    ax.set_xlim(0, 20)
    
    ax.plot(i, 1,marker='x')
    display(fig)
    
    clear_output(wait = True)
    plt.pause(0.5)
```

Anothor example

```python
import matplotlib.pyplot as plt
import matplotlib.animation
import numpy as np
from IPython.display import display, clear_output

t = np.linspace(0,2*np.pi)
x = np.sin(t)

fig, ax = plt.subplots()
l, = ax.plot([0,2*np.pi],[-1,1])

animate = lambda i: l.set_data(t[:i], x[:i])

for i in range(len(x)):
    animate(i)
    plt.pause(0.5)
    clear_output(wait=True)
    display(fig)
    
plt.show()
```



https://towardsdatascience.com/animations-with-matplotlib-d96375c5442c



https://blog.shahinrostami.com/2018/09/jupyter-notebook-and-updating-plots/ 

https://stackoverflow.com/questions/42998009/clear-matplotlib-figure-in-jupyter-python-notebook 

 https://stackoverflow.com/questions/21360361/how-to-dynamically-update-a-plot-in-a-loop-in-ipython-notebook-within-one-cell 

https://stackoverflow.com/questions/11874767/how-do-i-plot-in-real-time-in-a-while-loop-using-matplotlib