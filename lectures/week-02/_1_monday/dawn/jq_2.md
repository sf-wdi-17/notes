# jQuery Overview - Part II

So in Part I, we talked about what jQuery is, learned how to include it in our projects, and worked on selecting DOM elements and then manipulating those elements. Here in Part II, we'll pick up where we left off. So here are our objectives again, with what we've accomplished so far crossed off.

## Objectives
  1. ~~Understand what jQuery is, and when to use it~~
  2. ~~Learn how to include jQuery in your projects~~
  3. ~~Understand how to apply jQuery selectors to manipulate DOM elements~~
  4. Add and remove DOM elements using jQuery
  5. Bind events with jQuery
  6. Explore jQuery Widgets (maybe)
  7. Talk some more about the jQuery object and how it works (maybe)

## Adding and Removing Elements Using jQuery

Sometimes in a dynamic web application, user-input is meant to trigger the addition or removal of content or functionality. Using jQuery, we can easily create new DOM elements and insert them into the DOM, or remove existing elements (and any content they contain) from the DOM.

So, let's imagine we have a web page with the following content on it:

```html
<body>
  <div id="outerContainer">
    <div class="innerItem innerItemHeader">Enjoy some hipster ipsum:</div>
    <div class="innerItem">
      Aesthetic migas paleo McSweeney's, pork belly Kickstarter Echo Park sriracha keytar disrupt viral drinking vinegar fanny pack typewriter.
    </div>
  </div>
</body>
```

Let's say we want to add some more hipster ipsum to the page. Something like:

```html
<div class="innerItem">
	Farm-to-table Godard roof party bespoke, fashion axe mustache vinyl.
</div>
```

To add this DIV, and our hipster ipsum content using jQuery, we'd do the following:

```js
// Define a new DIV and assign jQuery object to $newDiv
$newDiv = $('<div>');

// Add hipster ipsum content
$newDiv.html("Farm-to-table Godard roof party bespoke, fashion axe mustache vinyl.");

// Set it's class to innerItem
$newDiv.addClass("innerItem");

// Append our new element  
$('#outerContainer').append($newDiv);
```

See this in action (and play around with it) [on JSBin](http://jsbin.com/gupade/3/edit?html,js,output)

*Updates to come...*

