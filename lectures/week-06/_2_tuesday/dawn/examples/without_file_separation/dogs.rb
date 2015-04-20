# dogs.rb

# Require pry so we can open a REPL when done
require "pry"

=begin
Description:
In this example, we first define a "Dog" class, and then we define "Lab", which represents a particular kind of Dog.

Some food for thought: If to_s is a method on Ruby's BasicObject class (the highest level class in ruby), then why might we want to override it in our own classes? Why might we not want to override it? Feel free to look this up!
=end

# First we define the dog class
class Dog  
  def initialize(breed)  
    @breed = breed  
  end  

  def to_s  
    "(#@breed)"  
  end  
end  

# Then we define a Lab class that inherits from dog.
class Lab < Dog  
  def initialize(breed, name)  
    # give the dog a breed efficiently
    @name = name  
  end  
end  

puts Lab.new("Labrador", "Ben").to_s 

binding.pry
