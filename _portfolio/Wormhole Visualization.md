---
layout: post
title: Visualizing Wormhole Distortion of Spacetime
img: "assets/img/portfolio/WormHoleVisualize2.png"
feature-img: "assets/img/pexels/Skysphere_Aitoff.jpg"
author: Binxu Wang
use_math: true
comments: true
date: June 10th, 2018
tags: [Visualization, Matlab, General Relativity, Astrophysics, Physics]
excerpt_separator: <!--more-->
---

This work is motivated by Christopher Nolan's [*Interstellar*](https://movie.douban.com/subject/1889243/), in which the astronomers drives their ship into a wormhole near Jupiter. The movie shows a gorgeous visualization of wormhole, which I'd like to reproduce in this project. 

![Interstellar](https://img.purch.com/w/660/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzA0NS80MTIvb3JpZ2luYWwvaW50ZXJzdGVsbGFyLXdvcm1ob2xlLXBvc3Rlci1lZGl0LmpwZw==)

# Principle / Math Formulism
The principle of this project is simple, based on the idea of [Ray Tracing]() and geodesic equation of motion. 

1. What we see are photons travels in the space and hit our retina. For star and space, this is infinite object length imaging, so what matters is the incoming angle of the light ray. 
2. Light ray could be reversed, we could simulate the imaging process by emitting ray from camera and 
3. In the universe, most objects and light sources are distant (if we don't consider the accretion disk around the black hole). So the only important factor is the incoming direction and outcoming direction. In this simplified scenario, we can think of photon interacting with black hole / wormhole as a scattering process. 
4. As the Einstein General Relativity theory tells us, photon travels the geodesic in the gravitation field. As long as we have the Spacetime metric of the wormhole or black hole, we could calculate the equation of motion from Geodesic Equation and simulate photon trajectory. 


# Results


# Acknoledgement 
Many thanks to Wenhan Guo who has implemented the system in his freshman year, which gives me courage to do the work as a term project. 

Thanks to the Astrophysics Seminar course by Prof. Wang, Jing in PKU, which offers me the opportunity to implement this project. 

