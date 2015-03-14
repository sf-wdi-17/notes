#JS Control flow
Use looping structures we learned in class to solve the problems.

##reverse.js
Write a program that will take a hardcoded string, and console log the reversed version of it. Use a `for` loop

`var inputString = "building"`

##filterLongWords.js
Hardcode an array of words. Have a variable maxLength, push words that are less than the maxLength into a new array, and console.log that.


##grade.js
Output the following letter grade from a variable with with a test score. Display either "A", "B", "C", "D", or "F", for an score that is an integer between 0 and 100. Try and use a `switch` statement.


##pluralizer.js
Take an input like

```
thing = "cat"
count = "5"
```
and output the pluralized form of the word like "5 cats" or "1 dog"..

##tempConvert.js
Convert a temperature from F to C.

Convert it to fahrenheit and output "NN°C is NN°F".

# Functions - Problem Set
These problems will use your knowledge of looping and conditionals, and we will build functions on top of that.


##sillySum(arr)
Write a function that takes an array of numbers, and returns the sum of each number multiplied by its index. 

`count += (number * index)`

##numSquare(max)
Create a function called `numSquare` that will return an array of all perfect square numbers up to, but not exceeding a max number.

##isPrime(num)
Create a function to return `true` or `false` if a number passed in a prime number.

##primes(max)
Using your `isPrime()` function, create a function `primes` that will return an array of all prime numbers up to a certain amount.

##letterCount(word)

Write a function that takes a string that finds out how many times a character occurs.  For example, the string "apple" would print the following:

```
a - 1
p - 2
l - 1
e - 1
```

__BONUS__: Make sure that lower case letters and upper case letters count for the same character.  Also, ignore spaces and punctuation.

##merge(arr1, arr2)

Write a function called ```merge```.  The function should take two sorted arrays of numbers as input and return a merged array of the sorted numbers from the input.  For example, if the input arrays were `var arr1 = [3,6,11]; var arr2 = [2,4,5,8,9];`  Then the returned array would be: `[2,3,4,5,6,8,9,11]`.


