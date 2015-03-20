////////////////// Part 1 //////////////////////////////

//Problem 1

// Define a function called filterLongWords that takes in
// two parameters: an array or words, and maximum word length
var filterLongWords = function(arr,maxLength) {
  // Initialize an empty array that we'll add short words to
  var shortWords = [];

  // Iterate through the array of words
  for (var i = 0; i < arr.length; i++) {
    // Check to see if the word is too long
    if (arr[i].length < maxLength) {
      // If it is add it to the short words array
      shortWords.push(arr[i]);
    }
  }

  // Return the shortWords array that we just built up
  return shortWords;
};


//Problem 2

var grade = function(score) {

  switch (true) {
    case (score >= 90):
      return "A";
    case (score >= 80):
      return "B";
    case (score >= 70):
      return "C";
    case (score >= 60):
      return "D";
    default:
      return "F";
  }

};


//Problem 3

var pluralize = function(thing, amount) {

  if (amount === 1) {
    return "There is " + amount + " " + thing + ".";
  } else {
    return "There are " + amount + " " + thing + "s.";
  }

};

//Problem 4

var tempConvert = function(temp) {
  //Deduct 32, then multiply by 5, then divide by 9
  var degreesCelsius = ((temp - 32) * 5) / 9;
  return temp + " Fahrenheit is " + degreesCelsius + " Celsius.";
};


/////////////////// Part 2 ///////////////////////////////

//Problem 1

var sillySum = function(arr) {
  var sum = 0;

  for (var i = 0; i < arr.length; i++) {
    sum += arr[i] * i;
  }

  return sum;
};

//Problem 2

var numSquare = function(max) {
  var squares = [];

  for (var i = 0; i * i < max; i++) {
    squares.push(i * i);
  }

  return squares;
};

//Problem 3

var isPrime = function(number) {

  for (var i = 2; i < n; i++) {
    if (number % i === 0) {
      return false;
    }
  }

  return true;
};

//Problem 4

var primes = function(max) {
  var primeList = [];

  for (var i = 2; i < max; i++) {
    if (isPrime(i)) {
      primeList.push(i);
    }
  }

  return primeList;
};

var letterCount = function(word) {
  var letterObj = {};

  for (var i = 0; i < word.length; i++) {
    var letter = word[i];
    if (letterObj[letter]) {
      letterObj[letter] += 1;
    } else {
      letterObj[letter] = 1;
    }
  }

  return letterObj;
};
