---
layout: post
title: Learning Shell Scripting in Windows
author: Binxu Wang
use_math: false
comments: true
date: Apr. 29th, 2020
categories: [coding,misc]
tags: [Windows, coding, shell, environment]

---

## Motivation

Sometimes we are just too lazy to open a python script to do some file manipulation. (where it actually use the system api). Why not just use system's scripting language?



## Sort, Filter File names and Write

https://metinsaylan.com/9270/how-to-sort-files-by-last-modified-date-using-powershell/

```powershell
gci -file -Filter *calign* | sort LastWriteTime | select-object name

gci -file -Filter *align* | sort LastWriteTime | select-object name > gif_list.log
```

`gci` get-Children, 

```bash
ls -ltr | egrep -v "^d"
```



