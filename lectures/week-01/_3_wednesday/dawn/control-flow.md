# JS Control Flow
## Conditionals and Loops


#Objectives
* Demonstrate proper use of conditionals.
* Apply principles of operators in conditional statements.
* Illustrate proper use of the `FOR` and `WHILE` loops.
* Identify improper loops that can result in infinite looping.


### Logical Operators

There are two types of binary operators that work with booleans, (a binary operator just requires two arguments.)

* **AND**, denoted `&&` 
* **OR**, denoted `||`


There is a third unary operatory, (a unary operator is one that requires just one argument).

* **NOT**, denoted `!`

[MDN Logical Operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)

Quick Notes:

* The `&&` operator requires both left and right values to be `true` to return `true`, i.e.
  
  ````
    true && true //=> true
  ````
and any other combination is false.

* The `||` operator requires just one of the left or right values to be `true` to return true.
  * Only `false || false` will return `false`
  
* The `!` takes a value and returns the opposite boolean value, i.e. ` !(true) //=> false`.
  

### Comparisons

To compare two values in Javascript for equality testing we use `===`, which will check the sameness of the thing on the left with the thing on the right. Note sameness is a very fuzzy word, and thus, `===` is also very fuzzy concept, which should be approached with caution in every language. 

Here are some cases when equality testing seems reasonable

```javascript
  
  true === true 
  //=> true
  false === true
  //=> false
  
  1 === 1
  //=> true
  1 === 2
  //=> false
  
  "hello" === "hello"
  //=> false
  
```


But here are some cases when it does not. 


```javascript
  
  {} === {}
  //=> false
  [] === []
  //=> false
  
  
```


**Explanation**

The second set of examples fail because both **object literals** and **arrays** are objects, and not just values like strings, numbers, and booleans. Objects can be complex collections of values in memory that we  are referring to in a program, and so, we only reference each object by an id to simply things. However, that means when we go to compare the two objects we don't care if they look like similar collections. We only compare their respective ids when checking for equality, and each `{}` or `[]` represents a new object with it's own unique id.

Arrays and objects are called **reference** types for the above reasons, so be careful with using them too intuitively.


#### Truthy

In a language some values can be taken to be `true` or `false`, and we can check this using the `!` operator

```javascript

  !!(1)
  //=> true
  
  !!(0)
  //=> false
  
  !!(-1)
  //=> true
  
  !!([])
  //=> true
  
  !!({})
  //=> true
  
  !!(null)
  //=> false
  
  !!('')
  //=> false
```


### Conditionals

Conditionals are a way of essentially skipping over a block of code if it does not pass boolean expression.


* `if(expr) { code }`, run code block if `expr` is `true`

```javascript

var num = 22;

if (num % 2  === 0) {
  console.log("is even");
}

```

* `if (expr) { ... } else { ... }`
  *  you can specifiy the `else` block to run if `expr` is `false`
* `if (expr1) { ... } else if (expr2) { ... } ... else { ... }`
  *  if `expr1` is false then each `else if` expression will be evaluated until one is `true`, and an `else` will be run otherwise.
  


```

var expr1 = true;
var expr2 = true;


if (expr1) {
  console.log("expr1 is true!");
} else if (expr2){
  console.log("expr2 is true!");
}

```


The above example will print `"expr1 is true"` and the `else if` is never reached. If `expr1` is `false` it would only print `"expr2 is true"`


### Exercises

1.The Marathon Runner

- Create a prompt that asks the user what their best marathon time was.
- If their time was between 4 to 5 hours, alert the user that their time was average.
- if the time was between 2 to 4 hours, alert the user that their time was excellent.
- If the time was greater than 5 hours, alert the user that they need to speed up!

2. Use conditionals to check if a hardcoded number is `odd` or `even`, and then `console.log` the number is `odd` or `even` with the numbers value.

  ```
  var num = ;// write a number here
  
  // write your conditions here
  
  ```
3. Fiz-Buzz
 For each number from `1` to `100`  print the following: `fizz` if it is a multiple of `3`, `buzz` if it is a multiple of `5`, and `fizzbuzz` it is a multiple of both.


#### Ternary Operators

Another way to write a very shorthand conditional is using a **ternary operator**, `expr1 ? expr2 : expr3 `. 

```
true ? console.log("it is true"): console.log("it is false");
//=>  "it is false"
false ? console.log("it is true"): console.log("it is false");
//=> "it is false"
```

### Iterating

It is a way of incrementally repeating a task. Iterating is a way of describing procedures like 

```
print "hello world" 50 times
``` 
It is also a way of describing 

```
print each item in a shopping list
```

It can also be a way of solving problems like

```
how would I print all vegetables in a shoppping list
```


Typically iteration has three or four main parts 

* an initial state
* a condition for repeating
* process to be run for each repetition 
* a state change for proceeding to the next step

It isn't surprising that the primary means of iterating in most languages is called a `for` loop, which has the following structure

```

for ( intial state; check condition; change state) {
  run this code for before changing state
}

```


or a  more concrete example


```

var friends = ["larry", "moe", "curly"];

for (var index = 0; index < friends.length; index = index + 1) {
  console.log(friends[index]))
}

```

##Exercise
- Write a for loop that will iterate from 0 to 20. 
- For each iteration, it will check if the current number is even or odd, and report that to the screen (e.g. "2 is even").

## While loop
  ```  
  var a = [1,2,3,4];
  var b = [1,2,3,4];

  console.log("While Loop:")
  
  var i = 0;
  
  while(i < a.length) {
    console.log("The element at index " + i + " is: " + a[i]);
    i++; 
  }
  ```
##Infinite Loops

- While writing a loop it is possible to create a loop that will go until infinity.
- Obviously we try to avoid this while coding.

```
for (var i = 0; i > 0; i++) {
  console.log(i);
}
```


#### Exercises


1. Iterate through a shopping list and print each item in a shopping list.

  ```
    var shoppingList = ["apples", "oranges", "carrots"];
    
    // iterate here
  ```

2. Iterate through a list of shopping lists and print each item in each list.

  ```
    var shoppingLists = [
                ["apples", "oranges", "carrots"],
                ["ham", "turkey", "cheese"],
                ["fruits", "vegetables", "meat"]
              ];
    // iterate here
  ```


3. You have a list of numbers below that somehow got shuffled and one is missing. Luckily you know that the numbers were from `1 to 100`. Find the missing number. 

  ```
  var numbers = [56, 74, 31, 89, 8, 
          22, 5, 19, 28, 100,
          82, 72, 39, 25, 90, 
          1, 97, 83, 58, 38, 
          57, 71, 70, 7, 3, 
          12, 48, 45, 43, 84, 
          68, 49, 37, 41, 92, 
          96, 6, 66, 95, 15, 
          67, 2, 59, 4, 91, 
          44, 50, 17, 30, 88, 
          34, 55, 64, 9, 27, 
          73, 60, 32, 81, 10, 
          53, 61, 63, 51, 65, 
          36, 26, 99, 76, 47, 
          21, 14, 16, 40, 79, 
          75, 85, 42, 86, 18, 
          23, 24, 46, 69, 29, 
          77, 20, 54, 80, 87, 
          13, 94, 98, 93, 62, 
          35, 33, 11, 52];
  
  ```
  
## Basic JavaScript Calculator Lab

- Create a calculator in JavaScript.
- Prompt the user to enter an operator and two operands.
- Support the following operations: addition, subtraction, multiplication, and division. Output may appear in the console or in an alert.
