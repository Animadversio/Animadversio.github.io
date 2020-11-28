## Problem Statement

Given a bunch of data 

This is a little bit different from Interpolation in that, interpolation usually assumes your data is sparse, and is noise-small. So you can interpolate and get a degenerated version of it. 

For Regression problem, sometimes, you are data dense, and the data is full of noise thus doing interpolation will give you overly noisy data. However you can smooth the data by some estimation. 

## Kernel Regression

Kernel regression can be thought of as an extension of nearest neighbor interpolation. 

> The value probed $f(\hat x)$ is the weighted average value of the data samples around it. $f(\hat x)={\sum_i w(x_i,\hat x)y_i /\sum_i w(x_i,\hat x)}$ 



Comparison:

* bilinear interpolation can be thought of in this camp.
* Kernel Density Estimation, it's estimate the density without the y label! 





## Gaussian Process Regression

