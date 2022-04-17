---
layout: page
title: Notes Feed
hide: false
---

{% assign all_posts = site.posts | concat: site.academic_notes | concat: site.tech_note %}
{% assign sorted_notes = all_posts | sort:"date" | reverse %}

{% assign pageIdx = 14 %}
{% assign post_num = sorted_notes.size %}
{% assign total_pages = post_num | divided_by: site.paginate | plus: 1 %}
{% assign startIndex = pageIdx | minus: 1 | times: site.paginate %}
{% assign endIndex = pageIdx | times: site.paginate %}

{{post_num}} posts in total, in {{total_pages}} pages, {{startIndex}} to {{endIndex}}. 

{% assign prevflag = 1 %}
{% assign nextflag = 1 %}
{% assign prevIdx = pageIdx | decrement %}
{% assign nextIdx = pageIdx | increment %}

<!--

{% for c in sorted_notes %}
  {% if c.title == page.title %}
    {% assign currentItemIndex = forloop.index0 %}
    {% if forloop.index == 1 %}
      {% assign prevflag = 0 %}
      {% assign nextflag = 1 %}
    {% elsif forloop.index == forloop.length %}
      {% assign prevflag = 1 %}
      {% assign nextflag = 0 %}
    {% endif %}
  {% endif %}
{% endfor %}

{% if prevflag == 1 %}
  {% assign prevItemIndex = currentItemIndex | minus: 1 %}
  {% assign prevPost = site.your_collection[prevItemIndex] %}
{% endif %}

{% if nextflag == 1 %}
  {% assign nextItemIndex = currentItemIndex | plus: 1 %}
  {% assign nextPost = site.your_collection[nextItemIndex] %}
{% endif %} -->


<ul>
  {% for post in sorted_notes %}
  {% if forloop.index0 < endIndex and forloop.index0 >= startIndex %}
  {% unless post.categories contains 'personal writing' %}
      <div class="post-teaser">
            {% if post.thumbnail %}
            <div class="post-img">
                <a aria-label="{{ post.title }}" href="{{ post.url | relative_url }}">
                    <img alt="{{ post.title }}" src="{{ post.thumbnail | relative_url }}">
                </a>
            </div>
            {% endif %}
            <span>
                <h2>
                  <a aria-label="{{ post.title }}" class="post-link" href="{{ post.url | relative_url }}">
                    {{ post.title }}
                  </a>
                </h2>
                {% include blog/post_info.liquid author=post.author date=post.date %}
          </span>
        </div>
     <!-- <h3><a href="{{ post.url }}">{{ post.title }}</a> </h3> 
     {% include blog/post_info.liquid author=post.author date=post.date %} -->
      <!-- -<b><i> {{ post.date | date: "%b %-d, %Y" }} </i></b>  {{ post.author }} 
      <p> {{ post.excerpt | strip_html | truncate:150 }} </p> -->
      <!-- {% capture tag_list %}{{ post.tags | join: "|"}}{% endcapture %}
      {% include default/tags_list.liquid tags=tag_list %} -->
  {% endunless %}
  {% endif %}
  {% endfor %}
</ul>

<!-- <div id="post-nav">
    {% if prevPost.url %}
    <a class="prev" rel="prev" href="{{ prevPost.url }}">
        <span> Prev{{ prevPost.title }}</span>
    </a>
    {% endif %}
    {% if nextPost.url %}
    <a class="next" rel="next" href="{{ nextPost.url }}">
        <span> Next {{ nextPost.title }} </span>
    </a>
    {% endif %}
</div>
 -->
{% if total_pages > 1 %}
<div class="pagination">
  
    <div class="previous">
        
        {% if prevIdx != 1 %}
        <!-- << -->
        <a aria-label="{{ site.data.language.str_previous_page | default: 'Prev' }}" href="{{ site.collection_paginate_path | relative_url | replace: ':num', 1 }}" class="button">
            <span><i class="fas fa-angle-double-left"></i></span>
        </a>
        {% endif %}
        
        <!-- < previous -->
        {% if pageIdx != 1 %}
        <a aria-label="{{ site.data.language.str_previous_page | default: 'Prev' }}" href="{{ site.collection_paginate_path | relative_url | replace: ':num', prevIdx }}"
           {% unless prevflag %}style="visibility:hidden"{% endunless %} class="button">
            <span><i class="fas fa-chevron-left"></i></span>
            {{ site.data.language.str_previous_page | default: "Prev" }}
        </a>
        {% endif %}
    </div>

    <div class="page_number">
        {{ pageIdx }} / {{ total_pages }}
    </div>

    <div class="next">
        
        <!-- next > -->
        {% if pageIdx != total_pages %}
        <a aria-label="{{ site.data.language.str_next_page | default: 'Next' }}" href="{{ site.collection_paginate_path | relative_url | replace: ':num', nextIdx }}"
           {% unless nextflag %}style="visibility:hidden"{% endunless %} class="button">
            {{ site.data.language.str_next_page | default: "Next" }}
            <span><i class="fas fa-chevron-right"></i></span>
        </a>
        {% endif %}

        {% if nextIdx != total_pages %}
        <!-- >> -->
        <a aria-label="{{ site.data.language.str_next_page | default: 'Next' }}"
        href="{{ site.collection_paginate_path | relative_url | replace: ':num', total_pages }}" class="button">
            <span><i class="fas fa-angle-double-right"></i></span>
        </a>
        {% endif %}
        
    </div>
</div>
{% endif %}