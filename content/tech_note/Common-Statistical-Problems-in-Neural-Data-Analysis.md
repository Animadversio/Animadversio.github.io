---
layout: post
title: Common Statistical Problems in Neural Data Analysis (Updating)
author: Binxu Wang
date: 2019-07-01
use_math: true
comments: true
categories: [Neuroscience, machine learning]
tags: [tech note, Data Analysis, Machine Learning, Behavior, Neuroscience]
---

# Motivation

Although there are a millennium of methods for neural and behavioral signal recording, the questions asked about the neural data is ususally less diverse. Ultimately, everything is number and we process numbers with algorithm. 

So as I progress on the road of neural data analysis, I'll summarize the common questions and algorithms I encountered along this journey and accumulate a tool kit for myself. 

Note that, more often than not this post will serve as a road map / category for myself and others to arrange the thinking, but there will be posts dedicated to each of the algorithms coming.  

# Unsupervised

We encounter high dimensional data from time to time. Whenever the dimension > 3, we face the problem of visualizing and making sense of data. So to make sense of it, we have to dimension reduce the date into some small groups / clusters / dimensions depending on the characteristic of the data is discrete or continuous. Thus the standard toolkit of unsupervised machine learning comes to us : **Clustering, Dimension Reduction, etc.** Some other methods related majorly to neural data will be outlined as well. 

## Clustering

**Data input**: 

* Spikes, traces
* Post-synaptic potentials
* Neural activity pattern (firing rate)
* Behavioral pattern
* Stimulus samples 
* Gene expression pattern 

**Sample Questions to Answer**

* Is there some natural seperation in the data distribution? Can they be seperate into 2 or more clusters ? 
  * What is the unique characteristic of the cluster? How that is different from others. 

**Sample Algorithm**

* K-means clustering 
* Hierachical Clustering / Similarity Sorting / Linkage based clustering (Ward linkage)
* `Tim Holy's Method`: Statistical criterion driven clustering
  * The thought behind it is to grow a ball around each data point and flow it towrds the mean of points within the ball. (mean-shift algorithm), which will effectively perform gradient ascent along the density function. 

### How good is my cluster?

**Algorithm**

* Silhouette value test

## Dimension Reduction

**Algorithm**

* Linear: Project points onto some directions. Global linear transform. 
  * PCA: Project to the orthogonal directions preserving the largest variance. (maximimum variance directions)
  * Fisher LDA:  (supervised method) Project to dimensions maximizing separation between population. 
  * ICA: Kurtosis / non-gaussianality maximization. 
* Matrix factorization based method: 
  * SVD: 
  * NMF: Approximating original matrix with a low rank matrix subject to some constraint. 
  * TCA: Spatial temporal factorization, 2+ D tensor factorization 
* Manifold Learning 
  * LLE: Recover local linear representation method. 
  * IsoMap: Use geodesic distance on a graph in original space as metric and do embedding 
  * MDS: Preserve metric between points 
      - classic
      - ordinal 


### What algorithm to use to process data? 
* Try PCA / linear method first. 
* For non-linear method esp. manifold learning, consider the complexity seriously. 


### How many dimension should I preserve? 

* Rod breaking test for PCA eigen value. 

### What INFO is preserved in DR? 
Global distance 
Local distance metric 

### Can we back project the low dimensional data back to high dimension (inverse map/embedding map)
Target is to find coordinate system to discribe the manifold. 

If we only want local parametrization, then a feasible method is to use piece-wise linear functions to approximate the original manifold. 

https://www.nature.com/articles/s41467-017-00156-9

The intrinsic attractor manifold and population dynamics of a canonical cognitive circuit across waking and sleep


## Correlation / Cross-correlation Analysis

**Questions**

* Similar to clustering, what are the similar elements in the set of activity? 



## Graph/Network Based Analysis

**Data**

* Whole brain connectome (functional connectivity / anatomical connectivity)
* MicroCircuit connectome
* Functional connectivity among 
* Cell type specific network
* Gene regulation network

**Analysis**

* Graph statistics, distribution
* Importance of the node and potential effect of affecting one node. 

## Criticality Analysis

**Data**

* 

## Fluctuation Analysis



# Supervised 

## Classification 

**Questions**

* Classify 2 kinds of known behavioral states? 
* Classify n kinds of known 

*Note*: Clustering and Classification are similar in application, although one one of them requires labels one of them don't. Both could work hand in hand together with manual labelling to form a pipeline. 

**Algorithm**

* Perceptron / Multi Layer Perceptron
* SVM
* Bayesian Classifier



# Neural Activity Modelling

This part is a traditional and neural specific topic. The core **question** is how we could use **the neural interaction and cellular properties** to explain observed  **neural actiivty and the sensory input or behavioral output**. 

The final goal is to incoporate the data from electrophysiology recording, circuit reconstruction and physiology recording to provide a model connecting the 3 parts. 

## Sensory / Motor System Modelling

The unique thing about sensory and motor system is that we have a concrete knowledge of the input or output of the neural system, although they may subject to some transformation. 

**Data**

* Visual cortex / motor cortex recording 

**Modelling method**

* Spike triggered average (STA), linear filter that fit the sensory input-output function . 
* Spike-triggered NMF: extract subunit from recording. 
* Deep neural network training / fitting 

## Network / Circuit Modelling

Majorly recurrent network or dynamic system modelling. 

**Data**

* Whole brain dynamics (Optical Imaging / fMRI)
* Local circuit 
* Gene regulation network 

-------

# Analysis about Specific Data Format

## Image Processing

### Registration 

**Data**

- Optical imaging, cell / neurite / tissue segmentation
- EM imaging, morphological reconstruction





### Segmentation

**Data**

* Optical imaging, cell / neurite / tissue segmentation
* EM imaging, morphological reconstruction

**Questions**

* What are the relevent region of interest (neruon, soma, axon, dendrites, )



### Reconstruction



### Morphological Analysis 

**Data**

* 3d shape of synapses 
* Dendrites / axon projection morphology

**Analysis**

* Tree based statistics
* Generative model of tree.
* `NEURON` electrophysiology property induction 

## Electrophysiology Processing



### Spike Sorting 



### Single Cell EPhys Modelling 

 

## Behavior (Video) Processing



### Tracking 



Tracking facail 



Janelia, Carsen Stringer 

Face map 



**Package**

* `DeepLabCut`
* `Jaba` 