# Solutions for Lesson on Iterators

## Function Implementations

- Implementation of `uniq()`:

```javascript
var uniq = function(array) {
	var uniqueArray = [];

	for (var i = 0; i < array.length; i++) {
		if (uniqueArray.indexOf(array[i]) === -1) {
			uniqueArray.push(array[i]);
		}
	}

	return uniqueArray;
}
```

- Implementation of `each()`:

```javascript
var each = function(array, callback) {
	for (var i = 0; i < array.length; i++) {
		callback(array[i]);
	}

	return array;
}
```

- Implementation of `map()`:

```javascript
var map = function(array, callback) {
	var results = [];

	for (var i = 0; i < array.length; i++) {
		results.push(callback[i]);
	}

	return results;
}
```

- Implementation of `reduce()`:

```javascript
var reduce = function(array, callback) {
	var result = array[0];

	for (var i = 1; i < array.length; i++) {
		result = callback(result, array[i]);
	}

	return result;
}
```

## Active Learning Solutions
- Return all uniq items in `[1,2,3,5,6,4,3,2,1]`:

```javascript
uniq([1,2,3,5,6,4,3,2,1])
```

- Loop over `[1,2,3,4]` and `console.log()` each item:

```javascript
each([1,2,3,4], function(a) {
	console.log(a);
});
```

- Print out each letter of a string:

```javascript
each('hello', function(a) {
	console.log(a);
});
```

- Square each element in an array and return an array with the results:

```javascript
map([1,2,3], function(a) {
	return a * a;
});
```

- Return an array of all letters in the string `'hey fellas!'`:

```javascript
map('hey fellas!', function(a) {
	return a;
});
```

- Multiply all numbers in the array `[4,5,2,41,3]`:

```javascript
reduce([4,5,2,41,3], function(total, num) {
	return total *= num;
});
```

- Multiply all squares of the numbers in the array `[1,2,3,4]`:

```javascript
reduce([1,2,3,4], function(total, num) {
	return total *= (num * num);
});
```

## Bonus
```javascript
partition = function(array, callback) {
	var goodResults = [];
	var badResults = [];

	for (var i = 0; i < array.length; i++) {
		if (callback(array[i])) {
			goodResults.push(array[i]);
		} else {
			badResults.push(array[i]);
		}
	}

	return [goodResults, badResults];
}
```
