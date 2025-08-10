---
layout: post
title: Scene Programming in MonkeyLogic2
author: Binxu Wang
date: 2020-10-13
comments: true
categories: [coding]
tags: [tech note, debug, monkeylogic]
---

## Motivation

Writing a ML2 task with relatively complex timing dependency.

https://monkeylogic.nimh.nih.gov/docs_CreatingTask.html#RuntimeVersion2

## Adapter Chain

```matlab
child = Adapter1(tracker);
parent = Adapter2(child);
topmost = Adapter3(parent);
scene = create_scene(topmost);

run_scene(scene);
```

This programming paradigm is really similar to that used in `Tensorflow`. The Adapters are like `operator` function on variables. But nothing really happen to the scene until `run_scene` 

The chain start with a special kind of adapter called `tracer`: **eye_**, **eye2_**, **joy_**, **joy2_**, **touch_**, **button_**, **mouse_** and **null_**

![](D:\Github\Animadversio.github.io\assets\img\notes\Monkeylogic\docs_scene_runtime_v2.png)

Note  [Create scene](https://monkeylogic.nimh.nih.gov/docs_RuntimeFunctions.html#create_scene)  can take a second argument, index to the task objects 

```matlab
fix = SingleTarget(eye_);
fix.Target = 1;                 % TaskObject#1
fix.Threshold = 3;              % 3 deg
wth = WaitThenHold(fix);
wth.WaitTime = 5000;
wth.HoldTime = 500;
scene = create_scene(wth, [1 2]);   % TaskObject#1 & #2
run_scene(scene);
```

Besides, `run_scene` could be run with a 2nd argument, `eventcodes` which will be sent out when 1st scene finished. 

```matlab
 run_scene(scene, eventcodes);
```

Note, the trackers are predefined in `timing` file **eye_**, **eye2_**, **joy_**, **joy2_**, **touch_**, **button_**, **mouse_** and **null_** . Thus we don't have to redefine it separately. 



For manual of common adapters, see [doc](https://monkeylogic.nimh.nih.gov/docs_RuntimeFunctions.html). 

## Playing Movie

[MovieGraphics](https://monkeylogic.nimh.nih.gov/docs_RuntimeFunctions.html#MovieGraphic)

Note Original Movie object doesn't provide functionality to change the size of presentation. But we can use general purpose resizing object function to achieve that. 

## Resize Object

