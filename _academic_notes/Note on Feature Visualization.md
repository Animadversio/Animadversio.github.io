---
layout: post
title: Note on Feature Visualization 
author: Binxu Wang
date: Semptember 17th, 2019
comments: true
use_math: true
categories: [algorithm]
tags: [academic note, computer vision, machine learning]
typora-copy-images-to: ../assets/img/notes/cv/

---

# Note on Feature Visualization 

## Motivation

* We want to understand what the hidden units "represent"
  * What are they tuned to? What's the favorite stimuli? 
* Why should we find the most excitable stimuli? 



https://github.com/tensorflow/examples/blob/master/community/en/r1/deepdream.ipynb

https://github.com/google/deepdream/blob/master/dream.ipynb



## Algorithms



**Remark** : Activation maximization using back-prop has a really close relationship with Generative model and GAN. 

* Functionally, they are all taking in an activation pattern and output an image
* Mechanistically, the `upconv` operation in GAN is just `TransposeCOnv`, which is exactly the same operation happened when the gradient vector propagate backward from deeper layers to shallower layers.
  * Thus they are all using activation in the higher layers to generate filter patterns repetitively! 

Common Algorithms https://github.com/utkuozbulak/pytorch-cnn-visualizations

### Deep Dream

It's a gradient Ascent Step but the point is to generate good looking images, thus some regularization techniques are used! 

Like L1, L2! 

Refer to 

* `nnet.internal.cnn.visualize.VisualNetwork.createVisualNetworkForChannelAverage(iNet, layerIdx, channels)`
* `nnet.internal.cnn.visualize.deepDreamImageLaplacianNorm`
* `nnet.internal.cnn.visualize.TiledGradients.computeTiledGradient`
  * Compute gradient for tiles to save memory! 

* `nnet.internal.cnn.visualize.LaplacianPyramid.laplacianNormalizedImage`
  * Normalize the gradient as image in different laplacian levels! Prefer lower frequency stuff! 

```matlab
function gradient = iNormalizeGradient(X,gradient) 
gradient = gradient ./ shiftdim(std(reshape(gradient, [], size(X,4))) + 1e-9, -2); 
end
```

>An image can be compressed into a Laplacian pyramid, and then the pyramid can be merged to give back the original image. In Laplacian pyramid normalization, we normalize each image in the pyramid before merging.



Core code is just! 

```matlab
for iter=1:numIterations
            [gradient, activations] = nnet.internal.cnn.visualize.TiledGradients.computeTiledGradient(...
                iVisualNet, X, tileSize);
            if useLaplacian
                gradient = iLaplacianNormalizedImage( gradient );
            else
                gradient = iNormalizeGradient(X,gradient);
            end
            
            % Update step.
            X = X + gradient * stepSize;                        
            
            % Display progress.
            summary.update(octave, iter, activations);
            reporter.reportIteration( summary );
end
```

## Systematic Work on Feature Visualization

https://distill.pub/2018/building-blocks/

https://distill.pub/2017/feature-visualization/