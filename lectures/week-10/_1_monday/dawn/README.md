# Intro To Datastructures
## Binary Trees

* Intro To Trees
  * Defining a tree
    * A tree node
    * A `leaf`
    * A `root`
    * A `parent`
      * `children`
  * Defining Attributes of Trees
    * height
    * level
  * A BinaryTree
    * Implementation
      * `#insert`
      * `#max`
      * `#min`
      * `#height`
      * `#to_a`
      * `#level`

## Part 1: Build a Binary Tree Class (50 Minutes)
Binary Trees have three attributes: value, left, and right.

Value: For the purpose of this exercise, value should be an integer, however in it's totality value can be element of a partially ordered set.

Left: The left attribute should either be nil, or another Binary Tree who's value is less than the value of the binary tree.

Right: the right, much like the left attribute should either be nil, or another Binary Tree who's value is greater than or equal to the value of the binary tree.

To get started, we'll need an `initialize` method that takes in a value and sets the `value` attribute to the passed in value. Additionally, it should set the `left` and `right` attributes to be nil.

Next, you'll have to implement an insert method that takes in a number and inserts the number to the appropriate place in the binary tree.

Here is some starter code:

```rb
class BinTree

  def initialize
  end

  def insert
  end
end
```

## Part 2: Implement the instance methods `max` and `min` (20 Minutes)
For this exercise you'll need to implement that `#max` and `#min` instance methods that.

Max: the `max` method should find the largest value in the in the binary tree.

Min: the `min` method should find the smallest value in the in the binary tree.

Here's some starter code:

```rb
class BinTree

  ...

  def max
  end

  def min
  end
end
```

## Part 3: Implement the `#height` method (30 Minutes)
For this exercise you'll need to implement a method that returns the height of a binary tree. The height of a tree is defined as the largest, postive integer valued depth in the tree.

Consider the following examples

Ex1
```rb
# This binary tree has a height of 1
bin = BinTree.new(10)
```
Ex2
```rb
# This binary tree has a height of 2
bin = BinTree.new(10)
bin.insert(1)
```
Ex3
```rb
# Similarly this binary tree has a height of 2
bin = BinTree.new(10)
bin.insert(1)
bin.insert(100)
```
Ex4
```rb
# This binary tree has a height of 3
bin = BinTree.new(10)
bin.insert(100)
bin.insert(1000)
```

Here is some starter code:

```rb
class BinTree

  ...

  def height
  end
end
```

## Part 4: Implement the the class method that `from_a` and the instance method `#to_a`. (30-45 Minutes)

`.from_a` is a class method that takes in an array on integers and turns the array into a binary tree.

For example:

```rb
bin = BinTree.from_a([1,2,3])
bin.value # => 2
bin.left.value # => 1
bin.right.value # => 3
```

`#to_a` is a method takes go no parameters and returns an array representation of the binary tree.

For example:

```rb
bin = BinTree.new(2)
bin.insert(1)
bin.insert(3)
bin.to_a # => [1,2,3]
```

Here's some starter code
```rb
class BinTree

  ...

  def self.from_a(arr)
  end

  def to_a
  end
end
```


