# Using HTTP API's

## Objectives
1. Students will be able to express what an HTTP API is.
2. Students will be able to use the `request` node module to make requests to an API.
3. Students will be able to render `json` data from an API.

### What is a HTTP API?
**[From Wikipedia](http://en.wikipedia.org/wiki/Web_API):**
A server-side web API is a programmatic interface to a defined request-response message system, typically expressed in JSON or XML, which is exposed via the web—most commonly by means of an HTTP-based web server. Mashups are web applications which combine the use of multiple such web APIs.[1] Webhooks are server-side web APIs that take as input a URI that is designed to be used like a remote named pipe or a type of callback such that the server acts as a client to dereference the provided URI and trigger an event on another server which handles this event thus providing a type of peer-to-peer IPC.

While "web API" in this context is sometimes considered a synonym for web service, Web 2.0 web applications have moved away from SOAP-based web services towards more cohesive collections of RESTful web resources.[2] These RESTful web APIs are accessible via standard HTTP methods by a variety of HTTP clients including browsers and mobile devices.

**...Wtf**
In short, an HTTP API, is a black box that we make requests to, and get responses from. Typically HTTP API's respond with JSON or XML. Nearly Every modern website uses an API, very often a website will consume its own API.

To turn Reddit into a JSON API, we simply add `.json` to the end of a reddit url like so [http://www.reddit.com/new.json](http://www.reddit.com/new.json)

### Intro the Request module
To get started clone this repo [HERE IS THE REPO](https://github.com/sf-wdi-17/inclass_api).

```bash
$ npm install --save request
```

Then go look at the documentation for `request` by clicking [here](https://www.npmjs.com/package/request)

It seems like the general structure of making requests with request is something like this:

```js
// We require the module
var request = require('request');

// We use the request module to make a request to
// google.com. We pass in a callback that takes in three
// parameters, error, response, and body.
request('http://www.google.com', function (error, response, body) {
    if (!error && response.statusCode == 200) {
      console.log(body) // Show the HTML for the Google homepage. 
    }
});
```

**Exercise 1:** Use the request module to make a request to your favorite website.
*Hint:* Note that you need to be in a node repl to do tihs (thats right an intentional typo!).

Here's an example:
```js
request('http://www.reddit.com/new.json', function(err, response, body) {
    if (!err && response.statusCode == 200) {
      console.log("THIS IS THE RESPONSE", response);
      console.log("\n\n\n\n\n\n\n\n\n\nTHIS IS THE BODY", body);
    }
});
```

#### And now for the API that we'll be using in the lab today
[OMDB](http://www.omdbapi.com/) is basically an IMDB clone that we can query. Unlike IMDB, OMDB will send back JSON. It makes it easy to use, I promise.

#### The two routes, we're going to need

**Number 1:** [http://www.omdbapi.com?s=SEARCH+TERM+PLUS+DELIMITED](http://www.omdbapi.com/?s=i+robot).
This important part from the link above is the `?s=SEARCH+TERM+PLUS+DELIMITED`. An example of a query we're going to make.[http://www.omdbapi.com?s=i+robot](http://www.omdbapi.com/?s=i+robot).

This makes a GET request where we're searching for a particular movie title.

**Number 2:** [http://www.omdbapi.com?i=IMDBID](http://www.omdbapi.com/?i=tt0427788).
This important part from the link above is the `?i=IMDBID`. An example of a query we're going to make.[http://www.omdbapi.com?i=tt1083849](http://www.omdbapi.com/?i=tt1083849).

This makes a GET request where we're searching for a particular movie with that IMDB ID.

**Exercise 2:** Lets use the request library to make requests to each of these URLs.

**Note:** Try doing something with the body of the request that you get back. Do you notice anything about it. *Hint* `JSON.parse`.

#### Now lets take a look at our app

```js
var express = require('express');
var request = require('request');
var app = express();

app.set('view engine', 'ejs');

// We have our root route that renders our index view
app.get('/', function(req,res) {
  res.render('index');
});

// We have our search route that renders our search view
app.get('/search', function(req,res) {
  res.render('search', {movies: []});
});

// We have our movie route that renders our movie view
app.get('/movie', function(req,res) {
  res.render('movie', {movie: {Title: "I'm a movie", Plot: "I'm a plot"}});
});

app.listen(3000);
```

Our index page only has a form that has METHOD `GET` and action `/search`.

```html
  <form method="GET" action="/search">
    <input type="text" name="q" placeholder="Search">
    <button>Click Me... I dare you.</button>
  </form>
```

This form is going to show up on the search page as well.

Our search page looks like this
```html
  <h1> Movies: </h1>
  <% movies.forEach(function(movie) { %>
    <div>
      <div>
        <h3>Title:</h3>
        <a href="/movie?id=<%= movie.imdbID %>">
          <%= movie.Title %>
        </a>
     </div>
     <div>
       <h3>Plot:</h3>
       <p>
        <%= movie.Plot %>
       </p>
     </div>
    </div>
  <% }); %>
```

Sice we use the `movies` variable in our view, any route that renders this view must then pass along a `{movies: SOME_ARRAY_GOES_HERE_}` to the render function.

**Group Exercise:** I'll be doing it along with you. Inside of our `app.get('/search', ...)` method, we're going to make a request to the OMDB API and then render the `search` page with the parsed results of the request.

**Exercise 3:** Use `request` to make a request to the OMDB API to grab a particular movie by it's IMDB ID.
