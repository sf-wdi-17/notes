# Objects with attributes and methods

## Part 1
In the following example, list out which methods and attributes the object has:

```js
var cat = {
  name: "Sir Meows Alot",
  age: 2,
  meow: function() { console.log("Meow"); }
};

cat.purr = function(times) {
  for (var i = 0; i < times; i++) {
    console.log("Purr...");
  }
};
```

## Part 2
In the following example what does the keyword `this` refer to and what does the bark method do:

```js
var dog = {
  name: "Walter",
  age: 7,
  owner: "Brett"
};

dog.whimper = function() {
  console.log("I'm scared!\nWhere is " + this.owner);
};
```

## Part 3
What does the following code do. Explain your answer to your buddy.

```js
var ogd = {
  eman: "Retlaw",
  ega: 7,
  renwo: "Tterb"
};

var act = {
  eman: "Swoem Ris Tola",
  ega: 2
};

var foo = function() {
  console.log("Eman: " + this.eman);
  console.log("Ega: " + this.ega);
};

ogd.bar = foo;

act.zaz = foo;

act.zaz();
odg.bar();
```

## Part 4
Using objects, construct a model for a person that has attributes `firstName` and `lastName` with a method `greet` that takes a single parameter `name`, and prints out the string "Hi 'name', Im 'firstName' 'lastName'". For example: "Hi Brett, I'm Michael Desa".

## Part 5 (This one is hard)
Implement a Queue. The queue should have pop and push methods.
