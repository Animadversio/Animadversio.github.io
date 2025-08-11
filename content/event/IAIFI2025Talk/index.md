---
title: IAIFI Summer Workshop Talk

event: NSF IAIFI Summer Workshop
event_url: https://iaifi.org/summer-workshop

location: Harvard University
address:
  street: 
  city: Cambridge
  region: MA
  postcode: 
  country: United States

summary: Analytical Theory of Spectral Effects in Sampling and Learning of Diffusion Model
abstract: |-
  Diffusion models generate complex data by estimating the score (gradient of log-density) across noise levels, but the connection between the learned neural score and the true data score has been unclear.
  
  Inspired by “far field” approximation in physics, we show that both analytically and empirically, for moderate-to-high noise, the learned score function is dominated by its linear component, reflecting a Gaussian approximation of data. This Gaussian score structure allows us to integrate the probability flow ODE in close-form, which yields analytical understanding of the diffusion sampling. Based on the power-law image statistics, this theory explains the fact that coarse aspects (e.g. layouts) were specified first in sampling dynamics; low dimensionality of diffusion sampling trajectory and their perturbation sensitivity. Practically, this solution allows us to skip the first 15–30% of sampling steps with analytical teleportation, accelerating solvers (e.g., DPM-Solver-v3, UniPC) without loss of image quality (FID 1.93 on CIFAR-10).
  
  Inspired by this we further studied the learning dynamics of diffusion models with linear denoisers. For linear, deep linear and linear convolutional networks, we solved the nested probability flow and gradient flow ODE, and derived the exact evolution of the learned distribution. This analysis reveals a universal inverse-variance spectral law (τ∝λ⁻¹): coarse (high-variance) modes converge much faster than fine (low-variance) detail. Weight sharing in deep linear networks uniformly rescales these rates, while local convolution fundamentally alters the spectrum of mode emergence—findings confirmed in MLP-based and convolutional U-Nets on Gaussian and natural-image data.
  
  Our results highlight how data spectrum and network architectures interact to determine the learning and sampling dynamics of diffusion generative model.

# Talk start and end times.
#   End time can optionally be hidden by prefixing the line with `#`.
date: '2025-08-11'
date_end: '2025-08-15'
all_day: false

# Schedule page publish date (NOT talk date).
publishDate: '2025-08-08'

authors:
  - admin

tags: [Diffusion, Science of AI]

# Is this a featured talk? (true/false)
featured: false

# image:
#   caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/bzdhc5b3Bxs)'
#   focal_point: Right

#links:
#  - icon: twitter
#    icon_pack: fab
#    name: Follow
#    url: https://twitter.com/georgecushen
# url_code: 'https://github.com'
# url_pdf: ''
# url_slides: 'https://slideshare.net'
# url_video: 'https://youtube.com'

# Markdown Slides (optional).
#   Associate this talk with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
# projects:
#   - example
---
<!-- 
{{% callout note %}}
Click on the **Slides** button above to view the built-in slides feature.
{{% /callout %}}

Slides can be added in a few ways:

- **Create** slides using Hugo Blox Builder's [_Slides_](https://docs.hugoblox.com/reference/content-types/) feature and link using `slides` parameter in the front matter of the talk file
- **Upload** an existing slide deck to `static/` and link using `url_slides` parameter in the front matter of the talk file
- **Embed** your slides (e.g. Google Slides) or presentation video on this page using [shortcodes](https://docs.hugoblox.com/reference/markdown/).

Further event details, including [page elements](https://docs.hugoblox.com/reference/markdown/) such as image galleries, can be added to the body of this page. -->
