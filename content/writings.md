---
title: 'Writings'
date: 2024-05-19
type: landing

design:
  # Section spacing
  spacing: '5rem'

# Page sections
sections:
#   - block: collection
#     content:
#       title: Mathematics Notes
#       filters:
#         tags: ['Math']
#         # categories: ['mathematics']
#         folders:
#           - academic_note
#           - tech_note
#       sort_by: 'Date'
#       sort_ascending: false
#       count: 50
#     design:
#     #   view: article-grid-w-tags
#       view: citation-w-tags
#       columns: 2
  - block: collection
    content:
      title: Selected Writings
    #   text: I enjoy making things. Here are a selection of projects that I have worked on over the years.
      filters:
        folders:
          - academic_note
          - tech_note
        featured_only: true
      count: 10
    design:
      view: article-grid
      fill_image: false
      columns: 2
  - block: collection
    content:
      title: Academic Notes
    #   text: I enjoy making things. Here are a selection of projects that I have worked on over the years.
      filters:
        folders:
          - academic_note
        # featured_only: true
    design:
      view: article-grid-w-tags
      fill_image: false
      columns: 3
  - block: collection
    content:
      title: Technical Notes
    #   text: I enjoy making things. Here are a selection of projects that I have worked on over the years.
      filters:
        folders:
          - tech_note
        # featured_only: true
      count: 6
    design:
      view: article-grid-w-tags
      fill_image: false
      columns: 3
#   - block: taxterm
#     content:
#       title: All algorithm posts
#       taxonomy: tags
#       term: misc
#     design:
#       view: citation-w-tags
---

<!-- 
## All algorithm posts
{{< taxterm taxonomy="categories" term="algorithm" view="citation-w-tags" >}} -->