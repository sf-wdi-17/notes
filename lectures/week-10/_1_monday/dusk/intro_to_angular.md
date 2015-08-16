# Intro To Angular

![](angularjs.jpeg)

# Angular. A Whole new World.

| Objectives  | 
| :----     |
| Student should use data binding in views: `ng-model`, `ng-bind` |
| Students should be comfortable with commonly used directives: `ng-repeat` with `ng-model` or `ng-bind`. |
| Students should use directives together to create templates   |

## TOC

[TOC]

## Outline

  * What is Angular?
    - AngularJS is a client-side Javascript framework for adding interactivity to HTML. It lets you use **HTML** as your template language and lets you extend HTML's syntax to express your application's components clearly and succinctly.
    - If you're curious, check out:
    [Sites that use `Angular'](https://builtwith.angularjs.org/)

  * Let's take a step back:
    - If what you need are static documents, HTML is a great _declarative language._
    - But when it comes to creating applications, we've seen that HTML (on its own) comes up short (very short). 

As a result, building web applications is essentially about figuring out different ways to trick the web browser into doing what we need.

We've seen a few examples of this already:

  * Using a server side application written in a programming language to dynamically generate HTML.
    - When a request is made, that HTML is generated and sent back as the response.
    - This works, but on its own, this makes for web applications that are anything but intuitive and user friendly.
  * Using vanilla javascript or jQuery to manipulate the DOM
    - So this at least allows us to create a user experience that is more similar to a normal `native` application. 
    - User actions can produce near instant results, but:
    - Without some link to a server, data persistence is difficult if not impossible to acheive.

So, we need some way to link our server idea, and our DOM manipulation:

  * AJAX:
    - We've seen that using AJAX in either vanilla JS, or jQuery, we can connect to a server in the background of a web application, retrieving stored data as needed.
    - But this still has 1 disadvantage for the kind of apps we usually build (CRUD apps):
      + Our data models, and our views are not synchronized.
      + If our data is updated on the server, our views don't automatically reflect those changes.
      + As a developer, we end up spending a lot of time making sure that whenever something on the backend changes, it's communicated to the front-end, and vice versa.

Enter `Angular` (and a bunch of other modern MVC frameworks)
 
###Why `Angular`? How is it different?

Angular was built with a specific use case in mind m(the most common use case for modern web applications): An application where a persistent data store is used to display data in a template for a user to interact with.

With Angular, everything is turned upside down, that is:

  * It used to be that the client (browser) was really stupid. And the server was the smart component.
    - The server did all the work of control flow, data modeling, and rendering and the browser simply accepted whatever HTML it was given.
  * But with Angular, it's the opposite.
    - The front end is the _'smart'_ component, and the server is quite basic
    - The server becomes mainly a data store. Returning that data in JSON format.
      + The client then takes that data, and decides what to do with it.

Eseentially, **Angular**:

  * Reduces the impedance (for the developer) by dealing with the inherent mismatch between document centric HTML and what a _live_ application needs by creating new HTML constructs on-the-fly.
  * Angular does this using an MVC model:
    - You split your app into MVC components, and Angular takes care of the rest.
    - Angular manages your components for you 
    - Angular serves as the pipeline that connects them (using something we call **2-way data binding**).


###Getting Started
  * To get started, we're going to just use a CDN hosted version of AngularJS. We can find these versions at:
    - [CDNJS](http://cdnjs.com/libraries/angular.js/) - Use this one for now
    - [Google Hosted Libraries](https://developers.google.com/speed/libraries/)
  
### Angular Concepts in Brief

#### Angular Directives

What's a "directive?"
  
  * In Angular, we add behavior to our HTML through directives. A directive is a marker on a HTML tag that tells Angular to run or reference some Javascript code.
    - In your HTML, they'll take the form of an HTML attribute, prefixed with `ng-` (i.e., `<div ng-style="">`)
    - In documenation, they'll be camelCased, per the usual javascript style:
      + `ngStyle`

The first directive to know about is `ngApp`. It denotes the beginning of an angular application.

```html
<body ng-app>
 <!-- Everything between these body tags will have access to angular data bindings -->
</body>
```

The `ngApp` directive attaches the `application module` to the page.

#### Angular Expressions in HTML Templates (`{{...}}`)

In angular, we use double brackets (for the most part) to evaluate variables and other expressions within our HTML templates.

```html
<body ng-app>
  1 + 2 = {{1+2}} <!-- This will print 3 -->
</body>
```

#### What's this 2-Way Data Binding Thing?

##### First, let's talk about the usual 1-way bindings:

Most templating systems only bind data in one direction. A template (i.e., `index.html.erb`) is merged with model components (i.e., `<%= model.content %>`) to form a view and that view is sent to the client fully rendered.

But once the merge/render occurs, new changes to the model will not be reflected in the view, and changes to a user makes within a view are not reflected in the model.

So as developers, we end up having to write code to **glue** all of this together.

![One Way Data Binding](oneway.png)

####2-Way Data Binding in Angular Templates

Angular templates work differently. First the template (which is the uncompiled HTML along with any additional markup or directives) is compiled on the browser. The compilation step produces a **live view**. 

Because the view is **live**, any changes to the view are immediately reflected in the model, and any changes in the model are propagated to the view.

As a developer, this is great: It means the model is the **single-source-of-truth** for the application state. You can think of the view as simply an instant projection of your model.

This has a number of advantages:
  * Aside from how damn cool it is,
  * Testing is a snap
    - Because the controller is completed separated from the view (let's think about how this is different from what we've seen elsewhere) we can test our controller in isolation.
  * We get to write waaayyyy less code for the right kind of applications.

![Two-Way Data Binding](twoway.png)

#### Some Other Common Built-in (meaning part of the `ng` module) Directives

##### ngBind

`ngBind` provides a way to bind a particular HTML tag to a particular programmatic expression (could be something in your data model, or a mathematical expression, or really anything else that's a valid expression.)

**So?**
This is awesome, because the text inside the element will be updated whenever the value of the given expression changes.

Also, sometimes, it can be cleaner to use `ngBind` than to fill up your templates with `{{...}}` template brackets.
  
```html
<div ng-app>
  1 + 2 = 
  <span ng-bind="1+2">
    <!-- Angular will fill this in with '3' (the result of the expression 1+2) -->
  </span>
</div>
  
```

We can also use `ng-bind` to set the value of a variable
  
```html
<div ng-app>
<p>1 + 2 = <span ng-bind="answer=3"></span></p>
<p>
Now we can use that answer somewhere else:<br />
Divide {{answer}} by 2 = {{answer/2 | number}}
</p>
</div>
```

If you're paying close attention, you're probably wondering what the `| number` part of that is. This is called an [**angular filter**](https://docs.angularjs.org/guide/filter) and it's a powerful feature that allows you to ensure that the result of an expression will be formated in a particular way.


#####ngStyle

`ngStyle` allows you to conditionally set the style of an HTML element (think inline style, `style=""`).

```html
<div ng-app>
    <span ng-bind="myStyle={color:'red'};"></span>
    The following text is <span ng-style="myStyle">important</div>
</div> 
```

######Exercise:

  * Set a variable `greeting` using `ng-bind` and display it.
    + Ex: `greeting="Hello there"`
  * Try to set both a `name` and a `salutation` in the same `ng-bind` statement and then display them in the html using `{{..}}`
    + Did it work?  *(Hint: use `;` to separate the declaractions)* 
    + Try setting a few more/other variabels in a single `ng-bind` statement and try moving them around (in terms of the order of declaration)
      - Can you identify a pattern that determines which value is getting displayed?

How can we get around the problem of an `ng-bind` always displaying something? Maybe with an object notation?
  
```html
<div ng-app>
  <span ng-bind="person={firstname:'john', lastname: 'doe'};"></span>
  <p>{{person.firstname}}</p>
  <p ng-bind="person.lastname"></p>
</div>
```

#####ngRepeat

`ngRepeat` is a loop directive. It will essentially loop over a collection of data, re-creating the HTML element and everything in it for item in the collection.

Each template instance gets its own [scope](https://docs.angularjs.org/guide/scope), and a special variable called `$index` is created that is set to the item index (for an array) or key (for an object).
  
So this code in an Angular HTML Template:
```html        
<div ng-app>
  <div  ng-init="friends=['larry', 'moe', 'curly']">
    <div ng-repeat="friend in friends"> <!-- The loop will start here and include this div -->
      {{friend}}
    </div> <!-- The loop will end here and include this closing tag. -->
  </div>
</div>
```

Essentially produces this:
```html
<div ng-app>
  <div ng-init="friends=['larry', 'moe', 'curly']">
    <div>
      larry
    </div>
    <div>
      moe
    </div>
    <div>
      curly
    </div>
  </div>
</div>
```

####ngInit

You may be asking, what's the `ng-init=""` thing?

The `ngInit` directive allows you to evaluate an expression in the current scope. Essentially, you can initialize a variable with a particular expression, but unlike `ngBind`, `ngInit` is not then linked to the data source or expression, so changes to the expression won't change anything in your view.
  
######Exercise

Make an array of friends that are objects where each has a `name` and `style` attribute, e.g. `friends=[{name: 'moe', style: {color: blue}}]`.

Use `ngRepeat` to loop over this array, displaying your friend's name with the style applied.

**HINT**: You'll have to use 1 more directive to be able to access this `friends` collection.

#####`ngModel` and Angular Forms

The `ngModel` directive binds an input, select, textarea (or custom form control) to a property in the current scope using `NgModelController`, which is automatically created and exposed by this directive. (We'll talk more about custom controllers over the course of this week).

`ngModel` is responsible for:

  1. Binding the view into the model, which other directives such as input, textarea or select require.
  2. Providing validation behavior (i.e. required, number, email, url).
  3. Setting related css classes on the element (ng-valid, ng-invalid, ng-dirty, ng-pristine) including animations.
     
Example 1: (try this, is your mind blown yet?)
     
```html
<div ng-app>
	<form>
		<input type="text" ng-model="favoriteColor">
  </form>
	
	Your favorite color is  {{favoriteColor}}
</div>
```
     
Example 2: (try this, now your mind has to be blown...)
     
```html
<div ng-app>
  <form>
    <input type="text" ng-model="favoriteColor">
    <input type="checkbox" ng-model="showTemplate">
  </form>
  <div ng-show="showTemplate">
    Your favorite color is  
    <span ng-style="{color: favoriteColor}">
      A color
    </span>
  </div>
</div>
```
     
######Exercise:
    
1.) Use `ng-style` and `ng-model` in a form to create a form selector that let's you pick from a few options for the background colors. 
*(Hint: Use the `backgroundColor` key instead of `background-color`)*

2.) Go to Google fonts and pick out three favorite fonts and drop them into your `head`, then use the `ng-style` and `ng-model` directives to change the text color and font.
     
     
#####ngList

`ngList` is used as part of a text input field. It converts between a delimited string and an array of strings. The delimiter can be a fixed string (by default a comma) or a regular expression.

Try this, and then fill in the text field with a string like this: "Book 1, Book 2" and watch what happens when you check the box.

```html
<div ng-app>
  <form>
    <input type="text" ng-model="favoriteBooks.names" ng-list> <br>
    Show Result
    <input type="checkbox" ng-model="showTemplate">
  </form>
  <div ng-show="showTemplate">
    <div ng-repeat="name in favoriteBooks.names">
      Why do you like {{name}}?
    </div>
  </div>
</div>
```


     	
######Exercises:
     
1.) Use the `ng-list` and `ng-model` directives with a textarea in a form to list out your favorite movies. Use the `ng-repeat` directive to iterate over the array of `favoriteMovies`.

2.) Use `ng-style` and a form inside the `ng-repeat` from exercise `1` that allows you to change both the background and font color.

3.) Add a form outside the `ng-repeat` in exercise `2` that allows you to change the background color of the application.


##### Some Other Really Cool Features

   * `ng-cloak` - directive is used to prevent the Angular html template from being briefly displayed by the browser in its raw (uncompiled) form while your application is loading.
   * `ng-pluralize` - directive that displays messages according to en-US localization rules
   * `ng-filter` - Selects a subset of items from array and returns it as a new array
   
If you're really into Angular by the end of this, follow [Google's Angular Blog](http://blog.angularjs.org/)!
