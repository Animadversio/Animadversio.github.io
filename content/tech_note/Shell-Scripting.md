---
layout: post
title: Learning CMD / Shell Scripting in Windows
author: Binxu Wang
use_math: false
comments: true
date: 2020-04-29
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



## Setting Alias for Programs

Sublime is super useful text editor to have, but how can we start it from cmd or shell?

* Add the folder in Program Files to the PATH env var.

  * E.g. `C:\Program Files\Sublime Text 3`

* Set aliasing in cmd in administrator mode. 

  ```cmd
  cd "C:\Program Files\Sublime Text 2\"
  mklink sublime.exe sublime_text.exe
  ```

* Or in Powershell

  ```powershell
  Set-Alias subl 'C:\Program Files\Sublime Text 2\sublime_text.exe'
  ```

  

https://stackoverflow.com/questions/9440639/sublime-text-from-command-line