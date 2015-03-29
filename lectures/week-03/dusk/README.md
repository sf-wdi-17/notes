#Intro to Express

##Before we get started

###Install nodemon
run the command `npm install -g nodemon` anywhere in your terminal. See one of the TA's or Brett if you have any issues.


#Back to the start of our Lecture!
So we've been talking about HTTP, and we've built a simple HTTP Server.

##Review: Simple web server with Node
The below is to demonstrate how Node can be used to create network applications. You can specify exactly how the behavior is.

**server.js**
```js
// Use require to get access to the Node
// http library and store it in a variable.
var http = require("http");

// Define a function doStuff that take in two
// parameters, one for the request called req,
// and one for the response called res.

var doStuff = function(req, res) {

  // Writes the Head of the response with status
  // code 200, specifying that the request is OK,
  // and the body of the response will be given
  // in plain text

  res.writeHead(200, {"Content-Type": "text/plain"});

  // Writes the body of the response with the content
  // 'Hello World'

  res.write("Hello World");

  // Send the response back

  res.end();
};

// Creates a server with the doStuff function
// that will respond to requests and send responses
// as specified.

var server = http.createServer(doStuff);

// Tell the server to start listening for request on
// port 3000

server.listen(3000);
```

Now if we run the file
```bash
$ node server.js
```
And go to ``http://localhost:3000/`` in our web browser, well see a page that says 'Hello World'.

Or alternatively, we can run the `curl` command with the `-i` options flag for `localhost:3000` and see the whole HTTP response.

```
curl -i localhost:3000
```

**Exercise 1:** With your buddy, modify our server file to send back a string of html that has an h1 that says 'Hello World!'. Clone [this](https://github.com/sf-wdi-17/simple-server) repo and change into the directory.

**Think About:** Right now our entire website is a single page. No matter what url we try to go to, we always get the exact same thing. It doesn't matter if we go to [http://localhost:3000/](http://localhost:3000/) or [http://localhost:3000/abcdefg](http://localhost:3000/abcdefg), we always send back the same exact thing. **How could we solve this problem?**

While we could build a web app entirely from scratch, we'd only be making more work for ourselves; we'd be reinventing the wheel and we don't want to do that.

###Queue in Web Frameworks
A web framework a peice of software that is designed to support the development of dynamic websites, web applications, and other web services. The goal of a framework is to reduce the overhead associated with common activities performed when building a web app.

In short, a framework is a bunch of code that makes developing web apps dramatically easier.

##Queue in our first framework... Express!
[Express](http://expressjs.com/) is a fast, unopinionated, minimalist web framework for Node.

###Setting up a project with Express
1. Create a new folder for use with the project using `mkdir helloServer`, and cd into `cd helloServer`

2. Initialize a `package.json` file by running `npm init`.

Follow the instructions, clicking `enter` through the statements. you many want to specify a version number, but most default options should 
be fine. It will also specify an initial file, usually index.js to use

2. Install the express package and add it to our `package.json` by running `npm install --save express`.

Simply running `npm install expess` would add express to our node_modules folder. Everything would work fine, but we wouldn't have a record of which packages that we need for our program to compile. That is if for some reason we deleted our node_modules folder, everything would be alright, because we would have had a record of what was installed in our `package.json`.

3. Touch an `index.js` file that we'll put our code in.

```bash
$ touch index.js
```

4. **Now this step is key:** Open the folder where `index.js` lives in vim by typing `vim .`.

Of course, I'm just kidding, don't actually open the folder in vim. Open the folder in what ever text editor your prefer. If you're unsure of how, give the command `subl .` a try in your terminal.

**Note:** If you fell victim to my prank and are stuck in vim you can exit by hitting the `ESC` key and then typing `:q` and then hitting `ENTER`.

###An intro to index.js
Let's start out with a simple 'Hello World' server that works like our example from earlier today.

**index.js**
```js
// At the top of our file we declare variables
// for all of the packages we're going to use
// in the file. For this example, we'll only need
// be using a single package called 'express'.
// We `require('express')` and save the results
// in an appropriately named variable.

var express = require('express');

// Next we declare a variable that instantiates
// the express server. Common names for this
// variable include `app` or `server`. We're
// going to call it `app` because thats what
// they do in the express documentation.

var app = express();

// Now that we have an app to build off of
// we should set up some routes.

// The pattern for setting up routes in express is as follows
// 
// app . HTTP-VERB ( '/ROUTE/PATH/DELIMITED/BY/SLASHES' , function(req,res) { // DO STUFF HERE // });


// Our first route will be `GET /` which will respond
// with "Hello World" for every request that
// comes in to your server.

app.get('/', function(req,res) {

  // Send back the response 'Hello World'

  res.send("Hello World");
});

// Tell the app to start listening for
// requests on port 3000.

app.listen(3000);
```

###A Couple Quick Exercises
**NOTE:** Each time you make changes to your `index.js` file you'll have to resert your server. Any changes made will not work until your server has been restarted.

**Exercise 2:** Add a new route `GET /hey` that sends back an html string that has an h1 tag that says 'Hey! Look at me!' and a p tag that says 'I made a server!'.

**Exercise 3:** Add a new route `GET /hi/YOURNAME` that sends back an html string that has an h1 tag that says 'Hi, I'm YOURNAME'. Do this for each member of your group.

**Excercise 4:** Reflecting on **Exercise 3**, how would we add routes for every one in this class? Continuing on that thought, how would we add routes for arbitrarily many people?

####Restarting the Server sucks
I'm sure that you've discovered that restarting your server each time you save a file sucks. Luckily there's a solution. Instead of doing `node index.js` we can do `nodemon index.js`. This will watch our file and resart the server each time we save.

####There has to be a better way to do routing
If we wanted to have a route for each person in the class, we would have to manually add each route. Maybe if we were a clever we could have a function do it for us, but there has to be a better way.

###Url Parameters
**Url Parameters** let us use a single Url to match an entire class of routes. For example, instead of

```js
...

app.get('/hi/michael', function(req,res) {
  res.send("Hi, I'm Michael");
});

app.get('/hi/brett', function(req,res) {
  res.send("Hi, I'm Brett");
});

...
```
we can

1. Get rid of all but one of the routes.
2. Change Url `/hi/michael` or `/hi/brett`, to `/hi/:name`.
3. Change `"Hi, I'm PERSON"` to `"Hi, I'm " + req.params.name`.

Doing so should give us something like this:

```js
...

// We use the `:name` Url parameter in
// place of a specific Url. We can name
// the parameter anything we'd like.

app.get('/hi/:name', function(req,res) {

  // All of the Url parameters that we use
  // in our route are accessible through
  // the `req.params` object. Since we called
  // our Url parameter, its value can be
  // accessed by using `req.params.name`.

  res.send("Hi, I'm " + req.params.name);
});

...
```

**Exercise 5:** Add a route `GET /add/:x/:y` that sends back the result of `x + y`. For example, a request to `GET /add/1/5` would send back 6.

**Note:** `req.params.x` and `req.params.y` are strings, we need to turn them into numbers. This can be done using the `Number` function.

###If we have time...

In addition to having routes where diffrent portions of the url are diffrent paramaters. We can use the generic string of the url in our route logic.

```js
app.get("/add/*", function(req, res) {
  var myParams = req.params[0].split("/")
  var result = myParams.reduce( function(total, num){ return total + parseInt(num) }, 0)
  res.send("The answer is  " + result);
})
```
This will give you a url like `http://localhost:3000/add/5/3/3/2/3` and give you an answer.


###Running your Project
If `"main": "index.js"` is in your `package.json`, then running `nodemon` will automatically start your project and serving your file.



ADD EJS NOTES HERE
