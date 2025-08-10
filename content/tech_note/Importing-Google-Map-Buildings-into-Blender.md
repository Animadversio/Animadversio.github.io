---
layout: post
title: Importing Geometry from Google Map to Blender
author: Binxu Wang
use_math: false
comments: true
date: 2020-04-29
categories: [coding,misc]
tags: [computer graphics, graphics, blender, python, 3d models]
---

## Motivation

## Method

* Follow the link to install the add-on to blender

https://github.com/eliemichel/MapsModelsImporter

* Install the RenderDoc program on windows, to inject process to Chrome to fetch 3d data from it. 
* Create a shortcut to launch chrome with some additional debug flags 
* Run chrome, record the process number, pause.
* Inject to that number in `RenderDoc` program
* Then start chrome and go to google map to your favorite buildings
* Capture through `RenderDoc`. 
* Save to rdc files to disk. 
* Load that rdc through Blender! and you have your 3d models! 



## Post processing

* Join the patches to a single object. 
* And merge vertices by distance。 
* Process texture and stuff to retain a single kind of material with the color. 



See the youtube video for a tutorial. 

* [Google Maps 3D: Data into Blender](https://www.youtube.com/watch?v=F_XsmoZJmG8)
* [Google Maps 3D: Photogrammetry Mesh Clean-up](https://www.youtube.com/watch?v=XUkMY8Sp_AM)