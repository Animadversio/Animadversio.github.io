---
layout: post
title: Show Animation in PDF Through Latex
author: Binxu Wang
# use_math: true
math: true
comments: true
date: 2020-04-26
categories: [coding, misc]
tags: [latex, presentation]
---

## Motivation

* Sometimes, animation is a great boost for a scientific idea in a paper. 
* Though PDF is a old fashion communication media, we could add animation to it to give it some vigor.

## Method

For small `gif` type short movie, using `animate` is a good choice. The syntax for using it is simple

```latex
\usepackage{animate}
...
\animategraphics{24}{anim-}{0}{99}
```

You need to have an image sequence, e.g. named `anim-%d.png` then you can let latex process it into an animation. 

If you already got a bunched `gif` file at hand, you need to export it into an image sequence. Then `ImageMagick` is your friend! It's a command line tool supporting many image manipulations. Here you need 

```bash
magick convert alpha=0.100000_beta=0.900000.gif -coalesce anim.png
```

Then you will have your image sequence there. 

*Note*: Directly using `convert` is good on Unix system. For windows, there is a system program ` convert.exe` shipped with Windows. So you have to use `magick convert`

Then you get your animation in the paper! 

![](..\assets\img\notes\anim\animation.png)

## Reference

For bugs and compilation problems see the following resources: 

https://liam.page/2017/08/10/importing-animate-in-LaTeX/

https://texblog.org/2018/03/05/the-animate-package/

https://help.geogebra.org/topic/how-to-include-animated-gif-in-latex-pdf

https://tex.stackexchange.com/questions/7602/how-to-add-a-gif-file-to-my-latex-file