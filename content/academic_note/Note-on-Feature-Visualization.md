---
layout: post
title: Note on Feature Visualization (Updating)
author: Binxu Wang
date: 2019-09-17
comments: true
# use_math: true
math: true
categories: [machine learning]
tags: [academic note, computer vision, machine learning, optimization]
typora-copy-images-to: ../assets/img/notes/cv/
---

# Note on Feature Visualization 

## Motivation

* We want to understand what the hidden units "represent"
  * What are they tuned to? What's the favorite stimuli? 
* Why should we find the most excitable stimuli? 



## Resources

* [DeepDream.ipynb](https://github.com/tensorflow/examples/blob/master/community/en/r1/deepdream.ipynb) Tensorflow

* [Another DeepDream.ipynb](https://github.com/google/deepdream/blob/master/dream.ipynb) Tensorflow. 
* [Post of fast Feature Visualization](https://towardsdatascience.com/how-to-visualize-convolutional-features-in-40-lines-of-code-70b7d87b0030)  PyTorch. 
  * Explicit blurring to counteract high frequency. Optimize and resize to make multi-scale feature visualization. Very similar to DeepDream
* [Another Synthesis post](https://dudeperf3ct.github.io/visualize/cnn/catsvsdogs/2018/12/02/Power-of-Visualizing-Convolution-Neural-Networks/)
* [Zoo of feature visualization notebook](https://github.com/utkuozbulak/pytorch-cnn-visualizations) PyTorch 
* [Distill pub's systemic treatment of FV](https://distill.pub/2017/feature-visualization/) 
  * [Effect of Regularization on Feature Visualization](https://colab.research.google.com/github/tensorflow/lucid/blob/master/notebooks/feature-visualization/regularization.ipynb) 
  * From their treatment, it seems the `lucid` package attached to tensorflow `lucid.optvis.render` can generate the most useful and good looking visualizations. The major techniques utilized are Spatial Decorrelation and Feature Decorrelation. And use some transform to improve the robustness of visualization
  * Should consider having it in pytorch in the future. 
* [Integrating FV modules into toolkit](https://distill.pub/2018/building-blocks/)



## Overview of Algorithms

The basic idea of feature visualization is to optimize for the images that highly activate a hidden unit (or a weighted sum of them), so that its activity could be understood as coding for that feature. 

The big enemy of FV is the high frequency artifact, which will arise if you directly back-propagate activity back to pixel space! Kind of visual illusion for CNN, and note these kinds of artifacts can be used as attacks to manipulate the classification result of CNN. And below we will talk about the ways to defeat these artifacts and make pretty looking images. 

**Remark** : Activation maximization using back-prop has a really close relationship with Generative model and GAN. 

* Functionally, they are all taking in an activation pattern (hidden vector) and output an image
* Mechanistically, the `upconv` operation in GAN is just `TransposeCOnv`, which is exactly the same operation happened when the gradient vector propagate backward from deeper layers to shallower layers.
  * Thus they are all using activation in the higher layers to generate filter patterns repetitively! 

Common Algorithms Zoo https://github.com/utkuozbulak/pytorch-cnn-visualizations

## Regularization

There are 3 major groups of regularization. 

* Directly eliminate high frequency components
  * By adding Variation energy during optimization 
  * Or by blurring the image! 
* Reparamtrize the image and add weights to different directions in that parameter space. 
  * Use FFT parametrization, 
  * Or use GAN parametrization etc. 
* Robustness to perturbation
  * Add jitter and noise and see if the activation is stable across these perturbations. 

## Optimization

Aside from regularization, another major component of feature visualization algorithms is the optimizer, which optmizer they use and the initialization they use may affect the success of optimization and speed of convergence. Here are some classes of algorithms

* 0-order methods 
  * Genetic algorithm
  * CMA-ES
* 1-order methods
  * SGD
  * Momentum
  * Adam, AdaGrad, AdaDelta, RMS-prop etc.
* Pseudo 2-order methods
  * LFBGS

### Example: Deep Dream

It's a Gradient Ascent but the point is to generate good looking images, thus some regularization techniques are used! Like L1, L2! 

Matlab has a nested bunch of functions, the major ones are these. 

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

Core code is just like this 

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

### Example: Lucent Framework

Lucent is a recent pytorch implementation of Lucid visualization framework. It's core code is super clear and easy to read and modify, so lets take a look

```python
def render_vis(model, objective_f, param_f=None, optimizer=None, transforms=None,
               thresholds=(512,), verbose=False, preprocess=True, progress=True,
               show_image=True, save_image=False, image_name=None, show_inline=False):
    if param_f is None:
        param_f = lambda: param.image(128)
    # param_f is a function that should return two things
    # params - parameters to update, which we pass to the optimizer
    # image_f - a function that returns an image as a tensor
    params, image_f = param_f()

    if optimizer is None:
        optimizer = lambda params: torch.optim.Adam(params, lr=5e-2)
    optimizer = optimizer(params)

    if transforms is None:
        transforms = transform.standard_transforms.copy()

    if preprocess:
        if model._get_name() == "InceptionV1":
            # Original Tensorflow InceptionV1 takes input range [-117, 138]
            transforms.append(transform.preprocess_inceptionv1())
        else:
            # Assume we use normalization for torchvision.models
            # See https://pytorch.org/docs/stable/torchvision/models.html
            transforms.append(transform.normalize())

    # Upsample images smaller than 224
    image_shape = image_f().shape
    if image_shape[2] < 224 or image_shape[3] < 224:
        transforms.append(torch.nn.Upsample(size=224, mode='bilinear', align_corners=True))

    transform_f = transform.compose(transforms)

    hook = hook_model(model, image_f)
    objective_f = objectives.as_objective(objective_f)

    if verbose:
        model(transform_f(image_f()))
        print("Initial loss: {:.3f}".format(objective_f(hook)))

    images = []

    try:
        for i in tqdm(range(1, max(thresholds) + 1), disable=(not progress)):
            optimizer.zero_grad()
            model(transform_f(image_f()))
            loss = objective_f(hook)
            loss.backward()
            optimizer.step()
            if i in thresholds:
                image = tensor_to_img_array(image_f())
                images.append(image)
        images.append(tensor_to_img_array(image_f()))

    if save_image:
        export(image_f(), image_name)
    if show_inline:
        show(tensor_to_img_array(image_f()))
    elif show_image:
        view(image_f())
    return images
```

