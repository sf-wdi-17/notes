# Refactor Tic-Tac-Toe using jQuery

| Objectives |
| :---- |
| Students should be able to use jQuery in place of window.onload |
| Students should be able to select elements from the DOM using selectors using jQuery |
| Students should be able to use jQuery methods in place of their javascript counterparts |
| Students should be able to add events to elements in the DOM using jQuery |


## Using jQuery as window.onload

Using jQuery we can convert

```js
window.onload = function() {
  // Code in here
};
```
We can use jQuery to clean things up a little
```js
$(function() {
  // Code goes here
});
```

## Use jQuery to select elements from the page

By using jQuery with CSS selectors, we can effectively grab elements off of the page.

```js
// Grabbing an element by an id
document.getElementById('myId')

// Grabbing elements by a class name
document.getElementsByClassName('myClass')

// Grabbing elements by a tag name
document.getElementsByTagName('div')
```

becomes

```js
// Grabbing an element by an id
$('#myId')

// Grabbing elements by a class name
$('.myClass')

// Grabbing elements by a tag name
$('div')
```

## Use jQuery's built in methods in place of their javascript counterparts
jQuery's built in methods make it simpler to modify the DOM

```js
var el = document.getElementById('myId');

// Grabbing an elements inner HTML
el.innerHTML; // => returns the inner html

// Setting an elements inner HTML
el.innerHTML = "My cool new inner HTML";

// Adding a class to an element
var classList = el.getAttribute('class');
el.setAttribute('class', classList + ' ' + 'newClass');

// Removing a class from an element
var classList = el.getAttribute('class').replace('oldClass ', '');
el.setAttribute('class', classList);
```

becomes

```js
var $el = $('#myId');

// Grabbing an elements inner HTML
$el.html(); // => returns the inner html

// Setting an elements inner HTML
$el.html("My cool new inner HTML");

// Adding a class to an element
$el.addClass('newClass');

// Removing a class from an element
$el.removeClass('oldClass');
```

## Adding event listeners to elements

```js
var el = document.getElementById('myId');

el.onclick = function(event) {
  // Code goes here
};
```

becomes

```js
var $el = $('#myId');

$el.click(function(event) {
  // Code goes here
});


