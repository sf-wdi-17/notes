# Iterators
Lesson on JavaScript iterators.

## Objectives
Students will be able to...

- Understand the benefits of iterators over loops
- Apply iterators for the right use cases
- Write their own iterators

## Link
We know how to iterate over a JavaScript array:

```javascript
var array = [1, 2, 3]

for (var i = 0; i < array.length; i++) {
  console.log(array[i]);
}
```

We can use loops for very different use cases. For example, we might want to:

- perform a calculation on each element of the array (keyword `each`)
- perform a calculation on each element of the array and return a new array containing each result (keyword `map`)
- reduce all values of the array to a single value (keyword `reduce`)
- return only unique elements in an array (keyword `uniq`)
- ... and more

Using a for loop for all these different use cases is not very semantic, meaning we cannot easily tell by looking at the code which operation we are performing. They're also not very reusable. We can increase code readability and reusability drastically if we write different functions to handle the above cases for us.

## Educate and Engage
### Uniqueness
The solutions for the following exercises can be found in the file `solutions` in this directory, in the solutions branch of this repository.

Let's write a function called `uniq()` to get only the unique items from an array. Here's what it should look like:

```javascript
uniq([1,2,3,3,4,4,4])
// => [1,2,3,4]
```

### Each
Let's write a function that iterates over each array item and performs any operation for each one. This arbitrary operation can be passed in as a function:

```javascript
each([1,2,3], function(a) {
	console.log(a);
})
// 1
// 2
// 3
// => [1,2,3]
```

Note that the second argument that we pass in to the `each()` function is a function itself. This can be confusing at first, but don't worry, we'll get plenty of practice.

### Mapping
To perform an operation on each element of the array and return an array of the results, we can write a function `map()`.

For example, to square each element of an array:

```javascript
map([1,2,3], function(a) {
	return a * a;
});
// => [1,4,9];
```

Question: What's the difference between `each()` and `map()`?

### Reduce
To perform an operation on all elements of an array, we could conceive a function called `reduce` that stores each result of an operation and return the final result to us.

For example, to sum up all items in an array:

```javascript
reduce([1,2,3], function(total, num) {
  return total + num;
});
// => 6
```

Or, to multiply all items in array (ideal for a factorial):

```javascript
reduce([1,2,3,4], function(total, product) {
  return total * product;
});
// => 24
```

## Active Learning
Let's use the functions we built to complete the following tasks. Feel free to pair up with your buddy!

- Return all uniq items in `[1,2,3,5,6,4,3,2,1]`
- Loop over `[1,2,3,4]` and `console.log()` each item
- Print out each letter of a string
- Square each element in an array and return an array with the results
- Return an array of all letters in the string `'hey fellas!'`
- Multiply all numbers in the array `[4,5,2,41,3]`
- Multiply all squares of the numbers in the array `[1,2,3,4]`

## Reflect
Explain to your buddy:

- The advantages of using iterators over for loops
- The difference between `each()` and `map()`

## Tips
There are two iterators available in JavaScript called `forEach()` and `reduce()` that you can call directly on arrays:

```javascript
[1,2,3].forEach(function(a) {
	// do stuff here for each element a
});

[1,2,3].reduce(function(total, num) {
	// write, e.g., an expression for each element num
});
```

## Bonus
Write a function called `partition()` that returns an array of two items. The first contains the items for which the callback returns true, the second contains the items for which the callback returns false.

For example:

```javascript
partition([1,2,3,4], function(a) {
	return a % 2 === 0;
});
// => [[2,4], [1,3]]
```

In the above example, all even numbers are on the left, and all odd numbers on the right of the returned array.
