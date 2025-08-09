---
title: SfN 2025 Nanosymposium 

event: Society for Neuroscience Annual Meeting
event_url: https://www.sfn.org

location: San Diego, CA
address:
  street: 
  city: San Diego
  region: CA
  postcode: 
  country: United States

summary: 
abstract: |
  Deep neural networks have become the leading models for predicting neural responses in mid‐to‐higher visual areas of macaques and humans. However, near‐ceiling prediction accuracy can mask whether these models truly capture the neuronal feature tuning or merely exploit spurious correlations. To address this, we leveraged feature accentuation, a technique allowing an encoding model to modify seed images to amplify the features it uses. By synthesizing images predicted to drive a neuron at specified levels, we tested whether encoding models could “control” neural activity across its full dynamic range—an essential criterion for a true “digital twin.”

  In the first session of our closed‐loop paradigm, we recorded responses from five macaques to ∼1,000 natural images in rapid serial visual presentation. Neurons in V3, V4, or anterior IT were recorded via floating microelectrode arrays or Neuropixel probes. Overnight, we fit encoding models by ridge regression on hidden‐layer activations from ten pre‐trained backbones (AlexNet, ResNet, and vision transformers (ViT), including adversarially trained versions). After evaluating accuracy on held‐out images, we selected each channel’s best‐predicting layer. For the most reliable channels, each model generated feature‐accentuated (FA) images at 11 target activation levels—from below to beyond natural‐image responses—using ten seed images.

  In a second recording session, we presented these FA images back and measured actual neural responses, comparing them to model predictions. Although most models (except AlexNet) had similar prediction accuracy on held‐out natural images, their FA images differed substantially across backbones, reflecting diverse features used for prediction. Critically, adversarially trained ResNet and ViT consistently produced FA images that modulated real neurons in the intended parametric manner, with correlation for certain channels beyond 0.8. The FA images appeared more “shape‐like,” whereas those from other models were more “texture‐like,” suggesting that adversarial training promotes features better aligned with cortical neurons. 

  Overall, our results demonstrate that standard fitting and evaluation procedure can yield models with equivalent predictive scores yet rely on different—and sometimes spurious—features. Closed‐loop control is a more stringent test, revealing that adversarial training encourages shape‐based representations that better match true neural tuning. Our comparison paves the way for developing foundation models of visual cortex and predicting causal interventions for neural control. 


# Talk start and end times.
date: '2025-11-15'
all_day: true

# Schedule page publish date (NOT talk date).
publishDate: '2025-08-08'

authors:
  - admin

tags: [SfN, Visual Neuroscience, NeuroAI, Conference]

# Is this a featured talk? (true/false)
featured: false

slides: ""

---