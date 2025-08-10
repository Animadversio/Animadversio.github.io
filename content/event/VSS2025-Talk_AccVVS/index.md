---
title: 'Talk at VSS2025 Symposium Model-optimized stimuli: more than just pretty pictures'

event: Vision Sciences Society Annual Meeting 2025
event_url: https://www.visionsciences.org/symposia/?sym=52

location: St. Pete Beach, Florida
address:
  street: 
  city: 
  region: 
  postcode: 
  country: United States

summary: Feature Accentuated Stimuli as a Stringent Test of Model Brain Alignment
abstract: |-
  'Understanding the transformation of visual stimuli into neural activity often involves building image-computable models that predict neuronal responses. While diverse models achieve comparable test accuracies (R²) on benchmarks like BrainScore, this metric may obscure crucial differences between them. Motivated by the idea that a true “digital twin” of neurons should enable the synthesis of stimuli that drive biological neurons toward a desired state, we designed a closed-loop, two-phase experiment to compare the control capabilities of different predictive models.

  In phase one, we recorded neuronal activities in monkey inferotemporal cortex (IT) as subjects fixated on around 1000 images from the Natural Scene Dataset (NSD). For each channel, we fitted neural prediction models using both Ridge and Lasso regression on two backbones—ResNet50 and ResNet50-robust—using PCA for feature reduction. All models exhibited similar test accuracies on held-out NSD images, demonstrating generalization within session.
  
  To assess control capabilities, we generated control images using a feature accentuation method on natural seed images, producing stimuli that activated each model at 10 distinct levels spanning the full dynamic range. Additionally, we synthesized “controversial stimuli” designed to maximize the prediction differences between models. In phase two, neuronal responses to NSD images, accentuated stimuli, and controversial stimuli were recorded. Even though both models predicted responses to NSD images at similar accuracy, accentuated stimuli from ResNet50-robust modulated neuronal firing more precisely than ResNet50.
  
  Further, controversial images that maximize ResNet50 while minimizing ResNet50-robust prediction caused negative modulation of the neurons, whereas images doing the opposite produced positive modulation. This suggests that both models share essential features for predicting natural image responses; however, the brain predictive features unique to ResNet50-robust are more brain-aligned, while those unique to ResNet50 are more spurious. Generally, our results show a dissociation between the prediction and control capability in neural prediction models, and highlights adversarial training as a potential approach to achieve better brain-aligned representation and higher controllability.'

# Talk start and end times.
date: '2025-05-16'
all_day: true

# Schedule page publish date (NOT talk date).
publishDate: '2025-08-09'

authors:
  - admin

tags: [Visual Neuroscience, VSS, Conference, Presentation, NeuroAI]

# Is this a featured talk? (true/false)
featured: true

url_video: 'https://www.youtube.com/watch?v=f3SFQpZ6yOg'
slides: ""

---

{{< youtube f3SFQpZ6yOg >}}
