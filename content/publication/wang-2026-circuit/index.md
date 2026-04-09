---
title: Circuit Mechanisms for Spatial Relation Generation in Diffusion Transformers
authors:
- Binxu Wang
- Jingxuan Fan
- Xu Pan
date: '2026-06-01'
publishDate: '2026-04-01T00:00:00Z'
publication_types:
- paper-conference
publication: '*Conference on Computer Vision and Pattern Recognition (CVPR) 2026 (highlight, top 3%)*'

url_pdf: https://arxiv.org/abs/2601.06338

tags:
- Diffusion
- Interpretability
- Mechanistic Interpretability
- Computer Vision
- Science of AI

featured: true

abstract: 'We investigate mechanistic interpretability in Diffusion Transformers (DiTs) for text-to-image generation, focusing on how these models generate correct spatial relations between objects. Training DiTs of varying sizes with different text encoders on a task requiring generation of images with two objects whose attributes and spatial relations match text prompts, we discover that spatial-relation information is passed to image tokens through a two-stage circuit involving separate cross-attention heads when using random text embeddings. With pretrained T5 encoders, the DiT employs a different circuit that leverages information fusion in the text tokens. Notably, while both approaches achieved similar in-domain performance, their robustness to out-of-domain perturbations differed significantly, suggesting challenges in generating correct spatial relations in real-world applications.'
---
