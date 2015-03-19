#Intro to DOM and DOM Events

| Objectives |
| :---- |
| Students should be able to select elements from the DOM using selectors |
| Students should be able to add events to elements in the DOM |
| Students should be able to manage scope and control logic with the page. |

# Part 1: DOM

Yesterday we learned about JavaScript. Today we will look into how
JavaScript can be used to interact with HTML (and CSS).

## Selecting HTML elements

If you want to interact with your HTML from JavaScript, you need a way
to reference the HTML elements in the page. For example, if you want
to use JavaScript to change a `<ul>`, you'll need to grab it by its
ID, its class, or its tag name.

The following are different functions for grabbing elements on the
page:

- `document.getElementById`
- `document.getElementsByClassName`
- `document.getElementsByTagName`
- `document.querySelector`
- `document.querySelectorAll`

Note: `getElementById` and `querySelector` return one element, while
the rest return lists of elements.

## Manipulating HTML elements

Once you have a reference to an HTML element, what can you do with it?
Well, you can change its contents, change its style, or change some of
its attributes.

- `.innerHTML`
- `.style`
- `.getAttribute` and `.setAttribute`
- `.value` (for `<input>` elements)

## Example

```html
<p id="myTitle">Hello, World!</p>
```

```javascript
var title = document.getElementById("myTitle");
console.log(title.innerHTML); // logs "Hello, World!"
title.innerHTML = "Hi, Bob!" // changes page to display "Hi, Bob!"
title.style.backgroundColor = "yellow";
title.style.color = "red";
title.style.height = "100px";
title.setAttribute("id", "yourTitle"); // don't do this. unusual to change ID.
```

## Exercises

In the [dom_exercises](https://github.com/wdi-sf-jan/dom_exercises)
repository, we have some in-class examples to work through. Clone the
repository to your computer using the `git clone` command.

## References

- [Document Object Model](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)
- [.getElementById](https://developer.mozilla.org/en-US/docs/Web/API/document.getElementById)
- [.getElementsByClassName](https://developer.mozilla.org/en-US/docs/Web/API/document.getElementsByClassName)
- [.getElementsByTagName](https://developer.mozilla.org/en-US/docs/Web/API/document.getElementsByTagName)
- [.querySelectorAll](https://developer.mozilla.org/en-US/docs/Web/API/Document.querySelectorAll)
- [.innerHTML](https://developer.mozilla.org/en-US/docs/Web/API/Element.innerHTML)
- [.getAttribute](https://developer.mozilla.org/en-US/docs/Web/API/element.getAttribute)

# Part 2: DOM Events

Another thing we can do is listen for
__events__ on those elements. For example, we can ask to be notified
when a button is clicked, when the mouse is moved, or when a form is
submitted.

## Listening for DOM events

- `.addEventListener`

## Events

Some common events:

- `click`, `mousedown`, and `mouseup`
- `mouseover`, `mouseout`, and `mousemove`
- `keydown`, `keypress`, and `keyup`
- `submit`
- `load`

## Example

```html
<button id="howdy">Hello</button>
```

```javascript
function showPopUp() {
  alert("the button was clicked");
}

var taco = document.getElementById("howdy");
taco.addEventListener("click", showPopUp);
```

Alternative event listener syntax:

```javascript
function showPopUp() {
  alert("the button was clicked");
}

var taco = document.getElementById("howdy");
taco.onclick = showPopUp;
```

## Exercises

We will continue to do the exercises in the
[dom_exercises](https://github.com/wdi-sf-jan/dom_exercises)
repository from this morning.

- Work through the Parts 1-3 in the `events` exercises.

## The `event` object

You may have noticed that the function that acts as the event handler
accepts one parameter. By convention, we usually name this parameter
`event` (sometimes you'll see it named `e`).

- `event`
    - `.preventDefault()`: prevents the brower's default action. One
      example usage is stopping the page from refreshing when a form
      is submitted.
    - `.target`: refers to the HTML element that triggered the event.

## Exercises

- Work through the `events` exercises continuing from Part 4.

## Resources

- [DOM Events](http://en.wikipedia.org/wiki/DOM_events)
- [.addEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget.addEventListener)
- [.preventDefault](https://developer.mozilla.org/en-US/docs/Web/API/event.preventDefault)
