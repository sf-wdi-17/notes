#*Note:* This Lab is Hard. We do not expect you to finish the entire thing.

#Part 1 - JS Control flow
Use looping structures we learned in class to solve the problems. Each problem should be in its own file.

##Problem 1: filterLongWords.js
Hardcode an array of words. Have a variable maxLength, push words that are less than the maxLength into a new array, and console.log that.

##Problem 2: grade.js
Output the following letter grade from a variable with a test score. Display either "A", "B", "C", "D", or "F", for an score that is an integer between 0 and 100. Try and use a `switch` statement.

##Problem 3: pluralizer.js
Take an input like

```
thing = "cat"
count = "5"
```
and output the pluralized form of the word like "5 cats" or "1 dog"..

##Problem 4: tempConvert.js
Convert a temperature from F to C.

Convert it from fahrenheit to celsius and output "NN°F is NN°C".

#Part 2: Functions
These problems will use your knowledge of looping and conditionals, and we will build functions on top of that. All of these functions should be in their own file.

##Problem 1: sillySum(arr)
Write a function that takes an array of numbers, and returns the sum of each number multiplied by its index. 

`count += (number * index)`

```js
var sillySum = function(arr) {
  \\ Code goes here
};
```

##Problem 2: numSquare(max)
Create a function called `numSquare` that will return an array of all perfect square numbers up to, but not exceeding, a max number.

```js
var numSquare = function(max) {
  \\ Code goes here
};
```

##Problem 3: isPrime(num)
Create a function to return `true` or `false` if a number passed in a prime number.

```js
var isPrime = function(num) {
  \\ Code goes here
};
```

##Problem 4: primes(max)
Using your `isPrime()` function, create a function `primes` that will return an array of all prime numbers up to a certain amount.

```js
var primes = function(max) {
  \\ Code goes here
};
```

##Problem 5: letterCount(word)

Write a function that takes a string that finds out how many times a character occurs.  For example, the string "apple" would print the following:

```
a - 1
p - 2
l - 1
e - 1
```

```js
var letterCount = function(word) {
  \\ Code goes here
};
```

__BONUS__: Make sure that lower case letters and upper case letters count for the same character.  Also, ignore spaces and punctuation.
