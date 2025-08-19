---
# Leave the homepage title empty to use the site title
title: ""
date: 2025-08-10
type: landing

design:
  # Default section spacing
  spacing: "6rem"

sections:
  - block: resume-biography-3
    content:
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: admin
      text: ""
      # Show a call-to-action button under your biography? (optional)
      button:
        text: Download CV
        url: uploads/resume.pdf
    design:
      css_class: dark
      background:
        color: black
        image:
          # Add your image background to `assets/media/`.
          filename: stacked-peaks.svg
          filters:
            brightness: 1.0
          size: cover
          position: center
          parallax: false
  - block: markdown
    content:
      title: |-
        My research: 🧠 → 🖼️  

        Generative Models x Visual Neuroscience
      subtitle: ''
      text: |-
        I'm a research fellow at Kempner Institute for the Study of Natural and Artificial Intelligence at Harvard University, 
        
        I work at the intersection of generative model and visual neuroscience -- generating images from the brain, and dissecting how generative models actually work. I combine theory and experiments, with a toolkit spanning geometry, interpretability, and optimization. 

        I blog about deep learning, math and neuroscience.

        Feel free to reach out for questions and collaborations 😃
    design:
      columns: '1'
  - block: collection
    id: papers
    content:
      title: Selected works
      count: 6
      filters:
        folders:
          - publication
        featured_only: true
    design:
      view: article-grid
      columns: 2
  - block: collection
    content:
      title: Recent Publications
      text: ""
      filters:
        folders:
          - publication
        exclude_featured: false
    design:
      # view: citation
      # view: citation-w-tags
      view: citation-w-tags-imgs
  - block: collection
    id: talks
    content:
      title: Recent & Upcoming Talks
      filters:
        folders:
          - event
    design:
      view: article-grid-imgs
      columns: 1
---
