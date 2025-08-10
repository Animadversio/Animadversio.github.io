---
layout: post
title: Procedurally Generating Slides from Script
author: Binxu Wang
use_math: true
comments: true
date: Apr. 3rd, 2020
categories: [coding, misc]
tags: [python, coding, presentation, javascript]
---

## Motivation

* Syntax highlighting for codes
* Procedurally adding lots of figures to slides using the same format (if you don't want to copy paste in pptx)
* Adding lots of equations to it from latex format.



# Technical Choices

Source of info

* [What? Slides from Markdown](https://medium.com/@stymied/what-slides-from-markdown-5239ed31e7ac) 

* [Markdown for Slide Tools](https://gist.github.com/johnloy/27dd124ad40e210e91c70dd1c24ac8c8) 

## Beamer

Good old fashioned Latex! 

Pro:

* High quality pdf output. 
* Phycists love it. 

Con:

* You need a latex compiler and environment, latex compiling error is a pain. 
* You get a pdf file, not really for online sharing (https)





## Pandoc Markdown -> PPTX

```bash
pandoc myslides.md -o myslides.pptx --reference-doc another.pptx
```

A really good way to do the boring stuffs in markdown procedurally, and then go to pptx to do the more customized stuff. 

Templates of slides look like, the syntax is still a bit cumbersome. (comparing to the `reveal-md` below)

```markdown
# Section Title
## Slide Title
Text on a slide:
* Bullet
* Bullet
* Bullet
::: notes
Speaker notes go here
:::

:::::::::::::: {.columns}
::: {.column width="50%"}
Left column:
- Bullet
- Bullet
- Bullet
:::
::: {.column width="50%"}
![](bench.jpg)
:::
::::::::::::::
```



## Reveal.js

https://revealjs.com

[highlight.js](http://softwaremaniacs.org/soft/highlight/en/description/) 

Speaker's view is great! And it supports



Online editing tool: https://slides.com/

For these purpose, if you are going to deliver locally, you have to get Node.js

https://docs.npmjs.com/downloading-and-installing-node-js-and-npm

### Markdown -> Reveal.js

https://github.com/webpro/reveal-md

https://openbase.io/js/reveal-md

`reveal-md slides.md --port 8888`

Super easy to start with, esp. if you just want to go through lots of figures



Also easy to export to `pdf` format. 

`reveal-md temp.md --print data-slides.pdf`

Really useful for technical, figure rich slides: https://lacourt.dev/2019/03/12

### Pandoc Markdown->Reveal.js

https://dev.to/berry_clione/set-up-to-convert-a-markdown-file-to-revealjs-slides-by-pandoc-58n5



### Jupyter + RISE

Actually RISE has really similar behavior to Reveal.js. This option just allow you to run code cells while giving a presentation! 

If you want real time running and trial and error, and generating graphics real time, this combination is your choice. 



## Remark



## Marp

https://github.com/marp-team/marp



# When should we not use these tools

When we need sophisticated animation and layouts! Also when we need *ad hoc* annotation and layout for each figure. 

PPTX is still the best and easiest for that purpose, and others are just adding pain and unnecessary effort to it. 

