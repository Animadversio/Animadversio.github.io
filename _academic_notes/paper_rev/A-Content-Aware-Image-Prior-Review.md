A Content Aware Image Prior: Review
====

# Summary of Technical Content 

In this work, the motivation is to adapt the image prior towards the local mid level features e.g. textures, such that applying these prior will not blur the texture blindly.

First, the authors characterize natural image by assuming the distribution of gradient factorizes into two generalized Gaussian distributions over the amplitude of aligned gradient $\|\nabla_a x\|$ and the amplitude of orthogonal gradient $\|\nabla_o x\|$, w.r.t. the dominant local orientation. [@cho2010content Sec 3,Sec 4.1] 

$$
\begin{aligned}
 p(\nabla x) = p(\nabla_a x)p(\nabla_o x)\\
 p(\nabla_a x) = {\gamma_a \lambda_a^{1/\gamma_a}\over 2\gamma_a(1/\gamma_a)}\exp(-\lambda_a\|\nabla_a x\|^{\gamma_a})
 \end{aligned}
$$

Traditionally, a generalized Gaussian distribution is parameterized by a width parameter $\lambda$ and a peakiness parameter $\gamma$. Thus the local image prior is parameterized by the 4 parameters $\gamma_a,\lambda_a,\gamma_o,\lambda_o$, which should be estimated from the statistics of gradient surrounding that pixel.

For this, they used an efficient strategy to estimate these parameters. Note that the generalized Gaussian distribution could also be characterized by the variance and 4th moment $v, f$ of the distribution, which uniquely maps to $\lambda, \gamma$. Although $v, f$ are easier to compute from samples (by convolution), $\lambda, \gamma$ are more useful in the final optimization Eq.\[fin\_optim\]. Thus, instead of maximum likelihood estimation of the $\gamma, \lambda$ they compute the statistics $v, f$ from and train a kernel regressor to map them to $\gamma, \lambda$. [@cho2010content Sec 4.3]

A central challenge for content-aware image prior is that, the image prior applied to restoration is dependent on the local image patch. However, for image restoration problem, you only have a degraded version of image $y$ instead of the original one $x$. Thus, for priors on low level features like gradient amplitude, the statistics may be contaminated by the degradation process like motion blur. Thus the learnt prior could encourage noise instead of real texture. Thus, blurring kernel inference and deconvolution process should be done before content aware image prior. In the paper, they use a universal gradient prior (like Eq. \[dist\] with parameters fit from lots of images[@cho2010content Sec 3] ) to deconvolve the image first, and then down sample image to compute the $v, f$ statistics. Downsampling is used because they suggest it will remove deconvolution residue and artifacts but preserve natural gradients, as the former is more scale varying [@lee2001occlusion]. [@cho2010content Sec 4.2]

Moreover, as the prior parameters are estimated from a local patch, collecting gradient samples across texture border is not desirable. This paper tackles this by inferring Gaussian Conditional Random Field model to smooth the texture descriptor only within texture boundary. 

$$
\begin{aligned}
 P(\gamma)=\prod_i \psi(\gamma[i]; \tilde\gamma[i])\prod_{(i,j)\in \mathbb N}\phi_{ij} (\gamma[i], \gamma[j])\\
 \psi(\gamma[i]; \tilde\gamma[i])\propto \exp(-{(\gamma[i]-\tilde\gamma[i])^2\over 2\sigma_l^2})\\
 \phi_{ij} (\gamma[i], \gamma[j])\propto \exp(-{(\gamma[i]-\gamma[j])^2\over 2\sigma^2(i,j)})
 \end{aligned}
$$

The texture boundaries are detected by computing gradient statistics at 2 different scales and see how close they are. The idea is that the more scale-invariant is the texture statistics, the more homogeneous is the neighborhood. To be specific, the width of binary term is a fixed gaussian kernel, and width of the unary term is larger close to boundary. (when the statistics are more different at 2 scales) [@cho2010content Sec 4.4]

Finally, the gradient prior for each pixel is tailored for its local neighborhood, however the final form of optimization problem is the same as applying a normal image prior. Thus, it could still be solved by the Iterative Reweighted Least Square algorithm (IRLS). [@cho2010content Sec 4.5] 

$$
\begin{aligned}
\hat x = \arg\min_x {\|y - k*x\|^2\over 2\eta} + w\sum_{i=1}^N \lambda_o(\hat z[i]) \|(\nabla_o x)[i]\|^{\gamma_o(\hat z[i])} + \lambda_a(\hat z[i]) \|(\nabla_a x)[i]\|^{\gamma_a(\hat z[i])}\end{aligned}
$$



# Novelty/Significance 

Different textures and viewing distance (magnification) will result in different gradient distribution in the patch. Thus, instead of pooling statistics from any image patches together, fit an image prior towards the local image pattern is desirable for restoring fine texture. So this study is one step forward from the traditional image prior work. In experiment, it performs better than other algorithms in denoising and non-blind deconvolution task at high noise case, creates more visually pleasing image.

This work is closely related to the works using local textures to guide the application of image prior. [@bishop2007nonstationary] One of the novelty is their way of detecting and handling texture boundary using Gaussian Conditional Random Field. They have the observation that the change of statistics across scale can signal texture boundary. And GCRF inference help them do the “Bilateral Filtering”.

Another technical significance is their super efficient way of learning the image prior from local statistics. Instead of using maximum likelihood estimation, they compute the **Sufficient Statistics** of the local gradients (moments) just by convolution, and infer the parameter from sufficient statistics by a regression.

# Criticism/Limitations 

Here the texture is encoded by the local variance and 4th-moment of gradient amplitude, which is very limited as local texture descriptor. However, this line of thought can be extended directly to CNN, as the 1st conv layer of CNN is a bunch of simple filters computing gradient like features, and the 2nd conv layer can be thought of as computing the statistics across space and filters. Thus, utilizing the power of pre-trained CNN, we could encode the textures in the channel dimension of feature tensor. Thus matching the distribution of this feature encoding vector will give us similar texture distribution. And learn the texture descriptor on one image and apply that to the other will lend us the power to render texture from one image to the other. In this way, this work is connected to the later Neural Style Transfer work[@jing2019nsf]. In their work, they match the Gram matrix of the feature tensor, i.e. the covariance matrix of the feature vector to transfer the artistic style (texture + color composition) of one image to the other.

Besides, beyond texture, semantic content may be add to this framework, as mid level features like textures could be used to adapt the prior, higher level object information can be used to restore image details. For example, fruit like orange, banana usually has similar texture, thus this can be utilized to adapt the image prior on texture descriptors. This may be the content-aware image prior in the full sense, and it can be connected to the generative network line of work.

Finally, a fundamental limitation of this method is that what it used is less like a prior, but more like local statistics in the image (*posterior*). Thus the prior can be affected by the statistics in noise, blur and deconvolution artifact, which is the authors’ explanation for a worse performance of content-aware image prior for lower noise level denoising ($\sigma=5\%$). For example, their method failed to recover the blurred tree texture, but tolerate the blurry green. [@cho2010content Fig. 8,9,10] They need a better method to **distinguish artifacts and original image statistics** than their current heuristic. (Do not learn noise!) Following the last point, utilizing the higher level information to find the prior may be a way to go.
