## Classical Inheritance in Ruby: Exercises ##

*Note: For all the exercises below, you can find solutions in the `solutions` branch of this repository.*

##Goal #1 - Implement Inheritance:

- Inheritance is used to give a child class most, or all of the features of a parent class.
- Inheritance helps us:
  + Write DRY code
  + Implement ideas faster
  + Improve our encapsulation

### Exercises to Complete:

#### Exercise: Warehouse Software:

  1. You're hired to write the software to manage a warehouse that ships goods to consumers. Your first task will be developing a system that helps calculate the volume of the various boxes available in the warehouse. You're going to need:
    - A `box` class
    - A method to calculate the volume of the box based on its length, width, and height

  2. Now imagine your warehouse starts using special "cube" shaped boxes. Like most cubes, a property of these cubical boxes is that their width == length == height.
    - Create a `cube` class that once again, calculate the volume of a cube without re-writing everything (i.e., have `cube` inherit from `box`).

  3. Test your new `box` and `cube` classes out in a `pry` REPL.

**BONUSES:** 

  - Try adding a class variable that keeps track of all the `box`es and `cube`s that have been created so far.
  - Create a `to_s` method for `box` and `cube` that prints a pretty description of a `box` or a `cube` to the console.


#### Exercise: We're Just Animals, After All

We humans are animals, just like everything else on the planet. In this exercise, you'll define:
  1. An `Animal` class, with the following:
    - Properties:
      + `kind`: A string that holds the type of animal
    - Instance Methods:
      + `eat`: Takes a parameter `food` to eat and prints out a message that the animal is eating `food`
      + `sleep` & `wake`: These two methods should NOT be passed any arguments. Instead, they will set an instance variable `@state` to the string `"asleep"` or `"awake"` respectively.

  2. A `Person` class, with the following characteristics:
    - Inherits from `Animal`
    - Automatically sets `@type` to `"person"` 
    - Adds 3 new instance vars:
      + age
      + gender
      + name
    - Also, people aren't cannibals! Make sure your `Person` class *overrides* the existing `eat` method (in `Animal`) so that a `Person` cannot eat any of the following:
      + person, people, human, humans, woman, man, girl, lady, boy, guy, children, child, baby, babies, toddlers

**BONUS:**
    - We people can speak, and it's good to be polite. Add an instance method called `greet` that:
      + Prints out a person's name, age, and gender in the following format: "Hi, I'm Brett. I'm a man, and I'm 76 years old."
    - Add a `class variable` that keeps track of all the people you create.


#### Exercise: Mammals and more Mammals

1.  Create a `Mammal` class that has the following properties and methods:

  - Properties:
    + num_legs
    + has_hair
    + species
    + weight
    + length
    + place_of_origin
  - Methods (Each method, except `make_noise` simply `puts` the action being taken)
    + kill
    + make_noise (takes a noise and prints it out)
    + reproduce
    + move

2. Create the following classes and have them inherit from `Mammal`

NOTE: For each of the different mammal sub-classes, think about what instance variables you can preset when you call `super` in the `initialize` method.

  - Cat
    + Create a method called `meow` that uses `make_noise` to do its work.
  - Dog
    + Create methods called `bark` and `whimper` (use `make_noise` to do the work)
  - Lab (inherits from `Dog`)
    + Think about what you can preset when you call `super` in the `initialize` method.


## Goal #2: Implement File Separation

Using `load` / `require`, separate the classes you just created into multiple files (if you haven't done so already).

## Additional Resources:

### More about `super`:

- When you invoke `super` with arguments, Ruby sends a message to the parent of the current object, asking it to invoke a method of the same name as the method invoking `super`. 
- Super sends the right number of arguments for the parent's class' argument count if you don't specify any arguments

### Notes/More Information:

  - ​to_s​ is actually defined in class ​Object​. Because ​Object​ is an ancestor of every object in Ruby. In this sense, it is the _parent_ of all objects.
  - Fixnum: http://www.ruby-doc.org/core-2.1.1/Fixnum.html#method-i-to_s
  - Hash: http://www.ruby-doc.org/core-2.1.0/Hash.html#method-i-inspect
  - Array: http://www.ruby-doc.org/core-2.1.1/Array.html#method-i-to_s

### BONUS:
There may be situations where certain properties of the superclass should not be inherited by a particular subclass. Though birds generally know how to fly, penguins are a flightless subclass of birds.

Create a Bird class & a Penguin class. Give the Bird class an initialize, preen, and fly methods. Give the Penguin class a new fly method (since it cannot fly).