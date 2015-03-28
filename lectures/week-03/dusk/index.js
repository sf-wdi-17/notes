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

// Tell the app to start listening for
// requests on port 3000.

app.listen(3000);
