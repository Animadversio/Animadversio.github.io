





## Motivation

HTML is a dead document. Javacript inject the soul to it and make it interactable. In this note I'm introducing a few key examples of interacting with HTML. 

## Input Trigger Some Property Change

This is a very useful coding pattern. Like a input checker or toggle can cause other input fields to appear or disappear. 

[Use CheckBox to trigger some change](https://stackoverflow.com/questions/4471401/getting-value-of-html-checkbox-from-onclick-onchange-events)



## HTML <form>



## Access Object in HTML

Major tool is this function `querySelectorAll` and the selector syntax like `CSS_Selectors`. See the doc for [selector](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors) and [query](https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll) . This is kind of like a small version of regular expression. 

For example:

* `.classname` will select for any element with a class attribute matching `classname` . 
* `elementtype` , `"input"` will match any `<input>` element.



## Shadow Root

Shadow root is like a private part in the whole document tree. Direct search may not get elements in it, and we have to search from the shadow root. 

https://www.sitepoint.com/the-basics-of-the-shadow-dom/

https://stackoverflow.com/questions/53460850/shadow-root-getelementsbyclassname