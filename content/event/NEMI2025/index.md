---
title: NEMI 2025 Workshop Poster

event: 2nd New England Mechanistic Interpretability (NEMI) Workshop
event_url: https://nemiconf.github.io/summer25/

location: Northeastern University, Curry Student Center
address:
  street: 360 Huntington Ave
  city: Boston
  region: MA
  postcode: 02115
  country: United States

summary: The attention mechanism underlying relational object generation in text-to-image diffusion transformers
abstract: |
  'Diffusion models and their flow-matching variants dominate text-to-image (T2I) generation, yet many pre-trained models struggle to interpret spatial relationships between objects in prompts.

  We built a synthetic dataset of paired text–image examples depicting two objects in simple spatial relations (e.g., “red square to the right of blue circle”) and trained PixArt-style Diffusion Transformers (DiTs) from scratch with different prompt encodings: T5, random token embeddings (RTE), and random embeddings with positional encoding (RTEP). Surprisingly, embedding choice had a strong effect: RTEP models learned relations far more reliably than T5 or plain RTE.

  Using a scalable search over millions of attention maps, we identified a consistent “**relational head**” in RTEP-trained models: a cross-attention head linking image-position encodings to relational word embeddings (Query-key, QK), tagging the canvas location for the first object (Value-output, VO). A downstream head then reads this tag to retrieve that object’s shape and color attributes (QK) and translates the words into visual appearance (VO). This mechanism underlies strong compositional generalization to novel object relation combination. Ablating the relational head degrades relational accuracy. This two-head circuit parallels positional signaling in developmental biology, where molecular gradients specify location before identity.

  The relational head emerged robustly across model scales with RTEP, but not with T5, suggesting that the symmetry of random embeddings facilitates its learning, whereas contextual word embeddings could hinder it. Our results reveal a simple, interpretable attention circuit for mapping relational words to spatial layouts, and highlight how text embedding design can affect learning and generalization of object relationships in T2I models.'

# Talk start and end times.
date: '2025-08-22'
all_day: false

# Schedule page publish date (NOT talk date).
publishDate: '2025-08-21'

authors:
  - admin

tags: [Mechanistic Interpretability, Transformer, Diffusion, Science of AI, NEMI]

# Is this a featured talk? (true/false)
featured: false

slides: ""

---

Presenting a poster on "The attention mechanism underlying relational object generation in text-to-image diffusion transformers" at the 2nd New England Mechanistic Interpretability (NEMI) Workshop.

**Session:** Poster Session 1 (11:45 AM - 1:00 PM)
