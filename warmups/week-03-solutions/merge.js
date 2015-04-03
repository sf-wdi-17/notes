/* Week-03/Problem 3: Merge Two Arrays - Additional Solution
 * Refactored solution to merging two sorted arrays that makes use
 * of the fact that arrays are stored as consecutive spaces in memory.
 * By using the "slice" method to grab any remaining elements in the "longer"
 * array, we avoid having to actually iterate over each and every element that's left
 * and thus can grab all the remaining elements in one big chunk (see line 20).
 */

var merge = function(left, right){
    var merged  = [],
        l      = 0,
        r      = 0;

    while (l < left.length && r < right.length){
        if (left[l] < right[r]){
            merged.push(left[l++]);
        } else {
            merged.push(right[r++]);
        }
    }

    /* Note that this also accomplishes in one line what would normally be done
     * in two separate statements thanks to the double-use of concat.
     * First we concatenate the ends of the left and right arrays 
     * (although in fact, only one array will ever have any elements left)
     * and then we concatenate the result of that operation with the "merged" array
     * that we built earlier.
     */ 
    return merged.concat(left.slice(l)).concat(right.slice(r));
}


// Test cases to try out.
merge([3, 8, 22], [1, 5, 7]); // returns [1, 3, 5, 7, 8, 22];
merge([6, 7, 50, 55], [2, 12, 35, 71]); // returns [2, 6, 7, 12, 35, 50, 55, 71]
merge([], [9, 15, 27]); // Should return [9, 15, 27] (Edge case!)
merge("Hello", 156); // Should return an error. Will it?