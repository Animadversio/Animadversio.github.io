---
layout: post
title: Computer Graphics Environment in Matlab
author: Binxu Wang
date: 2019-11-14
comments: true
categories: [coding]
tags: [tech note, Computer Vision, matlab, Computer Graphics]
---

## Computer Graphics environment in Matlab

@(515.1 Computer Graphics)[matlab]

Recently, we are using matlab to do computer vision experiments. Thus this note introduces some function controlling the elementary graphics environment. 

For Computer Graphics, the basic 3 components are 
* Object
	* position and shape
	* material (BRDF)
* Light
* Camera

And the rendering engine will take these components and give out a physical looking image. 

## Light and Camera
Basic property of light is the direction of light, and point source vs parallel light. 
`light` specify the light property. 

For more complex control of light source see [commands](https://www.mathworks.com/help/releases/R2019a/matlab/creating_plots/lighting-overview.html)
* `lighting`, `flat` render each facet the same color, `gouraud` interpolate the normal vector field on the curved surface.

`view` specify the camera center line of sight. `view(az,el)` or `view(v3)` will specify the camera direction. Normally it's enough for plotting figures. 
* Note that `view()` can defaultly return the 4 by 4  projection matrix formed by `getAxesTransformationMatrix` method. see `viewmtx` for reference.

For more specific control of camera, it has the full set of [commands](https://www.mathworks.com/help/releases/R2019a/matlab/creating_plots/defining-scenes-with-camera-graphics.html)
* `campos` set the position of camera
* `camtarget` set the target of line of sight
	* `camlookat` higher level function that target an object (using its handle)
* `camroll` roll the camera view around the line of sight or any axis. 
	* `camup` roll the camera so that the up direction in the view match the vector. 
	* Note in `auto` mode `[0,0,1]` i.e. z direction usually means up. so you will not rotate across y axis in a full cycle. 
* `camlight` will fix the light relative to the view point. 

## 3d Shape Description 
`patch`, `vertices`, `faces`
* In the most simple case, it's a simplicial complex, or triangle mesh network. It's simple, vertices is a `(nv,3)` float array encoding the 3d coordinates of every vertex. And faces is a `(nf,3)` int array encoding the row index of vertices it consists. 
* But a face can consists of any number of vertices

`patch('Faces',F,'Vertices',V)` uses the Face and Vertices data to create shape, i.e. it's kind of the rendering engine in Matlab! 
**Note**: 
* `patch` can not only visualize shapes in the computer graphics sense, it can visualize color data defined on `faces` or `vertices`. For example, from doc
```matlab
vertices = [0 0; 0 5; 5 0; 3 3; 3 6; 6 3];
faces = [1 2 3; 4 5 6];
C = [5; 1; 4; 3; 2; 6];
p = patch('Faces',faces,'Vertices',vertices,'FaceVertexCData',C);
p.FaceColor = 'interp';
```

```matlab
vertices = [0 0; 0 3; 4 0; 0 4; 0 7; 4 4; 5 0; 5 3; 9 0];
faces = [1 2 3; 4 5 6; 7 8 9];
C = [0; 0.6667; 1];
p = patch('Faces',faces,'Vertices',vertices,'FaceVertexCData',C);
p.FaceColor = 'flat';
```

See the figure in `patch` [Ch doc](https://ww2.mathworks.cn/help/matlab/ref/matlab.graphics.primitive.patch-properties.html). [en doc](https://www.mathworks.com/help/matlab/ref/matlab.graphics.primitive.patch-properties.html), [patch colormap](https://www.mathworks.com/help/matlab/creating_plots/how-patch-data-relates-to-a-colormap.html). 
### Triangulation
Note the 2d shape and 3d shapes could be represented as simplicial complex, i.e. triangulation. Using this representation, many properties of the shape like the normal vector at the vertices or facets could be calculated. 



## BRDF
`BRDF` is specified by the `material` command in `matlab`


## Functions
`isosurface`
`isonormal`
`isocaps`
`patch`