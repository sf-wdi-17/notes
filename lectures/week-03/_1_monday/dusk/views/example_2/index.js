// index.js
// load express module
var express = require("express");
// create an app
var app = express();
var bodyParser = require("body-parser");

app.use(bodyParser.urlencoded());
app.set("view engine", "ejs");

var books = [{title: "the giver", author: "Lois Lowry"},
               {title: "alice in wonderand", author: "Lewis Carrol"},
               {title: "the time machine", author: "h.g. wells"}];

app.get("/books", function (req, res) {
  res.render("books/index.ejs", {bookList: books});
});

app.get("/books/new", function (req, res) {
  res.render("books/new.ejs");
});


app.post("/books", function (req, res) {
  console.log(req.body);

  books.push(req.body);
  res.redirect("/books");
});

// GET localhost:3000/greet
// sends "Helloo!!!!"
app.get("/greet", function (req, res){
  res.send("<b>Hello!!!!!</b>");
});

app.get("/greet/:name", function (req, res) {
  res.render("index.ejs", {});
});





app.listen(3000, function (){
  console.log("LISTENING!");
});