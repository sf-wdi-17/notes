// index.js
var express = require("express");
var app = express();


// GET localhost:3000/blah
app.get("/blah", function (req, res) {
  console.log(req);

  if (req.query.name) {
    res.send("Hello " + req.query.name)
  } else {
    // using the query params
    res.send("Hello World");
  }
});

// localhost:3000/hello/jane
app.get("/hello/:taco", function (req, res) {
  //req.params.taco => 'jane'
  res.send("Hello " + req.params.taco)
});


// listen for requests
app.listen(3000)











