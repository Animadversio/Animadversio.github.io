---
layout: post
title: Math Intensive Github Blog Construction
author: Binxu Wang
date: Sept 10th, 2018
comments: true
tags: [tech note, jekyll, blog construction]
---
**Tools**: Github.page + jekyll + MathJax + Disqus + Google Analytics

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
