# Introduction to Classes

## Objectives
Students will be able to...

- articulate the difference between an object and a class
- define and instantiate a class
- use instance methods and instance variables
- use the `initialize` method
- define getters and setters
- use attr_*
- recognize and impliment class methods, class variables, and self
- include and extend modules

### Object vs. Class

An object represents an abstract thing, usually with some sort of behavior (methods). A class, in turn, can create many objects with the same behavior (methods). 

### Define and Instantiate a Class

Classes include three basic components: the reserved word `class`, a name of the class, and the reserved word `end`. Focus on the name of the function: it begins with a capital letter, which represents a constant.

```ruby
class Car
end
```

To create instances of our class, we will create a variable and assign it the return value of `Car.new`, which is an object. 

```ruby
car = Car.new
car
```

### Instance methods and instance variables

We are able to create instances of a `Car`, but our instances currently hold marginal value. We need, in turn, to use instance methods and instance variables. An instance method represents a function that is accessible on every instance of a class. To create an instance method, we must use the following syntax inside the definition of our class:

```ruby
class Car
  def color
    "red"
  end
end
```

The syntax of an instance method typically includes four components: the reserved word `def`, a method name, a body, and the reserved word `end`.

At this moment, all instances of a `Car` have the same name. Let's make the method `color` dynamic and utilize instance variables.

An instance variable--which begin with the `@` symbol--has the capability of storing data for each instance of a class. This may seem unclear at this moment, so an example will help: 

```ruby 
class Car
  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

car_one = Car.new
car_one.color = "green"
car_one.color

car_two = Car.new
car_two.color = "black"
car_two.color
```

Every time an instance of `Car` is assigned a color, it will have its own instance variable named `@color`.

### `initialize`

In Ruby there's a built-in method named `initialize`. This method is invoked every time a class is instantiated. Let's prove that this is true with the creation of a method named `initialize`. 

```ruby 
class Car
  def initialize
    puts "We just created a new Car!"
  end
  
  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new
audi = Car.new
```

If we apply this new knowledge, we can re-write our class definition to give a car a color during instance creation.

```ruby 
class Car
  def initialize(color)
    @color = color
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new("black")
bmw.color
```

### Exercise 1
Create the following three classes: 

- Minion
- Person
- Bear

For each class, add enough methods to meet this requirement: 

- has an initialize method

- includes two instance variables

- uses string interpolation in one method

### Getters and Setters

Up to this moment, we've been utilizing instance methods and instance variables to set (`initialize` and `color=`) and get (`color`) data. We've already been using getters and setters!

```ruby 
class Car
  def initialize(make)
    @make = make
  end

  def make
    @make
  end
end

bmw = Car.new("bmw")
bmw.make
``` 

Great, at this moment we have a getter named `make`. With our getter, we can access a car's make with dot notation and the method `make`.

In regards to our setter method, which is used to set data, we have a problem. At present, we can only set a car's make during instance creation. With this design, we don't have a way to update a car's make after instantiation. To achieve this goal, we will have to use a special syntax:

```ruby 
class Car
  def initialize(make)
    @make = make
  end

  def make=(make)
    @make = make
  end

  def make
    @make
  end
end

car = Car.new("mercedes")
car.make
car.make=("bmw")
car.make
``` 

Or you just skip the parentheses:

```
car.make = "bmw"
```

Take a moment to notice the difference above. 

### `attr_*`

If we add more methods to our class, we will start to notice a lot of repetition: 

```ruby 
class Car
  def initialize(make)
    @make = make
  end

  def make=(make)
    @make = make
  end

  def make
    @make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end
``` 

Every getter has a method with a name (`make` and `color`) that is included in the instance variable (`@make` and `@color`). The same is true for setters.  

Ruby provides a syntax to shorten this common pattern: attributes. Attributes allow for the introduction of a different syntax for creating getters and setters. Let's demonstrate this with creating a getter for `make`. 


```ruby 
class Car
  attr_reader :make

  def init(make)
    @make = make
  end

  def make=(make)
    @make = make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end

bmw = Car.new("bmw")
bmw.make
``` 

`attr_reader` does the same thing as our former method `make`. We can also use this shorthand syntax to create setters with attributes: 

```ruby 
class Car
  attr_reader :make
  attr_writer :make

  def initialize(make)
    @make = make
  end

  def color=(color)
    @color = color
  end

  def color
    @color
  end
end
```

Finally, if we have both a getter (reader) and setter (writer), we can use attr_accessor: 

```ruby 
class Car
  attr_accessor :make, :color

  def initialize(make)
    @make = make
  end
end
```

Now, there may be moments where we want to get or set data associated with all instances of a class. In this case, we need to explore class methods and class variables. 

### Exercise 2

Repeat exercise 1, but use attr_* for getters and setters, where appropriate. 

### Class Methods, Class Variables, and Self
Class methods and class variables are used when data pertains to more than just an instance of a class. Let's imagine that we want to keep count of all cars that were instantiated. We use a class variable, indicated by `@@`.


```ruby 
class Car
  attr_accessor :make, :color
  @@count = 0

  def initialize(make)
    @make = make
    @@count = @@count + 1
  end

  def self.count
    @@count
  end
end

Car.count
# => 0

bmw = Car.new('bmw')
Car.count
# => 1

audi = Car.new('audi')
Car.count
# =>
```

Two things are happening at this moment. First, we are definining a class variable - which, again, begins with a double `@` symbol. This variable will exist throughout all instances of a mininon. Next, we are defining a method on the class `Car` using the keyword `self`. We will explore `self` more during the next several days. For now, know that if you place the word `self` next to a method name, it places the method not on instances of a class; rather, the method is on the class. 

### Exercise 3
Create a Person class with the accessors name and hobby. Keep track of all people that were created (hint: Person should have a class method called `all` that returns an array of all instances that have been instantiated).

## Modules
Modules are a way to store methods in a container and make those methods available to several classes. It encourages being DRY and good separation of concerns.

For example, what do cows and horses have in common? They eat grass.

So, we could either do this:

```ruby
class Cow
  def eat_grass
    puts "I am eating grass!"
  end
end

class Horse
  def eat_grass
    puts "I am eating grass!"
  end
end
```

See the repition? We can achieve the same results by using a module called `GrassEater`:

```ruby
module GrassEater
  def eat_grass
    puts "I am eating grass!"
  end
end

class Cow
  include GrassEater
end

class Horse
  include GrassEater
end

Cow.new.eat_grass
# => "I am eating grass!"

Horse.new.eat_grass
# => "I am eating grass!"
```

Modules are agnostic as to whether or not the methods they are holding are supposed to be instance or class methods. If you want the methods in a module to be available as class methods on the class, you need to use the keyword `extend` in lieu of `include`.
