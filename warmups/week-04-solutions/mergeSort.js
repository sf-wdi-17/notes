// mergeSort.js
// Brett Levenson | 4/7/15

// Completing mergeSort is easier if we just use the "merge" function we already built
var merge = function(left, right) {
    var merged = [];
    var l = 0, r = 0; // These are our left and right array index counters.

    while(l < left.length && r < right.length) {
        if(left[l] < right[r]) {
            merged.push(left[l++]);
        } else {
            merged.push(right[r++]);
        }
    }
    
    return merged.concat(left.slice(l)).concat(right.slice(r));
}

// Here's the actual mergeSort function that breaks 1 array down into smaller arrays. 
// Once an array has only 1 element, it is passed to merge() so everything can be built back up again.
var mergeSort = function(arr) {
    if(arr.length < 2) {
        // Arrays that have 0 or 1 items don't need to be sorted
        return arr;
    }
    // Now we find the middle of the array and split it into two pieces. 
    var middle  =   Math.floor(arr.length / 2);
    var left    =   arr.slice(0, middle);
    var right   =   arr.slice(middle);

    return merge(mergeSort(left), mergeSort(right));
}


var generateTestArray = function(intRangeMax, arraySize, intRangeMin) {
    // if user has set intRangeMin, use it, otherwise just default to 0 as the bottom.
    var rangeMin = Math.abs(intRangeMin || 0);
    
    // Make sure intRangeMax is greater than rangeMin.
    intRangeMax = intRangeMax < rangeMin ? rangeMin + 1 : intRangeMax;
    
    var result = []; // init the result array
    
    // Now do the work until result has arraySize elements
    while(result.length < arraySize) {
        // Make a new random element <= intRangeMax and drop any decimals
        var newEl = Math.random() * intRangeMax | 0;
        newEl = newEl < rangeMin ? rangeMin : newEl;
        
        result.push(newEl);
    }
    
    return result;
}


// Some specific test cases follow:
// ------------------------------------
// Integers between 1 and 100, length 10;
var test = [ 15, 9, 5, 45, 86, 33, 60, 14, 70, 65 ];
// Integers between 1 and 1000, length 20
var test2 = [ 20, 56, 969, 721, 832, 938, 212, 0, 181, 992, 183, 617, 304, 611, 524, 7, 431, 23, 291, 524 ];
// Integers between 1 and 50, length 30
var test3 = [ 30,   19,   6,   2,   14,   48,   18,   11,   22,   4,   39,   30,   9,   19,   25,   49,   29,   23,   2,   42,   30,   34,   8,   22,   3,   0,   47,   47,   48,   28 ];