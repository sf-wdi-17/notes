// Just to be fancy lets use that chalk library we played with a few days ago
// Dont forget to do npm install chalk
var chalk = require('chalk');

var assert = function(actual, expected, message) {
  if (actual === expected) {
    console.log(chalk.green("Passed: Expected %s got %s"), expected, actual);
  } else {
    console.log(chalk.red("Failed: Expected %s got %s"), expected, actual);
  }
};


var addTen = function(n) {
  return n + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1;
};

assert(addTen(4), 14, "addTen adds 10 to 4");
assert(addTen(0), 10, "addTen adds 10 to 0");

var addTen2 = function(n) {
  return n + 10;
};

assert(addTen2(4), 14, "addTen adds 10 to 4");
assert(addTen2(0), 10, "addTen adds 10 to 0");

var factorial = function(n) {
  if (n <= 0) {
    throw new Error("Not defined for n less-than or equal to 0");
  } else if (n < 2) {
    return 1;
  } else {
    return n * factorial(n-1);
  }
};

//this stuff doesing work
//factorial(-3);
//console.log("Hey I'm here");

//This one does
try {
  factorial(-3);
} catch (e) {
  console.log(e);
} finally {
  console.log("Your code finished running");
}

console.log("Hey I'm here");
