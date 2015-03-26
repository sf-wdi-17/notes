# Test Driven Development (TDD)
Lecture on test driven development. And a Hoddge Podge of other small topics.

# Objective
Students will be able to...

- Understand the core concepts behind test driven development
- Write their own tests in JavaScript using asserts
- Use try-catch statements to deal with errors appropriately

#Think Pair Share
1. How do we know if our code does what its supposed to?
2. What does it mean for our code to be up to 'spec'?
3. How do we know when we're done with the job we've been tasked with?
4. How can we be sure that none of the code we have written breaks any other part of our code base?

# Link
TDD may seems counter-intuitive at first, but is actually something you do automatically when you develop a new feature. When writing software, you have to make sure you fulfill the requirements and don't break existing code. TDD is there to ensure just that.

> If it's worth building, it's worth testing. If it's not worth testing, why are you wasting your time working on it?

# Educate and Engage
## Software development environments
Software development happens in three different environments:

- Development
- Test
- Production

Development is the environment in which feature code is written.
Test is the environment in which feature code is tested.
Production is the environment in which live features are presented to the public (e.g., a website on a server).

## Order Of These Environments
An intuitive guess would be that the order development, test, and production is already correct. After all, a feature has to be developed before it can be tested, and then deployed into production.

While this *can* certainly be done in that order, it is by no means the best order. A better order is:

1. Test
2. Development
3. Production

This order is called Test Driven Development. *It can be hard to keep up, but it is what distinguishes a mediocre programmer from an excellent programmer.*

## The Heart of TDD
From [Wikipedia](http://en.wikipedia.org/wiki/Test-driven_development):

> Test-driven development (TDD) is a software development process that relies on the repetition of a very short development cycle: first the developer writes an (initially failing) automated test case that defines a desired improvement or new function, then produces the minimum amount of code to pass that test, and finally refactors the new code to acceptable standards.

This can be narrowed down into the following steps (mostly taken from [Wikipedia](http://en.wikipedia.org/wiki/Test-driven_development)):

**Add an initially failing test**

In test-driven development, each new feature begins with writing a test. This is a differentiating feature of test-driven development versus writing unit tests *after* the code is written: it makes the developer focus on the requirements before writing the code, a subtle but important difference.

**Run all tests and see if the new one fails**

This validates that the test harness is working correctly, that the new test does not mistakenly pass without requiring any new code, and that the required feature does not already exist. This step also tests the test itself, in the negative: it rules out the possibility that the new test always passes, and therefore is worthless. The new test should also fail for the expected reason. This step increases the developer's confidence that he/she is testing the right thing, and passes only in intended cases.

**Write some code**

Write just enough feature code to make the test pass. At this stage, the code does not have to be elegant or clean at all, since it will be refactored later on in this process.

**Run tests**

If all test cases now pass, the programmer can be confident that the new code meets the test requirements, and does not break or degrade any existing features. If they do not, the new code must be adjusted until they do.

**Refactor code**

Feature code has to be maintained and refactored regularly. Since the feature code is now backed by tests, the programmer can be confident to refactor without breaking features. After refactoring, the tests should be run to ensure full functionality. Refactoring code does not change a feature; it merely improves the syntax and writing of certain lines of code without changing it's result.

**(Repeat)**

Repeat for every feature. Eventually, the programmer will have a solid, test-backed feature base. Automated tests allow him/her to test that all features run as expected in a matter of seconds, at least minutes (depending on the product's size).

This whole process can be visualized like this:

![TDD cycle](http://1minus1.com/userstorage/images/dev_graphs_testdrivendev.jpg)

# Reflect
Reflect on the advantages and disadvantages of test driven development. Raise any questions/concerns you may have.

#And Now for Some Asserts

## What is an assert?
An assert is a function that takes three parameters: actual, expected, and message. Actual is the actual value of the thing we're testing, expected is the value that we expect from the actual value, and a message related to what it is we were testing.

```js
// Just to be fancy lets use that chalk library we played with a few days ago
var chalk = require('chalk');

var assert = function(actual, expected, message) {
  if (actual === expected) {
    console.log(chalk.green("Passed: Expected %s got %s"), expected, actual);
  } else {
    console.log(chalk.red("Failed: Expected %s got %s"), expected, actual);
  }
}
```

Now lets play around with it a little bit:

```js
var addTen = function(n) {
  return n + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1;
};

assert(addTen(4), 14, "addTen adds 10 to 4");
assert(addTen(0), 10, "addTen adds 10 to 0");
```

now if we run this file, we see that our tests fail. Now lets refactor this code to make it better so that our tests pass.


```js
var addTen = function(n) {
  return n + 10;
};

assert(addTen(4), 14, "addTen adds 10 to 4");
assert(addTen(0), 10, "addTen adds 10 to 0");
```

# And now for try catch

A few days ago we saw this `throw` keyword in Dennis' solution for factorial. Here's what he had if you dont remember.

```js
var factorial = function(n) {
  if (n <= 0) {
    throw new Error("Not defined for n less-than or equal to 0");
  } else if (n < 2) {
    return 1;
  } else {
    return n * factorial(n-1);
  }
};

// now if we run the input on a negative number we get an error
factorial(-3);
console.log("Hey I'm here");
```

now if we try to run this code, we see that our `console.log("Hey I'm here");` never gets ran and our program exits.

Is this functionality that we want?

I hope that we can all agree that no we definitely dont want our program to stop running just because we get an error. So how to we fix this?

## Queue in try-catch
Most if not all programming languages have ways to handle errors, very typically using this idea of a try-catch expression, which allows us to try running some piece of code, and if it throws an error, we can catch it and do something else.

Building off of the example that we had before lets give it a try

```js
var factorial = function(n) {
  if (n <= 0) {
    throw new Error("Not defined for n less-than or equal to 0");
  } else if (n < 2) {
    return 1;
  } else {
    return n * factorial(n-1);
  }
};

try {
  factorial(-3);
  throw new Error("Shit broke");
} catch (e) {
  console.log(e);
} finally {
  console.log("Your code finished running");
}

console.log("Hey I'm here");
```

Now if we run our file, we see that our program works and all errors are caught and dealt with appropriately.
