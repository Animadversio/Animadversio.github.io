# Semantics Vision Task

Note semantics and geometric reasoning is conceptually similar to each other

* Stereo and Optical flow is about finding correspondance / matches. 
* Object recognition in some sense is finding correspondance w.r.t. a template, and make the template match the observation. 



So ancient semantic detector works like this 

* Finding interesting key points
  * You want to make it sparse, make the matching problem easier. 
  * Need to have non-smooth area, 
* Region detectors, make it invariant to physical changes as possible. 



## Keypoint Detector

What is a good Keypoint Detector?  

* Superpixel is not a good candidate
  * Shape, boundary, change too much, not invariant across scene. 
* 



###  SIFT

Set a few heuristic rules to detect blobs. 

#### Blob Detector

Basically, blob detector could be designed by convolve with some filter and select local maximum (non-maximum suppression). Could use a Laplacian of Guassian as kernel, 
$$
K=\nabla^2G(0,\sigma^2)
$$
This is the so called center surround receptive field. 

*Note*: 

* Only the right size of gaussian $\sigma$ can detect the blob, or you will only detect the blob if the scale matches. 
  * If the scale doesn't match, the laplacian can fire as well! 
* So you need to search in scale space. 

#### Scale Space

Do the filtering in multiple scales, and detect local maximum in 3d neighborhood. but the higher the $\sigma^2$ the smaller the filter output







#### Efficiency consideration

Use the Difference of Gaussian (DoG) instead of Laplacian of Gaussian for faster computation (at 2004...), because you can filter image with a pyramid of Gaussians and just take difference between 2 neighbors. 

![]()



#### Suppress Edge

Compute Hessian of image local patch (Structural Tensor) at the scale of image. And set a criterion that the 2 eigen value of the 

* 



### SIFT Descriptor

This are done *post hoc*, describe the keypoints by a vector to match in this feature spcve . Note, ref, Census transform and Hamming distance is the most basic feature descriptor. 

**Desiderata**

* Hope to be lighting, scale, rotation. 

**Rotation invariance**

* Do angular histogram for the gradient, center gradient 

**Full SIFT descriptor**

* Subdivide
* Finally do the 

**Affine Invariance**

* Find the dominant direction by defining the matrix. 



> Anciently, there is a huge effort to make the better, and evaluate what features should be invairant across view. Things could still be learnt about how features statistics change across view / light
>
> 2005 Gradient descent of a bunch of researchers

### Usage of SIFT

* Even for geometric matching, when you cannot afford to do the dense matching / disparity map
* SIFT could be used to make a coarse match 



## Content Based Image Retrieval

> Note this is quite hard... no one really solve it even now. 

Given a query image, find all other images that are "similar". Thus you need a whole image descriptor to match each other. 

2003 ICCV Video Google: Sivic Zisserman 

> Note at 2003 NLP is more successful than CV.... so people map semantic vision task to NLP problem to solve. 

* Step 1: Map SIFT descriptors as words, reduce continuous output to discrete
  * Do clustering on all SIFTS into discrete labels. 
  * Note normalized the continuous space by the overall covariance matrix of Descriptor
  * *Post hoc* drop those words that are too frequent or too rare! (Cluster size is too large or too small.) 
* Step 2: Document images as bag of words, and match image based on occurence of words. 
  * Record labels 



Building a vocabulary of all possible photographs is hard! (Image Atoms for Object Recognition)



> General idea, the keypoint detector and descriptor could be used to solve object recognition problem. 

##  HoG Human Detection

CVPR 2005 Dalal Triggs

> Note pedestrian detection and face detection was the only obj detection task at the time... 

**Basic Thoughts**

* Moving a fixed box across image, 
* Use a binary detector to say if it's a human
  * In their case, do HoG on non-overlapping patches in the box, 
  * Use SVM / perceptron like linear classifier to say if it's human. 

**Practise**

* 

* Note the binary detector could be applied by convolution the feature tensor for all overlapping patch. (Here its HoG vector.)

**Comments**

* It's in its essense 1 layer convolutional NN, huge kernel and hand crafted HoG feature descriptor. 
* Current CNN is using the Conv Layers to do feature extraction. 

**Limitation**

* This is a single template for an object, doesn't tolerate deformmed spatial structure. 
  * Note this works for pedestrain and face, as pedestrain and face usually has fixed spatial structure. 

## Deformable Parts Model

> SOTA for a while, inspired modern CNN 

2010 PAMI Felzenszwalb 

Here we have a graphical model $G=(V,E)$ MRF. 

* Vertex is different part of object.  
  * Cost can be the single part (linear) detector's prediction. 
* Edge is the connection between parts. 
  * Can use a spring cost. Difference between distance and expected distance 
  * $\|p_i-p_j-(p_{i0}-p_{j0})\|$ 

$$
\mathcal L=\sum_im_i(p_i)-d_{ij}(p_i,p_j)
$$

*Efficiency Note*: 

* MRF can be inferenced efficiently if it's a tree! 
* We could build a tree like MRF (star MRF), and the root node can even be an abstract location! 
  * However, it cannot express all constraints for a physical entity! A general MRF is more expressive but harder to tackle with. 

