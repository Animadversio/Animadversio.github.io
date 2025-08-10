---
layout: post
title: JavaScript + HTML Programming 101 (Updating)
author: Binxu Wang
date: Nov 21st, 2020
comments: true
use_math: true
categories: [coding]
tags: [tech note, coding, GUI, web, psychophysics]
---

## Motivation

Last we we are pushed to a weird domain, using MTurk to assess perceptual properties of some images. And the major technical challenge is to make a form like question page in MTurk, using my close to zero prior knowledge on JavaScript. Here are something I learnt along this. In this note I'm introducing a few key examples of using JavaScript to interact with HTML. 

## Concepts

Basically, HTML is a dead document with different contents (image, text, audio) marked up with `id` `tag` `name` etc. JS inject the soul to it and make it interactable. For example, it can find the contents by their, `id` `tag` `name` etc. and manipulate their property such as making it disappear or appear. 

JavaScript is *light weight* in the sense that you usually don't need an IDE to play with it. Chrome is equipped with a JavaScript console and a HTML structure inspector, so it's very suitable for development. 

As it's showing a web page, 

## Common Commands

* `console.log` is basically the print operation

* `alert` is the webpage version of print operation, showing a pop out

Two version of loop function, `for ... of`  and `for ... in` are different 

```javascript
for (const idx of ['a', 'b', 'c']) console.log(idx); // "a" "b" "c"
for (const element in ['a', 'b', 'c']) console.log(element);// "0" "1" "2"
```



## HTML `<form>`



## Access Object in HTML

Major tool is this `querySelectorAll` and the selector syntax like `CSS_Selectors`. See the doc for [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors) and [query](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll) . This is kind of like a small version of regular expression. It returns a list of matching elements (Nodes) in the document.

For example:

* `.classname` will select for any element with a class attribute matching `classname` . 
* `elementtype` , `"input"` will match any `<input>` element.

HTML has a tree like structure, as each node has a `querySelectorAll` function



Note `getElementById` and `getElementbyName` are useful functions but not as powerful as `querySelectorAll` . Also because the `getElementByName` is not available for ShadowRoot as we will see below. 



## Shadow Root

Shadow root is like a private part in the whole document tree. Direct search may not get elements below it, and we have to search from the shadow root. 

This is clear if you inspect your interested element in Chrome inspector, and you will see a `shadowroot` on the path. 

https://www.sitepoint.com/the-basics-of-the-shadow-dom/

https://stackoverflow.com/questions/53460850/shadow-root-getelementsbyclassname
Override submit button of Mturk 

https://stackoverflow.com/questions/56830521/how-to-override-the-crowd-html-submit-button-to-include-additional-data



## Event Driven Programming

### Keyboard Events



https://www.javascripttutorial.net/javascript-dom/javascript-keyboard-events/

### Get a List of `EventListener`

https://www.sqlpac.com/referentiel/docs-en/javascript-listing-active-event-listeners.html

This trick secretly stores a list / dict of event listener by overriding the original `addEventListener` function. 

```javascript
Window.prototype._addEventListener = Window.prototype.addEventListener;

Window.prototype.addEventListener = function(a, b, c) {
   if (c==undefined) c=false;
   this._addEventListener(a,b,c);
   if (! this.eventListenerList) this.eventListenerList = {};
   if (! this.eventListenerList[a]) this.eventListenerList[a] = [];
   this.eventListenerList[a].push({listener:b,options:c});
};
```







```javascript
function listAllEventListeners() {
  const allElements = Array.prototype.slice.call(document.querySelectorAll('*'));
  allElements.push(document);
  allElements.push(window);

  const types = [];

  for (let ev in window) {
    if (/^on/.test(ev)) types[types.length] = ev;
  }

  let elements = [];
  for (let i = 0; i < allElements.length; i++) {
    const currentElement = allElements[i];
    for (let j = 0; j < types.length; j++) {
      if (typeof currentElement[types[j]] === 'function') {
        elements.push({
          "node": currentElement,
          "type": types[j],
          "func": currentElement[types[j]].toString(),
        });
      }
    }
  }

  return elements.sort(function(a,b) {
    return a.type.localeCompare(b.type);
  });
}
```



[Event Listener](https://developer.mozilla.org/zh-CN/docs/Web/API/EventTarget/removeEventListener)

### EventListener and Handling Priority

https://stackoverflow.com/questions/19469881/remove-all-event-listeners-of-specific-type/19470348

> If two event handlers are bound to the exact same object, it would be first come, first serve. The first one attached will execute first.
>
> But, your example looks a bit different. It looks like you also have one event bound to the `input` object and others to the parent `li` object. In that case, the one where the event actually originated (presumably the `input` element in this case) will occur first and then the event will bubble up to the parent objects and they will occur later.

## Examples

### Input Trigger Some Property Change

This is a very useful coding pattern. Like a input checker or toggle can cause other input fields to appear or disappear. 

The key for this function is to add a `onclick` function to the block i.e. `<div>` that the content resides. 

[Use CheckBox to trigger some change](https://stackoverflow.com/questions/4471401/getting-value-of-html-checkbox-from-onclick-onchange-events)

