# Scopes and Context in JavaScript
A lecture introducing scopes and context in JavaScript.

# Objectives
Students will be able to...

- describe the purpose of scope
- create new scopes
- create a closure
- pass data between different scopes
- describe the concept of context
- know the value of this 
- describe the difference between scope and context 

# Link
Until now, we’ve explored the visible parts of functions. Things that we can see in the code. There are, as we will soon learn, also invisible parts of functions. To truly master functions, we need to understand two of these invisible topics: scope and context


## Describe a Scope
Defines accessbility to data during a specifc point in code. 

## Create New Scopes 

```javascript
var globalScope = "I'm in the global scope.";

var localScope = function() {
  return "I'm in a local scope."	
};
```

## Create a Closure
```javascript
var globalScope = "I'm in the global scope.";

var localScope = function() {
  var closureVariable = "I'm inside the closure--between two functions."

  return function() {
    return "I can access the value of closureVariable here. This is the only place that closureVariable can be accessed.";
  };
};

var returnedFunction = localScope();

//"I can access...."
returnedFunction();
```

## Pass Data Between Different Scopes

```javascript
// incorrectly accessing local variables
var function_1 = function() {
  var value_1 = 1;

  return value_1; 
};

var function_2 = function() {
  return value_1;
};

// 1
function_1(); 

// ...undefined
function_2();
```

```javascript
// correctly accessing local variables
var function_1 = function() {
  var value_1 = 1;

  return value_1; 
};

var function_2 = function(param_1) {  
  return param_1;
};

// 1
var val = function_1(); 

// 1
function_2(val);
```

## Describe a Context
Context is closely related to scope. Context is created when a function is invoked. Unlike scope, context refers to just the immediate scope and what object was associated during its invocation. 

## What's This
<code>this</code> is a keyword that references the object associated with a function being invoked.  

## Scope vs. Context
Scope deals with data accessibility. Context deals with the object associated with a function being invoked.
