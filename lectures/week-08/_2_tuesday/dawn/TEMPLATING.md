# Templating with underscore
(it's kind of exactly like ejs)

### Setup: Adding Underscore

```

 curl https://jashkenas.github.io/underscore/underscore-min.js > vendor/assets/javascripts/underscore.js

```

and add the following to `app/assets/javascripts/application.js`

```
...
//= require underscore.js
...

```


##Building a render function to use on the front end
Today we're going to build a `render` function that acts like the one that we've used in both rails and express. To do this we're going to need a templating library.

##Queue in Underscore.js Template
Go to the underscore documentation for [templating](http://documentcloud.github.io/underscore/#template)

###Part 1
**Problem:** Construct a template for a `div` that contains a `name` variable that we provide. To begin go to [jsbin](http://jsbin.com/) and add the underscore library. If you finish early try building some other templates.

*Solution:* [please don't click here until you've tried to do it on your own the point of this lesson is to get you guys comfortable with using documentation as well as introduce templating on the client side](http://jsbin.com/qapeyasafa/1/edit?js,console)

###Part 2
**Problem:** Knowing that underscore templates work exactly like their ejs counterparts, construct a template that iterates through a list of items, that we provide.

*Solution:* [once again please don't click here until you've tried it on your own](http://jsbin.com/wohesixase/1/edit?js,console)

###Part 3
**Problem:** Now that we're building html strings, lets append them to our html document. (Hint: Use jQuery).

*Solution:* [42](http://jsbin.com/zabuyepeki/1/edit?js,output)


###Part 4
**Problem:** Now we're ready to start building our `render` function. What does `render` do?

*Solution:* [Finished Render function](http://jsbin.com/cumixofoca/2/edit)

###Part 5
**Problem:** Build a template for todos so that each todo is it's own `li` html element. Add that template to your `viewRoutes` object. After that use the `render` function we constructed to render a list of todos on our page.

*Solution:*[Celebrate good times come on!](https://www.youtube.com/watch?v=UWLIgjB9gGw)

[the real soltuion](http://jsbin.com/kaliwumibo/1/edit?js,output)