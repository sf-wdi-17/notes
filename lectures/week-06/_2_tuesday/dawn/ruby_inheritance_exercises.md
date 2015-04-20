## Classical Inheritance in Ruby: Exercises ##

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


#### Solution:

```ruby
class Box

  def initialize(l, w, h)
    @width = w 
    @height = h
    @length = l
  end

  def get_volume
    @length * @width * @height
  end

end

class Cube < Box

  def initialize(side)
    super(side, side, side)
  end

end

```


#### Exercise: We're Just Animals, After All


#### Solution

```ruby

```



#### Exercise: Mammals and more Mammals


#### Solution

```ruby

```

#### Additional Exercise: Implement File Separation

Using `load` / `require`, separate the classes you just created into multiple files (if you haven't done so already).

## Additional Resources:

### More about `super`:

- When you invoke -super- with arguments, Ruby sends a message to the parent of the current object, asking it to invoke a method of the same name as the method invoking super. 
- Super sends the right number of arguments for the parent's class' argument count

### Notes/More Information:

  - ​to_s​ is actually defined in class ​Object​. Because ​Object​ is an ancestor of every object in Ruby. In this sense, it is the _parent_ of all objects.
  - Fixnum: http://www.ruby-doc.org/core-2.1.1/Fixnum.html#method-i-to_s
  - Hash: http://www.ruby-doc.org/core-2.1.0/Hash.html#method-i-inspect
  - Array: http://www.ruby-doc.org/core-2.1.1/Array.html#method-i-to_s

There may be situations where certain properties of the superclass should not be inherited by a particular subclass. Though birds generally know how to fly, penguins are a flightless subclass of birds.

### BONUS:
Create a Bird class & a Penguin class. Give the Bird class an initialize, preen, and fly methods. Give the Penguin class a new fly method (since it cannot fly).