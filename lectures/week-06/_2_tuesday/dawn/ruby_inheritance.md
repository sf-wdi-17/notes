# Inheritance in Ruby 

## Getting Started (10 mins total)

### Quick Review:

  * What is a class?
    - What is a property?
    - What is a method?
  * What is the difference between:
    - an instance method,
    - a class method
  * Why do we use classes?

### Classical Inheritance: Learning Objectives

**By the end of the lesson, we'll:**

  * Be able to implement inheritance and clearly describe what has been inherited from one class to another
  * Understand the differences between classical inheritance in Ruby and Prototypical inheritance in Javascript
  * Know how to use inheritance to model objects and their relationships
  * Know when to separate files
    + And how to do so using `require`, `require_relative`, `load`

## Okay, let's dive in!

### Think-Pair-Share: Inheritance (10 mins) 

**Break into Small Groups**

In groups of 3 or 4, spend 10 minutes discussing what you already know about inheritance, and answering the following questions *(you're welcome to use Google together to research and gather information)*:

  * What is inheritance?
  * What do we mean when we say 'classical inheritance?'
  * How does classical inheritance differ from prototypical inheritance?
  * How do we know when to use inheritance in our applications?
  * What are some unique features of inheritance in Ruby?

#### Think-Pair-Share: Inheritance Discussion (5 mins)

Let's all come back together and discuss the questions above.

### Active Learning (Code Along - 20 mins) 

Let's start with a somewhat trivial (but useful) example.

**Class: `Motor_Vehicle`:**

*`Motor_Vehicle` will be our base class.*

| Properties                        | Methods                             |
| --------------------------------  | -----------------------------       |
| Has a length, width, and height   | Is capable of accelerating          |
| Has a mass (weight)               | Is capable of slowing down (+ stopping) |
|                                   | Is capable of turning               |

**`Car`** < Extends "Motor_Vehicle"

*Includes all the properties and methods of "Motor_Vehicle", plus:*

| Properties                              | Methods                          |  
| --------------------------------------- | -------------------------------- |  
| May be a convertible                    | Open/Close convertible top       |  
| Number of doors (usu. 2, 4, 5)          | Lock doors                       |  
| Type of engine (gas, diesel, electric)  | Start engine                     |  
| Type of transmission (auto, manual)     | Change gears                     |  
| Color                                   | Adjust climate control           |  
| Make                                    | Play music                       |  
| Model                                   | Open/close windows               |  
| Has car phone (yes...it's 1988)         | Answer phone                     |  
|                                         | Provide navigation to address    |  

#### Questions? (10 mins)

Have questions? Call-em-out! We'll answer them together.

#### Pair Programming (15 mins) !!

Ok, now it's your turn. Based on the steps we took to build a `car` class by extending the `Motor_Vehicle` class, work together to build a `boat` class. The definition of a boat follows (but feel free to add additional methods and properties if you think they are needed!):

**`Boat`** *< Extends "Motor_Vehicle"*

*Includes all the properties and methods of "Motor_Vehicle", plus:*

| Properties                          | Methods                           |  
| -------------------------           | --------------------------------- |  
| Draft (minimum water depth)         | Float                             |  
| Maximum weight capacity             | Tow waterskier                    |  
| Callsign/name (i.e. "Ruby Sky")     | Call coast guard on CB radio      |  
| Engine type (gas/diesel)            | Turn rudder                       |  
| Propulsion type (out/in-board, jet) | Raise/lower sails                 |  
| Number of sails                     | Raise/lower propeller             |  
| Number of propellers                |                                   |  
| Angle of propellers                 |                                   |  

<br>
#### Pair Programming: Present Solution! (5 mins)

I'm looking for one group who's brave enough to explain their solution to the rest of the class.

#### Identifying Potential Pitfalls (15 mins)

Before we move on, we're going to spend 15 minutes discussing what *might* be confusing about this. So before we can continue, I need 3-5 things that you feel one of your fellow classmates could find confusing about **Classical Inheritance**.

#### Think-Pair-Share: Identifying OOP Design Problems (10 mins)

I didn't mention it before, but there are actually some potential design problems in the classes described above. 

In your groups (of 3 or 4) discuss what properties (or methods) in the `Motor_Vehicle`, `Car`, or `Boat` classes might be problematic. How might we fix these issues?

##### Think-Pair-Share: OOP Design Problems - Solution! (5 mins)

Let's come together and have each group talk about the problems they identified with the classes we just built together.

### File Separation in Ruby (`load`, `require`, and `require_relative`) (10 mins)

Load & require are very similar to the purpose of `require` in Node.js

Before you start using these commands in ruby, it's important to understand what they do and how each one is different:

####`load`
  - This will reload the ruby file every time it's called.
  - Load is typically used for checking for small changes and debugging - does not keep track of whether a file or library has been loaded

####`require`

  - This will load a ruby file ONCE and only once. All subsequent require statements will not reload the file.
  - Doesn't need the .rb file extension, but won't hurt if it's there.
  - Only used to include ruby `gems` that have been installed with `gem`.
    + Don't use `require` to include your own `.rb` files (because when you wrote them, you should use `require_relative` to tell the ruby interpreter where to look for your file.)

####`require_relative`
  - Same as `require`, but will look for the specified `.rb` file *relative* to the file that is making the request.
    + That is, when you use `require_relative`, ruby will start looking for the file in the same directory as the file where you include the `require_relative` statement

### Active Learning: `load` & `require` (10 mins)

Create a class and then include it using both `load` and `require_relative`. Observe the differences in behavior.

  1. Create Person class that has name and age attributes. It will also have a `vote` method. But before the person can `vote`, the method should check to make sure that person is over age 18.
  2. Open pry and `load` this person class.
  3. In `pry`, create a person who is 19 years old.
  4. Try to vote. If everything is set up correctly, this shouldn't be a problem.
  5. Now change the `vote` method in the person class so that the voting age is 21.
  6. `load` the person class. Was this change seen?

Exit `pry` (type `exit`) and then open a new pry REPL (type `pry` at a bash prompt). Now, repeat the steps above starting at Step 2, but this time use `require_relative` rather than `load`. When you change the voting age and re-require the class, are the changes reflected?

### Discussion: `load` & `require` (5 mins)

In small groups, research and discuss the differences between `load` and `require/require_relative`. Try to answer the following:

  - How are `load` and `require` different in practice?
  - In what situations should you use `load`?
  - In what situations should you use `require`?
  - In what situations should you use `require_relative`?

I would like one group to volunteer to explain what they discussed to the rest of the class.

### Exercises:

It's unlikely we'll have time to do [these exercises](ruby_inheritance_exercises.md) in class, but if you can, doing [these exercises](ruby_inheritance_exercises.md) will provide you with some repetition and help you in the long run.


