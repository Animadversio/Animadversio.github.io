---
title: A Random Matrix Perspective on the Consistency of Diffusion Models
authors:
- Binxu Wang
- Jacob A. Zavatone-Veth
- Cengiz Pehlevan
date: '2026-01-01'
publishDate: '2026-01-01T00:00:00Z'
publication_types:
- article-journal
publication: '*arXiv preprint arXiv:2602.02908 (under review at ICML)*'

url_pdf: https://arxiv.org/abs/2602.02908

tags:
- Diffusion
- Theory
- Science of AI

abstract: 'Diffusion models trained on different, non-overlapping subsets of a dataset often produce strikingly similar outputs when given the same noise seed. We trace this consistency to a simple linear effect: the shared Gaussian statistics across splits already predict much of the generated images. To formalize this, we develop a random matrix theory (RMT) framework that quantifies how finite datasets shape the expectation and variance of the learned denoiser and sampling map in the linear setting. For expectations, sampling variability acts as a renormalization of the noise level through a self-consistent relation σ² ↦ κ(σ²), explaining why limited data overshrink low-variance directions and pull samples toward the dataset mean. For fluctuations, our variance formulas reveal three key factors behind cross-split disagreement: anisotropy across eigenmodes, inhomogeneity across inputs, and overall scaling with dataset size. Extending deterministic-equivalence tools to fractional matrix powers further allows us to analyze entire sampling trajectories. The theory sharply predicts the behavior of linear diffusion models, and we validate its predictions on UNet and DiT architectures in their non-memorization regime, identifying where and how samples deviates across training data split. This provides a principled baseline for reproducibility in diffusion training, linking spectral properties of data to the stability of generative outputs.'
---
