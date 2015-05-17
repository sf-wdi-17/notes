#AJAX with jQuery

##Objectives
  - Understand what AJAX is
  - Refresher on how to install and use jQuery
  - Learn how to make API calls using jQuery and AJAX

##So what is AJAX?

[AJAX](http://en.wikipedia.org/wiki/AJAX) stands for _**A**synchronous **J**avascript **a**nd **X**ML_.

When we say that we're going to use __AJAX__, we're saying that we're going to use a combination of techniques and web technologies to access data for use in the front-end of a web application.

So let's look at the component parts:
  - So what is __asynchronous execution?__
  It's easier to understand what asynchronous execution is by also looking at how it differs from synchronous processing.
      + Synchronous execution means that when you execute a process or task, you first wait for that task to finish before moving on to the next process.
      + With asynchronous execution, we can move on to the next process before our first process is complete.
          * In Node.js, we used _callbacks_ to tell our code what steps to take once a process was complete. Most commonly, we saw this pattern when accessing other resources, like databases, files, or APIs.
  - The __Javascript__ part should be fairly self-explanatory.
  - So what's __XML__? XML is a plain-text format for the storage and transmission of data. It stands for eXtensible Markup Language and in fact, HTML is a subset of XML. 
    + Despite being part of the most commonly-used name for this technology, __XML__ is not required. More commonly, as we've seen, __JSON__ is used instead of XML. 
    + Most developers prefer using JSON for data transmission because its far more compact than XML (and because it very closely matches the way objects are formatted in Javascript.)
        * Technically, this variant is called __AJAJ__ _(asynchronous Javascript and JSON)_

##Setup

To start using jQuery, visit http://code.jquery.com and copy the link to the 1.11.x version (the most compatible version to date). We'll then include that link in our web page as shown below:

```html
<!doctype html>
<html>
<head>
    <title></title>
</head>
<body>

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
</body>
</html>
```

Note that we could also put the `<script>` tag in the head of our HTML. However, many devs choose to include jQuery at the end of the body because this allows the entire page to load before downloading and processing jQuery— which can improve load times.


##Using AJAX

In pure javascript, (without jQuery), we'd use something called the `XMLHttpRequest object` to make AJAX calls to APIs and other servers.

In jQuery, we use the following methods (and others) to make AJAX requests:
```js
$.ajax()
$.get()
$.post()
$.getJSON()
```

Each of these methods performs the same basic action (they each make a HTTP request), but each one has slightly different syntax and a slightly different purpose. As always, when coding, you'll probably want to [take a look at the documentation](http://api.jquery.com/category/ajax/) for AJAX using jQuery.

So, let's talk about each of these methods a bit more.

For examples below, we'll be using the [OMDb API](http://www.omdbapi.com).

### [$.ajax()](http://api.jquery.com/jQuery.ajax/) ###

This function underlies all AJAX requests in jQuery. And while you can certainly use it to make your requests, it's often unnecessary to call this function since there are several higher-level alternatives like `$.get()`, `$.post()`, and `$.getJSON()` which are easier to use. If, however, you need more precise control of your request, $.ajax() allows you to fine tune your requests in a very precise way.

In jQuery versions 1.5 and later, you can pass a single settings object to the `$.ajax()` method, with string/value pairs to configure the request. For a list of all the settings available, see the documentation on the [ajax settings object](http://api.jquery.com/jQuery.ajax/#jQuery-ajax-settings).

If you use this format of `$.ajax()`, the only required option is `url`
```js
$.ajax({
  url: url, // The URL of the request
});
```

But a more common example might look something like this:
```js
$.ajax({
  url: url, // The URL of the request
  // By explicitly setting the dataType, jQuery will automatically parse 
  // the JSON string into an object, and 'data' will then be that object
  dataType: "json",
  success: function (data, textStatus, jqXHR) {
    if (textStatus === "success") {
        // If the request was successful, then
        $("body").html(data.Key);
    }
  }
});
```

### [$.get()](http://api.jquery.com/jQuery.get/) ###

Because all of jQuery's AJAX methods are based on `$.ajax()`, this function is essentially a shorthand for the following:

```js
$.ajax({
  url: url, // The URL of the request
  success: success, // Callback function to tell jQuery what to do if the request is successful
  dataType: dataType, // The dataType to expect (i.e., "json", "xml", etc)
  type: "GET" // Sets the request type to GET (could also be 'POST', 'PUT', etc)
});
```

Here's an example of how we might use this function to search the OMDb API for all movies containing the word "Stargate":

```js
// Set the URL to use for the search
var url = "http://www.omdbapi.com/?s=Stargate";

// Make the request
$.get(url, function (data) {
    // In this case, 'data' contains the results of our search as a JSON string
    console.log(data);

    // In most cases, to actually use the search results, we'd want to say something like:
    var jsonData = JSON.parse(data);
    console.log(jsonData);
});
```

Note that while you can get away with only passing the `data` parameter to the callback function, it actually takes 3 arguments:
  - `data`: The data we're looking for with our request in whatever format the server uses (usually JSON)
  - `textStatus`: A string returned by jQuery to indicate whether the request was successful. When successful, this string will be 'success'.
  - `jqXHR`: This is the [_jQuery XMLHttpRequest object_](http://api.jquery.com/jQuery.ajax/#jqXHR) which is a superset of the standard XMLHttpRequest object. It includes information about the request itself, its state, and the resulting headers and body.
      + Note that `$.get()` and the other AJAX functions in jQuery also return the jqXHR object, so if you write `var res = $.get(...)` then `res` will be a reference to the jqXHR object.
      + You can try this in the Chrome REPL and then type `res` if you'd like to take a look at what's inside this object.

####Using Promises in Place of Callbacks
There's another way to setup your callbacks by chaining methods called [__promises__](http://api.jquery.com/category/deferred-object/) to your AJAX requests. The methods are part of jQuery's `Deferred` object.

```js
// Set the URL to use for the search
var url = "http://www.omdbapi.com/?s=Stargate";

// Make your request
$.get(url)
.done(function (data, textStatus, jqXHR) {
    // Tell jQuery what to do if the request succeeds
    console.log(data);
    alert("The request was a success");
})
.fail(function (data, textStatus, jqXHR) {
    // And what to do if the request fails
    alert("The request failed!");
});
```

There's a few other ways you can use promises to define your callbacks, and each will be executed under different conditions.

The `.always()` promise will be run whether the request was a success or a failure, but the values passed to `data`, `textStatus`, and `jqXHR` will change depending upon the result.

```js
$.get(url)
.always(function (data, textStatus, jqXHR) {
    // Note how we test the value of textStatus to determine 
    // whether the request was successful
    if (textStatus === "success") {
        console.log(data);
        alert("The request was a success")
    } else {
        alert("The request failed!");
    };
});
```

The `.then()` promise will also run regardless of success or failure, but it takes two functions as parameters. The first function defines what to do in case of success, and the second defines what to do in case of failure:

```js
$.get(url)
.then(function(data, textStatus, jqXHR) {
    // The first function is used if the request succeeds
    console.log(data);
    alert("The request was a success")
}, function(data, textStatus, jqXHR) {
    // This second function is used if the request fails
    alert("The request failed!");
});
```

### [$.getJSON()](http://api.jquery.com/jQuery.getJSON/) ###

The `$.getJSON()` function works just like the standard `$.get()` function except that the `dataType` parameter is automatically set to `"json"`.

That means that `$.getJSON()` is equivalent to:

```js
$.get(url, queryData, successCallback, "json")
```

...or to:

```js
$.ajax({
    url: url,
    data: queryData,
    success: successCallback,
    dataType: "json"
});
```

For example, if we wanted to display all the results of an OMDb API search for "Wedding" as an unordered list, this method might be a good choice, especially since it will automatically convert the JSON string sent back by the OMDb API into an object. 

```js
var url = "http://www.omdbapi.com/?s=Wedding";

$.getJSON(url, function(data) {
    var list = "<ul>";
    // Iterate through the data object returned
    data.Search.forEach( function(item) {
        // Add the title of result to the list
        list += "<li>" + item.Title + "</li>";
    })
    // Close the unordered list
    list += "</ul>";

    // Now we just add the newly created list to the results div
    $("#search_results").html(list);
});
```

### [$.post()](http://api.jquery.com/jQuery.post/) ###

The `$.post()` function works the same way as the `$.get()` function, except that it uses the HTTP method "POST" when making its request.

In effect, that means that `$.post()` is a shorthand for:
```js
$.ajax({
  type: "POST", 
  url: url, // The url being requested
  data: data, // The data being sent to the server using POST
  success: success, // The callback to run after the response is received
  dataType: dataType // The type of data expected from the server (json, xml, etc)
});
```

The basic format for `$.post()` is:
```js
$.post(url, dataToSubmit, successCallback, dataType)
```
Where:
  - `url`: The URL for our request
  - `dataToSubmit`: Any data to put in the body of our request
  - `successCallback`: A callback to execute upon success
  - `dataType`: The expected format of result data (json, xml, etc)

From our discussions of routing, you've seen how the HTTP method affects a route. For example, even though these two routes have the same URL...

```rb
GET '/users', to => "users#show"

POST '/users', to => "users#create"
```

...will call different methods in the user model (namely, 'show' or 'create')

But still, what's a common use case for `$.post()`? Consider form-submission.

The code below would grab everything entered into an HTML form with `id="userform"`, serialize it, and submit it to the route used as an example above. In this way, you could submit a form without having to reload a page.

```js
$.post( "/users", $( "#userform" ).serialize() );
```

Or, we could even submit data to the `POST '/users` route, and then receive JSON data back (perhaps the results of form validation):

```js
$.post( "/users", $( "#userform" ).serialize(), 
    function(data, textStatus, jqXHR) {
        alert("POST request successful!");

        // Set the data received from the request to an
        // element on the page with id="form_errors"
        $( "#form_errors" ).html( data );
    });
```

## Some Other Topics ##

### More About Promises

Suppose we want to create a function (or method) to help us query the OMDb API. We can do this using Promises.

```js
var movieQuery = function(query) {
    return $.ajax({
        url: "http://www.omdbapi.com/",
        data: {s: query}
    }).promise();
};

// Now we use any of the promise methods we talked about 
// earlier to set what happens when the results are in.
movieQuery("Titanic").done(function(result) {
    console.log("The results are:");
    console.log(JSON.parse(result));
});
```
One other thing that's worth noticing. We can use the data key to pass the query terms. They don't have to be appended directly to the URL. And since we know the response will be in a JSON format, we could have also written this as follows:

```js
var movieQuery = function(query) {
    return $.getJSON("http://www.omdbapi.com/", {s: query}).promise();
}

// And then we can still use our new function as follows:
movieQuery("Wedding Singer").then(function(results) {
    console.log("The results were:", results);
});
```

#### Using jqXHR Objects with Promises ####

One other cool thing about jqXHR objects returned by all of the jQuery AJAX methods is that new promises can be bound to them at any time. That means we could do the following:

```js
var $taco = $.getJSON("http://www.omdbapi.com/?s=Titanic", function(result) {
    // We can define this success callback in the initial call to $.getJSON()
    console.log("The query was successful:", result);
});

// And yet we can still apply a new promise later on that will run right away
// if the XHR request is complete, and wait to run if the XHR request is still
// in progress.
$taco.done(function(result) {
    console.log("The query results, again:", result);
});

```

Remember, the `$` prepended to the variable name `$taco` is just to help us remember that we are dealing with a jQuery object. It does not affect the nature of the variable in any way.

If you want to check out, and play around with a live example that uses something like the code above, [I've created a JSBin that searches OMDb and displays the results.](http://jsbin.com/jiroruyobe/8/edit?html,js,output)

And in case you're still curious about how to use jQuery to dynamically update pages, [here's a more complex example with error handling, full result details, and dynamic styling](http://jsbin.com/guxeye/5/).

### Same-Origin-Policy and JSONP

One of the most important security measures is what's called the Same-Origin Policy which only permits scripts running on pages originating from the same site – a combination of scheme, hostname, and port number[1] – to access each other's DOM with no specific restrictions, but prevents access to DOM on different sites. When you request JSON or other data from other sites using JavaScript, you may encounter this error which can be solved multiple ways, we will show you JSONP. JSONP allows you to make a request from one site for JSON data from another site.

More reading here: [Same-Origin Policy](http://en.wikipedia.org/wiki/Same-origin_policy)






