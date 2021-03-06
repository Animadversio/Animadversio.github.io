---
layout: post
title: Math Intensive Github Blog Construction
author: Binxu Wang
date: Sept 10th, 2018
comments: true
categories: [coding]
tags: [tech note, jekyll, blog construction]
---
# Overview
**Objective**: 

* Build a online blog. Most preferably
* Posts can be written in Markdown, which is the format of most of my notes.
    - Math formula (in Latex syntax) and equation rendering are

**Solution**

After researching for some time (like 10 hours, I start from afternoon and get posts online at midnight), I found this combination of tools can perfectly suits my need! 

**Tools**: Github.page + jekyll + MathJax + Disqus + Google Analytics

* `Github.page`: provide the space / server that the pages lives on. But the basic `Github.page` does not support math rendering. So that trigger this whole research. 
    - As we base the system on `Github.page`, it's pretty easy to upload. Just use `git push` to deploy the website. 
* `Jekyll`: A "blog-aware, static site generator in Ruby", which means it compiles the Markdown and whatever you write into `html` webpages and link them together. And it allows local server to preview the website. 
* `MathJax`: Math formula rendering engine, which is supported in `Jekyll`. 
* `Disqus`: Tool for discussion under post. 
* `Google Analytics`: Tool to inspect the most visited page and article. 

Basing on these tool, I can achieve likewise result as Wordpress blog site, and the style and site structure are far more versatile. Besides, the whole solution is free. 

# Tutorials
Some Good tutorial I found: 

I start from this post, aiming at exactly the same thing as I do: 
https://bbabenko.github.io/moving-to-github/

Official Step by Step tutorial
https://jekyllrb.com/docs/step-by-step/08-blogging/

Simple Jekyll tutorial with Github Pages
https://briancaffey.github.io/2016/03/17/jekyll-tutorial.html


How to use MathJax in Jekyll generated Github pages
http://haixing-hu.github.io/programming/2013/09/20/how-to-use-mathjax-in-jekyll-generated-github-pages/
This tutorial is perfect except a few minor changes we have to make: 
* We do not need to change the markdowen processor now. `kramdown` is OK! 
* And we need a newer MathJax engine to do render. Cf. the news https://www.mathjax.org/cdn-shutting-down/
	* Use `src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js?config=TeX-AMS-MML_HTMLorMML">">` instead of `src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">`

# Issue in Windows 
*Note*: 

If encounter error like `C:/Ruby25-x64/lib/ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59:in `require': cannot load such file -- bundler (LoadError)`
Refers to this [issue](https://github.com/jekyll/jekyll/issues/5165). 
```
$ gem install bundler
$ bundle install
$ bundle exec jekyll serve
```
under current Windows environment, it seems we have to use `bundle exec jekyll serve` to serve it locally. 

If encounter error like `Error:  Permission denied - bind(2) for 127.0.0.1:4000` , [thanks to this post](https://gaohaoyang.github.io/2016/03/12/jekyll-theme-version-2.0/) Just kill the `FxService` in the Service part. 

# How to upload a post? 
(This part is mainly for my own reference)

1. Editing the local repertoire (directory denoted as `.io/`), with any editor you like. (Sublime, Typora, MacDown)
2. Run `jekyll serve` in the console from the directory of `.io/`, preview the changes you've just make. (If you do something to `_config.yml` you'd better restart the `jekyll serve` to see the change.)
3. After you feel everything is good, use `git` in console, or github desktop to `commit` and `push`

# How to add a top bar section

1. add a html at base folder `academic note.html`, like this just a normal html page file. 
2. initialize a folder to contain your posts `.\_academic_notes`
3. change the `_config.yml` file in the `Collections` section 

```yaml
# PORTFOLIO
collections:
  portfolio:
    output: true
    permalink: /:collection/:name
  tech_note:
    output: true
    permalink: /:collection/:name
  academic_notes:
    output: true
    permalink: /:collection/:name

```

# How to add inner link within site. 
See [Controlling url and links in Jekyll](https://www.digitalocean.com/community/tutorials/controlling-urls-and-links-in-jekyll#understanding-how-urls-are-controlled)

Check [Liquid](https://jekyllrb.com/docs/liquid/), [Liquid pkg](https://shopify.github.io/liquid/tags/raw/) and [Link syntax](https://jekyllrb.com/docs/liquid/tags/#links)

{% raw %} 
* Can use variables like `{{ page.previous.url }}`. 
* Can use variables to parse the name of post and form url. `{ % post_url 2010-09-08-welcome-to-jekyll % }`
* Or absolute url like `{{ site.baseurl }}` 
* Note These variables should be placed in `{{` and  `}}` 
{% endraw %}

# Jekyll Relative Link

As a official [post](https://github.blog/2016-12-05-relative-links-for-github-pages/) suggests, the `jekyll-relative-links`  seems to support the links between markdown files and just translate them to links between webpages. This gem could be installed from https://rubygems.org/gems/jekyll-relative-links to local build system. However, the github support for this relative link practise seems problematic. 

https://github.com/benbalter/jekyll-relative-links

https://github.com/github/pages-gem/issues/69



Current modification to make this work include 

* Add `gem 'jekyll-relative-links'
  gem 'wdm', '~> 0.1.0' if Gem.win_platform?` to the `Gemfile`
* Add `jekyll-relative-links (0.6.1)
        jekyll (>= 3.3, < 5.0)` to `Gemfile.lock` 
* Then note that you should not add space in the link `[name](xxx xxx.md)` instead, use ``[name](xxx-xxx.md)` and it will be translated properly! 

# What if `MathJax` is not rendering correctly

`MathJax` is a JS package hosted and maintained by someone else. 

So it's possible that the JS path we are using has suddenly gone down. If so change the `src` in`_include\mathjax_support` . Also additional rendering configurations could be added to config the package. Recently (2020, Nov) the `cdn` server for mathjax has been down, and we will use the MathJax served in `cdnjs` instead. 

```html
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: {
      equationNumbers: {
        autoNumber: "AMS"
      }
    },
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
});
</script>
<script type="text/javascript" async src="//cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
//"https://cdn.jsdelivr.net/npm/mathjax@2/MathJax.js?config=TeX-AMS-MML_CHTML">
//cdn server shut down.... use cdnjs instead from now on. 
</script>
```

Note, MathJax 3 has been out now, but it does not support `\\` as the line changing symbol in latex block.....So we are sticking to MathJax2 until that is supported

https://github.com/mathjax/MathJax/issues/2312