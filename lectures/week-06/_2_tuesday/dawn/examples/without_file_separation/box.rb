# box.rb

# Require pry so we can open a REPL when done
require "pry"

# First we define a class "box"
class Box
  attr_accessor :width, :height

  def initialize(w, h)
    @width = w 
    @height = h
  end

  def get_area
    @width * @height
  end

end

class BigBox < Box
  attr_accessor :area

  def initialize(w,h,c)
    super(w,h)
    @area = get_area
    @color = c
  end

  def print_area
    puts @area
  end

  def get_area
    # Note that we can use "super" in any method to call its parent's method
    super
    puts "I'm a big box"
  end
end

require 'pry'
binding.pry