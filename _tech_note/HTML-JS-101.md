





## Motivation

HTML is a dead document. Javacript inject the soul to it and make it interactable. In this note I'm introducing a few key examples of interacting with HTML. 

## Basics

`console.log` is basically the print operation

`alert` is the webpage version of print operation

for ... of  and for ... in are different 

```javascript
for (const idx of ['a', 'b', 'c']) console.log(idx);
for (const element in ['a', 'b', 'c']) console.log(element);
```



## Input Trigger Some Property Change

This is a very useful coding pattern. Like a input checker or toggle can cause other input fields to appear or disappear. 

[Use CheckBox to trigger some change](https://stackoverflow.com/questions/4471401/getting-value-of-html-checkbox-from-onclick-onchange-events)

Override submit button of Mturk 

https://stackoverflow.com/questions/56830521/how-to-override-the-crowd-html-submit-button-to-include-additional-data



## Event Driven Programming

### Keyboard Events



https://www.javascripttutorial.net/javascript-dom/javascript-keyboard-events/

### Get a List of EventListener

https://www.sqlpac.com/referentiel/docs-en/javascript-listing-active-event-listeners.html

This trick secretly stores a list / dict of event listener by overriding the original addEventListener function. 

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