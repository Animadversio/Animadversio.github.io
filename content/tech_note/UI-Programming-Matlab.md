---
layout: post
title: GUI programming in Matlab
author: Binxu Wang
use_math: true
comments: true
date: 2020-05-16
categories: [coding]
tags: [matlab, coding, Visualization, GUI]
---

## Motivation

Sometimes, we want to manipulate and interact with our plot in a way that is not built into matlab figure. For example, we would like to visualize images when we are travelling in the hidden space. I requires matlab to visualize things when we click something or slide some bar. 

This is related to the [Dynamics Visualization in Python](Dynamic-Visualization-in-Python.md). But this is also related to the general coding pattern of GUI in java and beyond (Game and APP programming). So I make a note of this. 

Related to the more basic note [Matlab Plot system](Plot-System-in-matlab-and-python.md) as well. 

## General Concept

It's hard to wrap your head around GUI programming is you have majorly done scientific computing before. The latter is majorly linear execution, recursive at most. 

However, GUI has a quite different coding pattern called asynchronous programming. In some sense asynchronous programming becomes crucial due to the coming of GUI (compared to commandline programs). As you let human users to interact freely, what does the system do when the user is not interacting right? Comparing the solutions of different systems will be interesting

* **Command line programs**: Just stuck there, do nothing...
* **Program running on a small hardware** (Adafruit, Arduino): You can run a infinite loop, checking if user press something. If they do so then trigger a new function. 
* **Video Games, Web Pages**: While... You cannot do nothing when user is not interacting. Animations still have to be played and calculation has to be made in the background without you. 

So here comes one solution called *Callback function*, it means the function is run when the user or another party (over the network) trigger something. Before that the system is just doing its main loop. 



## Callback function

In Matlab, Callback function is specified as a function handle or anonymous function or a cell array. 

**Callback Function Syntax** 

The callback function syntax is of the form the 3rd argument is not mandatory. 

```matlab
function objectTag_Callback(hObject, eventdata, handles)
```

The arguments are listed in the following table.

| **Argument** | **Description**                                              |
| ------------ | ------------------------------------------------------------ |
| `hObject`    | The handle of the object whose callback is executing.        |
| `eventdata`  | Empty -- reserved for future use.                            |
| `handles`    | A structure containing the handles of all components in the GUI whose fieldnames are defined by the object's `Tag` property. Can also be used to pass data to other callback functions or the command line. |



### Value sharing

As the callback function cannot draw stuffs based on nothing, so it's good to let them share some variables among all graphical handles. `guidata` is one of the solutions. It let you share one variable (structure) among all the graphical objects in the same figure. It could be accessed by `data = guidata(h)` and set by `guidata(h,data)`, and all the graphical objects could be part of this object! So it's easy for the controllers to interact with the images and change their appearance. 



https://matlab.fandom.com/wiki/FAQ#How_can_I_share_data_between_callback_functions_in_my_GUI.3F

https://www.mathworks.com/help/matlab/creating_guis/share-data-among-callbacks.html

### Slider Setting

Slider setting is a little bit unintuitive! 

Suppose you want to create a slider with the following behavior:

- Slider range = 5 to 8
- Arrow step size = 0.4
- Trough step size = 1
- Initial value = 6.5

From these values you need to determine and set the `Max`, `Min`, `SliderStep`, and `Value` properties. You can do this by adding the following code to the initialization section of the GUI M-file (after the creation of the `handles` structure):

```matlab
slider_step(1) = 0.4/(8-5);
slider_step(2) = 1/(8-5);
set(handles.slider1,'sliderstep',slider_step,...
        'max',8,'min',5,'Value',6.5)
```

http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/creating_guis/ch_ove32.html





## Listener

## Other User Graphical Input

`ginput` Let user input n points sequentially! Really useful to get some coordinates from a figure! 

