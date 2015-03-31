# Lesson: Express Review

## Learning Objectives ##
Once we've gone through this lesson, we should all:
  - Know what a route is
  - Know what a URL parameter on a route is, and how to access it
  - Know what a query parameter is, and how to access it
  - Understand NPM, and the package.json file it creates
  - Understand some new NPM modules:
      + EJS
      + Body Parser
      + Method Override (if we get to it this morning, otherwise we'll cover this during the afternoon.)

## Routing Review ##
In yesterday's lessons, we learned about HTTP ([Hypertext Transfer Protocol](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)), the components of a URL, and how a route relates to a URL.

### Components of a URL and Routing ###

The URL...
http://www.google.com:80/search?q=taylor+swift

...is made up of the following parts:
<table>
    <tr>
        <th>PROTOCOL</th>
        <th>HOST (AKA DOMAIN)</th>
        <th>PORT</th>
        <th>PATH</th>
        <th>QUERY PARAMS</th>
    </tr>
    <tr>
        <td>http://</td>
        <td>www.google.com</td>
        <td>:80</td>
        <td>/search</td>
        <td>?q=taylor+swift</td>
    </tr>
</table>

<br>
We also learned that a __route__ in Express needs to match the __PATH__ part of a URL. So if we were designing the google.com application, the route we'd use to _catch_ the URL above would be:

```js
app.get('/search', function(req, res) { // do stuff here });
```

But wait, you might be asking yourself, what about the __QUERY PARAM__ `?q=taylor+swift`. You're right, we haven't accounted for that at all. But that's ok, because query params are not specifically included in routes. Luckily, they're accessible in Express using a key on the `req` object called `query`:

To access the `q` parameter in the example above, we'd use the following code:

```js
app.get('/search', function(req, res) {
    console.log("The value of q was:", req.query.q); // Prints "The value of q was: taylor+swift" to the node console.
});
```

### Let's Try Accessing Some URL Params and Query Params Together! ###

To start, let's create a new node application by completing the following steps.

First, let's all `cd` into the directory where you normally keep your WDI code.

Now, at a bash prompt ($), enter the following commands, one at a time, followed by 'enter':
```bash
mkdir express_params_example
cd express_params_example
git init
touch index.js # Creates our main application file
echo "node_modules" > .gitignore # Creates a .gitignore file so node modules won't be included in your git repo
npm init # To continue, just hit enter continually at each prompt
npm install --save express
```

Ok, once you've finished entering the commands above, type `subl .` and hit enter. When Sublime Text opens, choose "index.js" from the list on the left.

Copy and paste the following code into your `index.js` file. Once everyone is finished, we'll talk through the code together and the code we're going to want to add to it to make things work the way we want.

```js
// index.js
// The control file for a node server that will help us demonstrate how
// URL params and query params work.

// So as is typical for node apps, the first thing we do is to initialize our npm modules and assign them to variables.
var express = require("express");
var app = express();

// So let's define some routes to use:

app.get('/', function(request, result) {
    result.send("");
})

// This route catches URLs that have a path that matches http://localhost:3000/person/:name
app.get('/person/:name', function(request, result) {
    result.send("");
});

// This route will help us see how query parameters are passed in:
// We'll use JSON.stringify to convert a JS object into a string that we can display in our HTML
app.get('/queries', function(request, result) {
    // JSON.stringify will help us convert a Javascript Object to a JSON text string
    var queriesAsString = JSON.stringify(request.query);
    result.send("");
});


// This is how you start the server
// We've already seen just "app.listen(3000)"
// Here we see that you can also pass in a callback to be called when the server is started
app.listen(3000, function() {
    var msg = "====== LISTENING ======";
    console.log(msg);
}); 
```

## Starting a Classmates App ##

After completing the prior example, you should hopefully be feeling more comfortable with URL and query parameters.

To keep moving forward, we're going to work together to build an app that will track your classmates.

So once again, let's use `cd` to navigate to the dir where you normally keep your WDI code.

And again, at a bash prompt ($), let's all enter the following commands, one at a time, followed by 'enter':
```bash
mkdir classmates_app_example
cd classmates_app_example
git init
touch app.js # Creates our main application file (usually called app.js)
echo "node_modules" > .gitignore # Creates a .gitignore file so node modules won't be included in your git repo
npm init # To continue, just hit enter continually at each prompt
```

### What's the Deal with NPM? ###

This time, before we run 'npm install', let's take a look at package.json by typing `subl .` at a command prompt and then choosing __package.json__ from the list.

Let's go over how this file is created and what it does, line by line.

And before we run this next command, let's copy and paste our existing `package.json` file into a new empty file so we can compare the before and after states.

Notice that before we run the `npm install --save` command, we have:

```json
{
  "name": "classmates_app",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
``` 

Now let's go ahead and use NPM to install express:

```bash
npm install --save express
```

And afterwards, we have:

```json
{
  "name": "classmates_app",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.12.3"
  }
}
```

Notice the new line that starts with `dependencies` towards the end of the file. So it turns out that like `homebrew`, NPM is a package manager for node applications. And including the `--save` flag when we run `npm install` causes npm to add 'express' to the package.json file as a dependency.

### More NPM Modules! ###

So before we continue, and now that we know what NPM is doing, let's add a few more NPM modules that are going to be helpful. At a bash prompt, type:

```bash
npm install --save ejs body-parser method-override
```

This will install EJS, Body-Parser, and Method-Override:
  - EJS: Stands for "Embedded Javascript"
      + EJS allows us to respond to requests with HTML-like pages.
  - Body-Parser: Helps us to parse the body of a POST request so we can use data submitted in forms.
  - Method-Override: Let's us use the PUT and DELETE methods that are not natively part of web browsers.

## Using EJS to Template our Application ##
 
So we'll start our new node app the same way we usually do:

 `app.js`
```js
// Require the modules we're going to need:
var express = require("express"),
    ejs = require("ejs"),
    bodyParser = require("body-parser"),
    methodOverride = require("method-override");

// Now instantiate our express app:
var app = express();
```

So to use EJS, we'll also want to create a "views" folder in our application where we'll place our EJS templates. To do this, type `mkdir views` at a bash prompt.

Next, we'll want to create an EJS file where we'll place our template.

```bash
cd views # After changing into the views dir, type:
touch index.ejs
```

When you're done, type `cd ..` to go back to the application directory and then we'll continue working on app.js.

So now we have to set up EJS and some of our other modules in the express 'app':

```js
// Set the view engine to be "EJS"
app.set('view engine', 'ejs');

// Set up body parser
app.use(bodyParser.urlencoded({extended: true}));
 
// Set up method override to work with POST requests that have the parameter "_method=DELETE"
app.use(methodOverride('_method'))
```

Ok, now that we have everything configured, let's put together some routes and some views:

```js
// Let's add some routes here together:
app.get('/', function(req, res) {
   res.render('index.ejs'); // We use res.render to display an EJS file instead of res.send() 
});


// Start the server on port 3000
app.listen(3000);
```

### Using EJS ###

So an EJS file is just HTML with special tags that allow us to embed javascript code, variables, and objects into the HTML:

`index.ejs`
```html
<!doctype html>
<html>
<head>
    <title><%= title %></title>
</head>
<body>
    <h1><%= title %></h1>
    <form action="/classmate" method="post">
        <input type="text" name="name" placeholder="Name"> 
        <input type="text" name="age" placeholder="Age">
        <button type="submit">Submit</button>
    </form>

</body>
</html>
```

So what else do you think we could include between the `<%= ... %>` EJS tags?





   










