





Basic Stereo algorithm can be formulated as 



Thus Methods in MRF inference could all be used. [Prior](Note-on-Image-Prior.md) 



## Planar Prior 

Natural scene is usually piece-wise! How to impose this idea to depth map? 

So basic procedure: 

* Do disparity map $D(x,y)$ 
* Run SGM type MRF inference algorithm, get a initial depth estimate
* Use super-pixel clustering to find a region of pixel that may **lie  on a single plane**.  
* Do a smooth plane fit to the initial depth

2013 ECCV

**SLIC cost**
$$
\alpha\|I[n]-\mu^i_k\|^2+\beta\|n-\mu^s_k\|^2+\gamma\|d^0[n]-\alpha_kn_x-\beta_kn_y-\gamma_k\|^2
$$
For each cluster it has parameters $\mu^i_k,\mu^s_k,\alpha_k,\beta_k,\gamma_k$  mean pixel value, mean spatial location and the plane going through it. 

**SLIC** essenstially is a K-means clustering, so it's iteratively doing 

* Assign pixel to cluster 
* Fit the parameters for the cluster. 
  * Here we will find the mean pixel value, plane parameters. 





What's the right superpixel size? Can't be too small or too large. 

Maybe run MRF on the superpixels! And merge then iteratively. 

### Superpixel MRF

[Continuous Markov Random Fields for Robust Stereo Estimation](https://arxiv.org/abs/1204.1393)

BMX

* Each superpixel has a node. Each node has 3 parameters, $y_k=[\alpha_k,\beta_k,\gamma_k]$ .

* Unary cost, is the residue of the single pixel. $\|d^0[n]-\alpha_kn_x-\beta_kn_y-\gamma_k\|$ 

* Construct a graph with all neighboring superpixels getting an edge, with an additional label $o_{ij}$ describing the geometric relationship of the 2 planes. 
  * The label is a discrete label define the states, and the costs come in $\phi(o_{ij},y_i,y_j)$ 
  * Note this could be extend naturally to 3-way junction and 4-way clique and enforce geometric constraint on it. 

**Geometric Relationships** 

* Co-planar: Mean depth difference between the 2 plane over all pixels of union ($P_1\cup P_2$)
  * $$
* Hinge: Mean depth difference between the 2 plane over all pixels on boundary ($P_1\cap P_2$) 
  *  $$
* Occlusion: left occlusion, right occlusion. If there is pixel on the boundary that the front patch gives a larger depth value than the back patch. 
  * $$





Thus you get 

**Inference** 

* Particle belief propagation for continuous variables
* Use factor graph to tackle 3 way relationship. 
* Use library of MRF solver it will work ! (SOTA! 2012)

> Note, if you can define your MRF, then solving MRF has established libraries, which is powerful. 

## 

Why do we need superpixels? 

* MRF cannot be too large! 
* SLIC is dirty but fast! 

Lower level vision by consensus in a spatial hierachy of regions 

Use a hierarchy of multi-scale overlapping patches, $S=\{4,8,16,32\}$, $stride=1$ . 

Use a parameter $I_i$ to describe if it's planar or not! And a parameter $\theta_i$ describing the planar parameters



Alternatively updating $\{I_i,\theta_i\}$ and $d_i$

* Updating $\{I_i,\theta_i\}$ , 
* Updating $d_i$ pixelwise independent, i.e. find mean of the depth estimation across all patches covering this pixel AND is planar. 



Still too computational intense! Regular square patch can help us, all these computation could be done in convolution. 

* 
* Besides, using $log_2$ scale will help us aggregate information across scale. 

## 

