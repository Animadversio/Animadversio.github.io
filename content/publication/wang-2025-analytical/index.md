---
title: An analytical theory of power law spectral bias in the learning dynamics of
  diffusion models
authors:
- Binxu Wang
date: '2025-03-01'
publishDate: '2025-08-08T05:00:23.711084Z'
publication_types:
- article-journal
publication: '*NeurIPS 2025 (spotlight, top 3%) — arXiv:2503.03206*'

url_pdf: https://arxiv.org/abs/2503.03206

tags:
  - Diffusion
  - Learning Dynamics
  - Theory
  - Science of AI

abstract: 'We present an analytical framework for understanding how distributions evolve during diffusion model training. Using a Gaussian-equivalence principle, we solve gradient-flow dynamics for linear and convolutional denoisers, then integrate the resulting probability-flow ODE to derive analytical expressions for generated distributions. Our key finding is a universal inverse-variance spectral law where the time for an eigen- or Fourier mode to match its target variance scales as τ∝λ⁻¹, meaning coarse structures are learned much faster than fine details. Analysis of deep linear networks and circulant convolutions shows weight sharing accelerates but does not eliminate this bias, while local convolution creates qualitatively different learning dynamics. Experiments on Gaussian and natural-image datasets validate this spectral law in deep MLPs, though convolutional U-Nets show different behavior with rapid near-simultaneous emergence of modes, suggesting local convolution uniquely reshapes learning dynamics in diffusion models.'

# Display this page in the Featured widget?
featured: true
---
