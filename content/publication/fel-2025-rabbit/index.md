---
title: 'Into the Rabbit Hull: From Task-Relevant Concepts in DINO to Minkowski Geometry'
authors:
- Thomas Fel
- Binxu Wang
- Michael A. Lepori
- Matthew Kowal
- Andrew Lee
- Randall Balestriero
- Stella Joseph
- Ekdeep S. Lubana
- Talia Konkle
- Demba E. Ba
- Martin Wattenberg
date: '2025-01-01'
publishDate: '2026-04-01T00:00:00Z'
publication_types:
- paper-conference
publication: '*International Conference on Learning Representations (ICLR) 2025*'

url_pdf: https://arxiv.org/abs/2510.08638

tags:
- Interpretability
- Computer Vision

abstract: 'DINOv2 is routinely deployed to recognize objects, scenes, and actions; yet the nature of what it perceives remains unknown. As a working baseline, we adopt the Linear Representation Hypothesis (LRH) and operationalize it using SAEs, producing a 32,000-unit dictionary that serves as the interpretability backbone of our study, which unfolds in three parts. In the first part, we analyze how different downstream tasks recruit concepts from our learned dictionary, revealing functional specialization: classification exploits "Elsewhere" concepts that fire everywhere except on target objects, implementing learned negations; segmentation relies on boundary detectors forming coherent subspaces; depth estimation draws on three distinct monocular depth cues matching visual neuroscience principles. Following these functional results, we analyze the geometry and statistics of the concepts learned by the SAE. We found that representations are partly dense rather than strictly sparse. The dictionary evolves toward greater coherence and departs from maximally orthogonal ideals (Grassmannian frames). Within an image, tokens occupy a low dimensional, locally connected set persisting after removing position. These signs suggest representations are organized beyond linear sparsity alone. Synthesizing these observations, we propose a refined view: tokens are formed by combining convex mixtures of archetypes. This structure is grounded in Gardenfors'' conceptual spaces and in the model''s mechanism as multi-head attention produces sums of convex mixtures, defining regions bounded by archetypes. We introduce the Minkowski Representation Hypothesis (MRH) and examine its empirical signatures and implications for interpreting vision-transformer representations.'
---
