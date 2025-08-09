---
title: 'Talk at VSS2025 Session: Theory - Artificial neural networks'

event: Vision Sciences Society Annual Meeting 2025
event_url: https://www.visionsciences.org/talk-session/?id=392

location: St. Pete Beach, Florida
address:
  street: 
  city: 
  region: 
  postcode: 
  country: United States

summary: Factorized Convolutional Model for Interpreting Neuron Guided Image Synthesis
abstract: |
  'Convolutional neural networks have been extensively used to model neurons in the visual systems of primates and rodents. However, this regression is ill-posed because the number of image-response pairs are often far fewer than the feature regressors. To address this, previous approaches used unsupervised feature reduction (e.g. PCA) and penalized regression (e.g. LASSO). However, these solutions discard the spatial structure of feature, usually leading to non-smooth or non-local weight, harming interpretability. We present a supervised feature reduction method that applies tensor factorization to the covariance between image features and neuronal activations. This factorization generates paired spatial masks and feature vectors, offering clearer insights into which features matter and where they are localized. The method matches the accuracy of penalized regression approaches while providing more precise localization of neuronal receptive fields. To validate our method, we performed closed-loop experiments on neurons recorded from V1, V4, and inferotemporal (IT) cortex in two primates. Using the Evolution paradigm, neurons guided image synthesis through generative networks, and the resulting image-response pairs trained a factorized convolution model. The factor structure in these models allowed further manipulation and ablation study. We shuffled different components in these models as control models and synthesized their maximal activating images. In the same recording session, we presented back these synthesized “optimal” images and measured neuronal responses. Synthesized “optimal” images from the factor model were generally more activating than those from controls; by comparison, we identified the necessary components of the factor model for each neuron. With adversarially trained backbones, we found low-rank, localized read-out weights can synthesize the preferred images as effectively as dense weights, while simplifying the images. In this way, we transformed the dense "black-box" model of a neuron into a part-based model, that was easier to describe and manipulate, helping us understand their natural image tuning.'

# Talk start and end times.
date: '2025-05-19'
all_day: true

# Schedule page publish date (NOT talk date).
publishDate: '2025-08-09'

authors:
  - admin

tags: [Visual Neuroscience, VSS, Conference, Presentation]

# Is this a featured talk? (true/false)
featured: false

url_video: 'https://www.youtube.com/watch?v=Z8pdzfLP-vA'
slides: ""

---