#Week 3 Warmups

##Problem 1: Simple Search
Write a function `simpleSearch` that takes a two parameters: `val` and `arr`, where arr = some array to search, and val = the value to search for. If the value is found in the array, your function should return the index of that value. If the value is not found, your function should return -1.

```js
var arr = [1, 5, 19, 8, 41];
simpleSearch(arr, 5) => 1
simpleSearch(arr, 8) => 3
simpleSearch(arr, 102) => -1
```

Here is some starter code:

```js
var simpleSearch = function(arr, val) {

};
```

###Solution: Simple Search

```js
var simpleSearch = function(arr, val) {
  // We simply iterate over the array checking the value of the element at index i against val each time.
  for(var i = 0; i < arr.length; i++) {
    if (arr[i] === val) return i; // If this statement evaluates to true, it means we've found the val in arr, so return the current index.
  }

  // If we're here, it means the value was never found in arr, so return -1.
  return -1;
};

```

##Problem 2: Implement a [Binary Search](http://en.wikipedia.org/wiki/Binary_search_algorithm) Function
Write a function `binarySearch` that takes in two parameters:
  1. arr (the array to search)
  2. val (the value to search for)

If the value is found in the array, the function returns true. Otherwise it returns false.

There are a few key requirements for binary searching. But in essence, a binary search takes advantage of the fact that a sorted set of data can be subdivided into smaller problems over and over again. Because of this, a binary search can be extremely fast, but it also requires that a set of data be sorted before the search begins.

Also, you'll probably want to implement your `binarySearch` function so that it uses recursion (you can do it without recursion, but it will be **much** more difficult.) 

As a reminder, a recursive algorithm calls itself to complete its task.

Recursive algorithms always have:
  1. A recursion condition
  2. A terminal condition (that is, a condition upon which recursion should end)

For example, to calculate a `factorial` we can use recursion:
```js
var factorial = function(n) {
    if (n > 0) {
        return n * factorial(n-1);
    } else {
        return 1;
    }
}
```

In the `factorial` function, the recursion condition states that as long as n is greater than 0, we continue to recurse and we reduce the value of n by 1 with each iteration. Once n == 0, we stop and return 1.

We can also illustrate recursion with the simple idea of spiraling down, and then back up again. We'll explain further.

Anyway, here's some starter code for your new `binarySearch` function

```js
var binarySearch = function(arr, val) {
    
}
```


##Problem 3: Merge two sorted arrays
Write a function `merge` that takes in two sorted arrays and merges them together such that the resulting array remains sorted.

Some starter code for ya:

```js
var merge = function(arr, arr2) {
    
    return merged; // Where 'merged' is a new array which is a sorted union of both arr, and arr2
}
```

###Solution: Merge two sorted arrays

```js
var merge = function(left, right){
    var merged  = [], // A new array where we'll merge the "left" and "right" arrays together.
        l       = 0, // The index counter we'll use to iterate over the "left" array (like "i" in a for loop)
        r       = 0; // The index counter we'll use to iterate over the "right" array (like "i" in a for loop)

    /* First step:
     * Starting at index 0 in both arrays, we want to compare the values
     * from each array one at a time, each time finding the value that is
     * smaller, and adding it to the 'merged' array.
     *
     * After each pass through the while loop, we'll increment either the
     * left array index ('l'), or the right array index ('r') — based
     * on which array had the smaller value.
     */
    while (l < left.length && r < right.length){
        if (left[l] < right[r]){ // If left is less than right, add the left element
            merged.push(left[l++]);
        } else { // Else add the right element
            merged.push(right[r++]);
        }
    }

    /* We will have always finish going through the elements 
     * of one array before we finish going through the elements 
     * of the other array, even if they are the same length 
     * (and of course if they are different lengths!)
     *
     * So, after we've exited from the while loop above, we need
     * to figure out whether the right or left array still has
     * elements that need to be checked, and once we know which array
     * to finish adding from, do the work of adding those elements
     * to the 'merged' array.
    */

    while(l < left.length) { // This loop checks the left array first
      // Elements remain, so push element into merged array
      // at index 'l' and then increment 'l' 
      // (so we move to the next index on the next loop.)
      merged.push(left[l++]);
    }

    while(r < right.length) { // Then we check the right array
      // Elements remain, so push element into merged array
      // at index 'r' and then increment 'r' 
      // (so we move to the next index on the next loop.)
      merged.push(right[r++]);
    }

    return merged; // We're done! Return the newly merged array.

}
```

A few notes about this solution:
  1. You'll notice that I've used a new syntax with the structure `arr[i++]` a few times here. This syntax is a special shorthand that is only available when using the `++` shorthand for _increment by 1_. There are two versions, and they have different meanings:
    a. When you write `arr[i++]`, (with the `++` after the `i` variable), it means: Evaluate the expression `arr[i]` (that is, get the value of the array `arr` at index `i`), and __THEN__ _increment the value of variable `i` by 1_.
    b. In contrast, when you write `arr[++i]` (with the `++` part before the variable `i`), you're saying something a little different: Increment the value of the variable `i` by 1, and __ONLY AFTER__ after you increase the value of `i` should you evaluate the expression `arr[i]` and get its value.

Essentially, where you put the `++` changes when the variable is incremented and thus what index you are getting from the array.

  2. There are still some things left to do that I haven't done here. We talked about __edge cases__ and how they can affect whether your function works with all possible valid inputs or not. Which edge cases haven't we accounted for in the above function?


**Final note:** If you're curious about another, more refactored way of doing merge() that's a bit more efficient for highly imbalanced cases (meaning one array is far longer than the other or one array has much lower numbers than the other), check out the additional solution I posted at in the [week-03-solutions folder](week-03-solutions/merge.js). It may help you in the future to try to understand that version and it's sometimes fun to see how refactoring can significantly reduce the length of your code as well.


##Problem 4: TicTacToe Refactoring, OOP and TDD (What did Mike do?) -- BONUS!!

Mike has implemented an elegant and complex solution to TicTacToe this weekend. Take a look at it, and try to explain it to the rest of the class.

