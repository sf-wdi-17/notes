#Part 1 - JS Control flow
Use looping structures we learned in class to solve the problems. Each problem should be in it's own file.

##Problem 1: filterLongWords.js
Hardcode an array of words. Have a variable maxLength, push words that are less than the maxLength into a new array, and console.log that.


##Problem 2: grade.js
Output the following letter grade from a variable with with a test score. Display either "A", "B", "C", "D", or "F", for an score that is an integer between 0 and 100. Try and use a `switch` statement.


##Problem 3: pluralizer.js
Take an input like

```
thing = "cat"
count = "5"
```
and output the pluralized form of the word like "5 cats" or "1 dog"..

##Problem 3: tempConvert.js
Convert a temperature from F to C.

Convert it to fahrenheit and output "NN°C is NN°F".

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
Create a function called `numSquare` that will return an array of all perfect square numbers up to, but not exceeding a max number.

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

##merge(arr1, arr2)

Write a function called ```merge```.  The function should take two sorted arrays of numbers as input and return a merged array of the sorted numbers from the input.  For example, if the input arrays were `var arr1 = [3,6,11]; var arr2 = [2,4,5,8,9];`  Then the returned array would be: `[2,3,4,5,6,8,9,11]`.

