#Functions
## Objectives

| Objective |
| :--- |
| Students should be able to create simple Javascript functions with parameters|
| Students should be able to explain what returning a value means and how it differs with printing a value|
| Students should know what it means for a function to have scoped variables |



##Defining a function
```js
var greeting = function() {
console.log("Hello World");
};

greeting();
```

##Defining a function with a parameter
```js
var greeting = function (taco) {
  // anything inside of here will execute when called
  console.log("Good morning", taco);
};

var name = "Delmer";
var name2 = "Brett";
greeting(name);
greeting(name2);
```


##Why use functions?

###A program that greets people

####Let's greet some instructors

```js
var instructor = "Brett";
console.log("Hello", instructor); // Hello Brett

instructor = "Delmer";
console.log("Hello", instructor); // Hello Delmer
```

####Let's greet some students
```js
var student = "Alexandra";
console.log("Hello", student);  // Hello Alexandra

student = "Emmanuel";
console.log("Hello", student); // Hello Emmanuel
```

###So what does this have to do with functions?

The questions we should be asking are: 
  1. Did we repeat ourselves in our code?
  2. Can we make our program simpler?
  3. Can we make our program easier to maintain?

```js
var greeter = function(person) {
  // We can avoid re-writing the same code by placing the repeated code inside of a function
  console.log("Hello", person); 
};

// Now let's greet some instructors...
greeter("Brett");
greeter("Delmer");

// ... and some students.
greeter("Alexandra");
greeter("Emmanuel");

```

###Functions make our code easier to maintain

```js
var greeter = function(person) {
  // With just 1 change, we can adjust our program output
  console.log("Bonjour", person); 
};

// Now let's greet some instructors...
greeter("Brett");
greeter("Delmer");

// ... and some students.
greeter("Alexandra");
greeter("Emmanuel");

```


##Defining a function with two parameters
```js
var greeting = function (taco, stuff) {
  // anything inside of here will execute when called
  console.log("Good morning", stuff, taco);
  console.log("taco:", taco);
  console.log("stuff:", stuff);
};

var name = "Delmer";
var name2 = "Brett";
greeting(name, name2);
greeting(name2, name);
```

##Printing and returning are diffrent
```js
var multiply = function(num1, num2) {
  console.log("inside the function");
  // return result = num1 * num2;
  return num1 * num2
};

var firstNum = 2;
var secNum = 3;
var taco = multiply(firstNum,secNum);

console.log(firstNum + " multiplied by " + secNum + " is " + taco );
```
```js
// With a return value
var returnHello = function (name) {
  return("Hello, " + name);
};

console.log("with a return value:", returnHello("tim") );

// Without a return value
var returnHello2 = function(name) {
  console.log("inside returnHello2: Hello, " + name);
};
returnHello2("nachos");
console.log("without a return value:", returnHello2("taco") ); //will show as undefined
```

##A function with scoped variables
```js
var scoped = function(name) {
	var greeting = "Hello " + name + "!";
	return greeting;
};

var hello = scoped("Michael");
console.log(hello);
```

###Why is variable scope important?
Let's add to the example above to add to our discussion of variable scope.
```js

var greeting = "Hello WDI 15!";

var scoped = function(name) {
  var greeting = "Hello " + name + "!";
  return greeting;
};

var result = scoped("Brett");

console.log(result); // Outputs: Hello Brett!
console.log(greeting); // What will the output of this line be?
```

####What will the output of the code above be?
1. "Hello Brett! Hello Brett!" or
2. "Hello Brett! Hello WDI 15!"


###Local vs. Global Scope and the 'var' keyword
```js

var greeting = "Hello WDI 15!";

var scoped = function(name) {
  greeting = "Hello " + name + "!";
  return greeting;
};

var result = scoped("Brett");

console.log(result); // Outputs: Hello Brett!
console.log(greeting); // What will the output of this line be?
```

####What will the output be now? The same or different?
1. "Hello Brett! Hello Brett!" or
2. "Hello Brett! Hello WDI 15!"


###Exercise
Write a function that reverses a string.

Write a function to solve [FizzBuzz](http://en.wikipedia.org/wiki/Fizz_buzz)

Rewrite all the exercises from the previous days homework as functions instead of files.
