---
layout: post
title: Common Statistical Problems in Neural Data Analysis
author: Binxu Wang
date: July 1st, 2019
use_math: true
comments: true
categories: [neuroscience, machine learning]
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
* `Holy Method`: Statistical criterion driven clustering 

### How good is my cluster?

**Algorithm**

* Silhouette value test

## Dimension Reduction



**Algorithm**

* Linear
  * PCA
  * Fissher LDA (supervised)
  * TCA
  * MDS
  * NMF
* Manifold Learning 
  * LLE
  * IsoMap

###What INFO is preserved in DR? 



### Can we back project the low dimensional data back to high dimension





## Correlation / Cross-correlation Analysis

**Questions**

* Similar to clustering, what are the similar elements in the set of activity? 



## Graph Based Analysis

**Data**

* Whole brain connectome (functional connectivity / anatomical connectivity)
* MicroCircuit connectome, cell type specific network
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



## Network / Circuit Modelling

Majorly recurrent network or dynamic system modelling. 

**Data**

* Whole brain dynamics (Optical Imaging / fMRI)
* Local circuit 



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