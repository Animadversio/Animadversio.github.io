CNN Visualization
=====

How can we understand CNN? Deep networks

MainRef: http://cs231n.github.io/understanding-cnn/

https://medium.com/@awjuliani/visualizing-neural-network-layer-activation-tensorflow-tutorial-d45f8bf7bbc4
## Layer feature map Visualiz



## Conv Filter Visualiz

```python
for p in model.conv1.parameters():
    print(p.data)
model.conv1.bias
model.conv1.weight
```

## Dimension Reduction (t-SNE) of code

DR of code (*feature map*) can show the topology of code space and put the images on the code space can show which dimension in code space correspond to which feature.

**Note**: This is a quite global view on CNN visual processing, which is to D.R the whole manifold of images and seek cluster in it. 

## Manipulate(Occlude) the input picture

* 对刺激 做减法! 在不影响表现的前提下 剩下的是最重要的 (Regularize) 
* Occlude part of the input image to see if it can be recognized by the Conv net
* Slide the occlusion square to see the change of recognition score

## Activation Maximization

* Activation Maximization
	* generate the most responded image by back-propagation. 
	* 

## Find most responsed stimuli

* Image Selectivity:  human eye classifying. just find the most responded input image. 

## Tuning Curve

* Plot response w.r.t. some feature / attribute of image


## Deconv / Inverting

[Visualizing and Understanding Convolutional Networks](http://arxiv.org/abs/1311.2901)

[Deep Inside Convolutional Networks: Visualising Image Classification Models and Saliency Maps](http://arxiv.org/abs/1312.6034) 

[SVCCA: Singular Vector Canonical Correlation Analysis for Deep Learning Dynamics and Interpretability](https://arxiv.org/abs/1706.05806) 



