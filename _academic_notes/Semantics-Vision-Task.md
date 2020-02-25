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

2010 PAMI Felzenszwalb, Object detection with Discriminatively Trained Part Based Model 

Here we have a graphical model $G=(V,E)$ MRF. 

* Vertex is different part of object.  
  * Cost can be the single part (linear) detector's prediction. 
  * Use HoG feature map and linear detector for each object. 
* Edge is the connection between parts. 
  * Can use a **spring cost**. Difference between distance and expected distance $\|p_i-p_j-(p_{i0}-p_{j0})\|$ 
  * You can add a window and upper bound for this spring cost. 

$$
\mathcal L=\sum_im_i(p_i)-d_{ij}(p_i,p_j)
$$

*Efficiency Note*: 

* MRF can be inferenced efficiently if it's a tree! 
* We could build a tree like MRF, and a special case star MRF. And the root node can even be an abstract location! 
  * However, it cannot express all constraints for a physical entity! A general MRF is more expressive but harder to tackle with. 
* Efficient inference for this model 
  * Add a canonical distance / location for each part $(\delta_{x,i},\delta_{y,i})$ 

$$
\mathcal L(p_0,...p_n)=\sum_0^n 
$$



*Note* : 

* The maximization can be very inefficient if 
* Finally, it's just convolution (local part detector), moving a window, and maxpooling
* Maxpooling kind of relax the geometric distance constraint of 1 single filter! ("Parts can move now! ")  

**Training Method**

* Latent SVM, train the internal classifiers. 

> This obsolete model has all the components that a modern CNN has! 
>
> * "Hand craft" feature map: SIFT, HoG
> * Max pooling: allowing slack relationships between parts 
> * Learning method: end to end training! No longer latent SVM. 

# Semantic Vision with CNN

CNN based Object Detection 

## Taxonomy of Tasks



## Object Detection

The challenge is to propose arbitrary number bounding box and 

### R-CNN

2014 CVPR, Girshick 

R-CNN,i.e. region with CNN features 

* Propose boxes
* Warp your box 
* Pass through 



They used MRF based method to do region proposal, Min Cut algorithm. 

Constraint Parametric Min Cuts for Automatic Object Segmentation 



2015 ICCV, Fast RCNN 

* Improve R-CNN to share computation from the start! (R-CNN warp each bounding box so you cannot share convolution)
* You 

2015 NIPS, Faster RCNN

* Note, you can have more than one  BB centered at each pixel. 
  * You cannot let one pixel output only one box, 
* Non-maxima suppression to reduce redundancy of bounding box. 
* Run classifier

### YOLO



* First split the image into multiple bounding boxes. 
  * Each bounding boxes has a bunch of class labels

* Predict property of the box 
  * 4 coordinates and confidence "objectness" 
* Product of objectness $\times$ bounding box label $=$ Final object label. 
* Classifier and Box proposal can run in parallel! 
* 



**Limitation**

* There is a strong assumption about object size and grid size! 
  * Scales dependent! But, you can run multiscale YOLO
* This is super fast, now you can run YOLO real time! Features are real robust! 



> Object detection is very important, and can be super slow. YOLO change that



## Image Segmentation 

**Segmentation vs Detection**

* Detection is able to detect different instances (*dog1 bb, dog2 bb, not dogs*)
* Segmentation usually just has the class label (this pixel belongs to a "dog" according to background). 

### Image Instance Segmentation 

> Not just say this pixel is a car, but also label different car instances as different label.

Combine the 





Neural network version of border distance transform 



