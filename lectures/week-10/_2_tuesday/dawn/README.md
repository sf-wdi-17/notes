# Intro To Angular - Controller and Events

## Objectives

* Handle a simple form with an angular controller
* Display repeated data from the controller using a controller method
* Implement more complex controller logic

## Simple Form Submission in Angular

Angular controllers help us separate concerns.  We are going to build a hangman app using angular.  Let's start with the following code in [jsbin](http://jsbin.com/).

`index.html`

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
      </div>
    </body>
    </html>
    
    
`hangman.js`

```
var HangManCtrl = function($scope) {
   $scope.currentWord = "angular";
};
```

Notice that the html has `ng-app` and `ng-controller`.  The `ng-controller` directive binds the div tag to the scope of the controller.  Now angular let's the view have access to the data and methods inside of the controller.  For example, to show the current word, the html would look like this:


    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
         {{currentWord}}
      </div>
    </body>
    </html>
    
Next, let's add a form to hangman so that the user can enter a secret word.  Here are the changes to the html:


    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
      </div>
    </body>
    </html>
    
Two things are new here.  We've added `ng-submit` to the form tag and `ng-model` to the input tag.  The `ng-submit` tells the form which angular method to call on submit.  The `ng-model` tag binds the value of the input tag to `$scope.newWord` in the `HangManCtrl`.

#### Exercise

Make the contoller save the word that the user adds to the input tag.  For now, display the results of adding the word to the screen after the closing form tag.  __NOTE__: Make sure you are displaying data from the controller.

![Angular](angular.png)

#### Solution

`index.html`

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         {{currentWord}}
      </div>
    </body>
    </html>


`hangman.js`

```
 var HangManCtrl = function($scope) {
     $scope.currentWord = "angular";
      
     $scope.addWord = function(){
         $scope.currentWord = $scope.newWord;
         $scope.newWord = "";
     };
 };
```

#### Exercise

Add another form and input tag.  The input field should be used to gather guessed characters.  Every time the user clicks `Check Guess`, save the character into an array of guesses in your controller.  Also, get rid of the code to display the secret word!

![Angular](angular.png)


#### Solution

`index.html`

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         
         <form ng-submit="addGuess()">
           <input type="text" ng-model="guess">
           <button>Check Guess</button>
         </form>
         {{guessedChars}}
      </div>
    </body>
    </html>
    
`hangman.js`

```
var HangManCtrl = function($scope) {
    $scope.currentWord = "angular";
    $scope.guessedChars = [];
      
    $scope.addWord = function(){
        $scope.currentWord = $scope.newWord;
        $scope.newWord = "";
    };
   
    $scope.addGuess = function() {
      $scope.guessedChars.push($scope.guess);
      $scope.guess = "";
    }
    
};
```

To make this hangman game a little more user friendly, we only want to add a guess to the array of `guessesedChars` if the guess hasn't been tried already.  Here is the new `HangManCtrl` with an updated addGuess method:

```
var HangManCtrl = function($scope) {
    $scope.currentWord = "angular";
    $scope.guessedChars = [];
      
    $scope.addWord = function(){
        $scope.currentWord = $scope.newWord;
        $scope.newWord = "";
    };
   
    $scope.addGuess = function(){
       if($scope.guessedChars.indexOf($scope.guess) === -1){
          $scope.guessedChars.push($scope.guess);
       }
       $scope.guess = "";
    };
    
};
```

## Ng-repeat and Controller Methods

Our next task in hangman is to display all the characters that the user has guessed so far.  To accomplish the task, we use `ng-repeat` in the html.  The `ng-repeat` directive allows us to loop over a collection of data.


    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         
         <form ng-submit="addGuess()">
           <input type="text" ng-model="guess">
           <button>Check Guess</button>
         </form>
         <div ng-repeat="guessedChar in guessedChars">
           {{guessedChar}} 
         </div>
      </div>
    </body>
    </html>


We also want to show the user which guesses are correct so far.  We'll do that by displaying a set of `_`'s and filling in the characters that the user guesses.  Here is the new html which displays the underscores:

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         
         <span ng-repeat="char in displayChars() track by $index" >
           {{char}}
         </span>
         
         <form ng-submit="addGuess()">
           <input type="text" ng-model="guess">
           <button>Check Guess</button>
         </form>
         <div ng-repeat="guessedChar in guessedChars">
           {{guessedChar}} 
         </div>
      </div>
    </body>
    </html>


#### Exercise

Fill in the `displayChars` method in the controller.  The method should return an array of characters.  The characters should correspond to the `currentWord`.  If a character has been guessed, it should be present in the array, if it has not been guessed, it should be an `_` character.


![Angular](angular.png)

#### Solution

In the displayChars method the code is going to split the current word into an array.

```
var HangManCtrl = function($scope) {
    $scope.currentWord = "angular";
    $scope.guessedChars = [];

    $scope.addWord = function(){
        $scope.currentWord = $scope.newWord;
        $scope.guessedChars = [];
        $scope.newWord = "";
    };

    $scope.displayChars = function(){
      var chars = $scope.currentWord.split("");

      chars.forEach(function(val, index){
        if( $scope.guessedChars.indexOf(val) === -1){
           chars[index] = "_";
         }
      });
      return chars;
    };
  
  
    $scope.addGuess = function(){
       if($scope.guessedChars.indexOf($scope.guess) === -1){
          $scope.guessedChars.push($scope.guess);
       }
       $scope.guess = "";
    };
};
```

Finally let's finish this app.  We can add the number of guesses just by using the lenght of the guessedChars array:

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         
         <span ng-repeat="char in displayChars() track by $index" >
           {{char}}
         </span>
         
         <form ng-submit="addGuess()">
           <input type="text" ng-model="guess">
           <button>Check Guess</button>
         </form>
         <div ng-repeat="guessedChar in guessedChars">
           {{guessedChar}} 
         </div>
         <div>
           You have guessed {{guessedChars.length}} times
         </div>
      </div>
    </body>
    </html>
    
    
#### Exercise

Use `ng-pluralize` in place of the number of guesses so that the message will be different if there are 0, 1, or many guesses.  Also, add an `ng-style` tag to you `ng-repeat` for the `guessedChars`.  

![Angular](angular.png)

#### Solution

`index.html`

    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.14/angular.min.js"></script>
      <meta charset="utf-8">
      <title>HangMan</title>
    </head>
    <body ng-app>
      <div ng-controller="HangManCtrl">
        <form ng-submit="addWord()">
          <input type="password" name="newWord" ng-model="newWord" placeholder="Enter A New Word"> <br>
          <button> Add Word</button>
         </form>
         
         <span ng-repeat="char in displayChars() track by $index" >
           {{char}}
         </span>
         
         <form ng-submit="addGuess()">
           <input type="text" ng-model="guess">
           <button>Check Guess</button>
         </form>
         <div ng-repeat="guessedChar in guessedChars" ng-style="isGuessed()">
           {{guessedChar}} 
         </div>
         <div>
            <ng-pluralize count="guessedChars.length"
               when="{'0': 'you have not guessed.',
                      '1': 'you have guessed {{guessedChars.length}} time',
                      'other': 'you have guessed {{guessedChars.length}} times'}">
             </ng-pluralize>
         </div>
      </div>
    </body>
    </html>

`hangman.js`

```
var HangManCtrl = function($scope) {
    $scope.currentWord = "angular";
    $scope.guessedChars = [];
    $scope.guessedStyle = {color: "green"};
    $scope.wrongStyle = {color: "red"};

    $scope.addWord = function(){
        $scope.currentWord = $scope.newWord;
        $scope.guessedChars = [];
        $scope.newWord = "";
    };

    $scope.displayChars = function(){
      var chars = $scope.currentWord.split("");

      chars.forEach(function(val, index){
        if( $scope.guessedChars.indexOf(val) === -1){
           chars[index] = "_";
         }
      });
      return chars;
    };


    $scope.addGuess = function(){
       if($scope.guessedChars.indexOf($scope.guess) === -1){
          $scope.guessedChars.push($scope.guess);
       }
       $scope.guess = "";
    };
    
    $scope.isGuessed = function() {
        var chars = $scope.currentWord.split("");
        return chars.indexOf(this.guessedChar) !== -1? $scope.guessedStyle : $scope.wrongStyle;
    };
};
```