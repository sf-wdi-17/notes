# Object Orientation
Lecture on object oriented programming (OOP).

## Objectives
Students will be able to...

- understand the core principles of OOP
- create custom objects
- write custom constructors

## Introduction to OOP
What is OOP? Let's ask Steve Jobs...

Watch:

- https://www.youtube.com/watch?v=2kjtQnPqq2U
- https://youtu.be/SaJp66ArJVI?t=1m58s

Somebody read out loud:

- http://www.edibleapple.com/2011/10/29/steve-jobs-explains-object-oriented-programming/

Let's summarize some of those ideas/principles!

## Plain Objects
A plain object in JavaScript can be created in two ways:

```javascript
var object = new Object();

// or

var object = {};
```

We could then assign properties and methods to the object. For example, think of a car:

```javascript
var car = new Object();

// Assign some properties
car.speed = 0;
car.color = 'red';
car.make = 'BMW 7 series';

// Assign some methods
car.accelerate = function(gain) {
	car.speed += gain;
	return car.speed;
}

car.decelerate = function(loss) {
	car.speed -= loss;
	return car.speed;
}
```

And now we could play around with these properties and methods:

```javascript
car
// => { speed: 0,
//  color: 'red',
//  make: 'BMW 7 series',
//  accelerate: [Function],
//  decelerate: [Function] }

car.speed
// => 0

car.color
// => 'red'

car.accelerate(20);
// => 20

car.speed
// => 20
```

Is this already OOP? Sort of. It's just not reusable. So long as we only need one car, this is fine, but once we want to reuse this logic with multiple cars (for example, to build a car race), we have to rewrite the above logic every time. That means for each car, we need to assign the properties `speed`, `color`, and `make`, and the methods `accelerate()` and `decelerate()`.

## The Power of Constructors
Constructors allow us to abstract out logic that all objects of a certain kind should share. Rather than describing a specific car, for example, we can describe the idea of a car. To do that, we need to ask ourselves two key questions:

- What does the car know?
- What can the car do?

The first question is about the values it can store/remember, the second is about a car's abilities. Again, we want to define these two things at the high level of the idea of a car, so that we can then instantiate that idea into an actual car. The instantiation could then happen multiple times, leaving us with many different cars that share the same abstract characteristics, but can all have different values for each.

### Writing a Constructor
"Contructor" is really just a fancy term for a function that stars with a capital letter. We're really just declaring a function.

For constructors, function declarations are preferred over function expressions:

```javascript
function Car() {
	// logic here
}
```

Inside the `Car` constructor, we can then define properties and methods on a keyword called `this`, which just refers to the car itself inside the `Car` constructor.

```javascript
function Car() {
	this.color = 'red';
}
```

This would be fine except maybe we want cars to have different colors. How can we achieve that functionality? It's very simple, since constructors are just functions, and we can pass parameters to a function:

```javascript
function Car(color, make) {
	this.color = color;
	this.make = make;
}
```

Let's also extend the functionality so that a car can accelerate and decelerate:

```javascript
function Car(color, make) {
	// From parameters
	this.color = color;
	this.make = make;

	// Set speed to 0 since that's what a car starts out with
	this.speed = 0;

	// Assign methods
	this.accelerate = function(gain) {
		this.speed += gain;
		return this.speed;
	}

	this.decelerate = function(loss) {
		this.speed -+ loss;
		return this.speed;
	}
}
```

Excellent! Now we can instantiate a car using the `new` keyword:

```javascript
var car = new Car('red', 'BMW');

car
// => { color: 'red',
//  make: 'BMW',
//  speed: 0,
//  accelerate: [Function],
//  decelerate: [Function] }
```

Looks the same as at the very beginning of the lesson, you might say. That's true, except that now we can reuse the Car constructor to instantiate several cars.

```javascript
var car1 = new Car('red', 'BMW');
var car2 = new Car('black', 'Porsche');
```

## Active Learning
Partner up with your buddy!

Write your own `Person` constructor. It can take a first name and last name as parameters that it can store, and it can print out its full name.

Once you're done, write a `Course` constructor resembling a course at GA. It has a size (number of enrolled people) and can enroll people. Achieve this by combining both the `Course` and `Person` constructor.

## Reflect
Reiterate over core OOP concepts with your buddy. Test each other! Help each other out with any questions you might have.

## Closing Words
The goal of OOP is really to bring programming closer to the real world and to make it reusable. The real world doesn't consist of some functions in a vacuum; it consists of objects that can store/know/remember things, and that can do things. For example, a person knows his/her name and can breathe.

Again, to better resemble the real world in programming and to make our components reusable, we use OOP. It will accompany us throughout the rest of the course, and many other programming languages, such as Ruby, are purely object oriented.
