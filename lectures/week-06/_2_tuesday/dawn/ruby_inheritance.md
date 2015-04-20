# Inheritance in Ruby #

## Quick Review: ##

  * What is a method? What is a class?
  * What is an instance method? 
  * Why do we use a class?

## Learning Objectives ##

**By the end of the lesson, we'll:**

  * Be able to implement inheritance and clearly describe what has been inherited from one class to another
  * Understand the differences between classical inheritance in Ruby and Prototypical inheritance in Javascript
  * Know how to use inheritance to model objects and their relationships
  * Know when to separate files
    + And how to do so using `require`, `require_relative`, `load`

## Active Learning: Inheritance ##

**Group Discussion (10 mins)**

In groups of 3 or 4, spend 10 minutes discussing what you already know about inheritance, and answering the following questions *(you're welcome to use Google together to research and gather information)*:

  * What is inheritance?
  * What do we mean when we say 'classical inheritance?'
  * How does classical inheritance differ from prototypical inheritance?
  * How do we know when to use inheritance in our applications?
  * What are some unique features of inheritance in Ruby?

## Code Along ##

### A somewhat trivial example: ###

**A motor vehicle (motor_vehicle) intended for roads:**

| Properties                        | Methods                             |
| :-------------------------------  | :----------------------------       |
| Has some number of wheels         | Is capable of accelerating          |
| Has a length, width, and height   | Is capable of braking (or stopping) |
| Has a mass (weight)               | Is capable of turning               |

__A car__ < Extends "motor_vehicle"

Includes all the properties and methods of "motor_vehicle", plus:

| Properties                               | Methods                          |
| ---------------------------------------  | -------------------------------- |
| May be a convertible                     | Open convertible                 |
| Number of doors (usu. 2, 4, 5)           | Lock doors                       |
| Type of engine (gas, diesel, electric)   | Start engine                     |
| Type of transmission (auto, manual)      | Change gears                     |
| Color                                    | Change temperature

__A tractor trailer__ < Extends "motor_vehicle"

Includes all the properties and methods of "motor_vehicle", plus:

Properties | Methods
---- | ----
Cargo capacity (volume) | Slide up cargo door
Cargo capacity (weight) | Attach to trailer
Number of axles | Use CB Radio
Engine type (gas/diesel) | Beep when backing up

Questions?

Ok... moving on to our objectives.

##Goal #1 - Inheritance:

- Inheritance is used to indicate that one class will get most or all of its features from a parent class. 
    
-When is inheritance useful?
        a. DRY - Don't Repeat Yourself & reuse code functionality
        b. Faster implementation time

        - Example: Suppose you're building an application that helps you ship goods. Many forms of shipping are available, but all forms share some basic functionality (weight calculation, perhaps). We don’t want to duplicate the code that implements this functionality across the implementation of each shipping type. 

### You Try This

```rb
class Box

  def initialize(w, h)
    @width = w 
    @height = h
  end

  def get_area
    @width - @height
  end

end

class BigBox < Box

  def print_area
    @area = @width - @height
  end

end

# Things to consider:
# How would I create a box? How could I create a BigBox?
# How would I print the area of the BigBox?
```

### Stop


### A Guide through Animals

```rb
class Animal
  
  def initialize(kind)
    @kind = kind
    @state = "awake"
  end
  
  def eat(food)
    if @state == "awake""
        puts "NOM-nom!!"
        puts "(#{kind} has eaten #{food})"
    else
        puts "SLEEPING"
    end
    self
  end
  
  def sleep
    @state = "sleeping"
    self
  end
  
  def wake
    @state = "awake"
    self
  end
end

class Person < Animal
    def initialize(age, gender, name)
        @age = age
        @gender = gender
        @name = name
    end
end
```

- Single Inheritance vs Multiple Inheritance
    - In Ruby, a class can only inherit from a single other class. It __cannot__ inherit from multiple classes.
    
    ![](https://draftin.com:443/images/13819?token=LgAN2Cjq0VY2E1kC14KkUjazImyXfmOTtc-EiNJbdofQ25kQLkSBtxVpde5pu1y2if0_H6LTEUeTaklH1Yjmimw) 
    - Benefits and disadvantages to single & multiple inheritance
    - In Ruby, initialize is an ordinary method and inherited just like another method.



####Exercise #1:
Create a Mammal class, Cat class, and Dog class. Have Cat and Dog inherit from Mammal. Include some attributes for each class and a method for mammal.


####Exercise #2:

```rb
class Dog  
  def initialize(breed)  
    @breed = breed  
  end  
  
  def to_s  
    "(#@breed, #@name)"  
  end  
end  
  
class Lab < Dog  
  def initialize(breed, name)  
    # give the dog a breed efficiently
    @name = name  
  end  
end  
  
puts Lab.new("Labrador", "Ben").to_s 

 # .to_s is called implicitly with any puts or print or p method call  

```

###Think About The Following

- When you invoke -super- with arguments, Ruby sends a message to the parent of the current object, asking it to invoke a method of the same name as the method invoking super. 
- Super sends the right number of arguments for the parent's class' argument count

### Discuss in pairs:
- Do class variables and instance variables get inherited in Ruby??

__Notes:__

  - ​to_s​ is actually defined in class ​Object​. Because ​Object​ is an ancestor of every object in Ruby. In this sense, it is the _parent_ of all objects.
  - Fixnum: http://www.ruby-doc.org/core-2.1.1/Fixnum.html#method-i-to_s
  - Hash: http://www.ruby-doc.org/core-2.1.0/Hash.html#method-i-inspect
  - Array: http://www.ruby-doc.org/core-2.1.1/Array.html#method-i-to_s

####Exercise #2:

There will be situations where certain properties of the superclass should not be inherited by a particular subclass. Though birds generally know how to fly, penguins are a flightless subclass of birds.

Create a Bird class & a Penguin class. Give the Bird class an initialize, preen, and fly methods. Give the Penguin class a new fly method (since it cannot fly).


##Goal #3 - load & require


###load
- This will reload the ruby file every time it's called.
- Load is typically used for checking for small changes and debugging - does not keep track of whether a file or library has been loaded

###require
- This will load a ruby file ONCE and only once. All subsequent require statements will not reload the file.
- Doesn't need the .rb file extension, but won't hurt if it's there.

###require_relative
  - Same as `require`, but will look for the file to require in the same directory as the file that is making the request.

##Exercise
Change code and see how load and require behave.

  1. Create Person class that has name and age attributes. It will also have a method to determine if person can vote. Initially a person can vote if the are over 18.
  2. Open pry and "load" this person class.
  3. Create a person that is age 19.
  4. Can they vote?
  5. Now change the person class so that the voting age is now 2  1.
  6. Load the person class. Was the change seen?


