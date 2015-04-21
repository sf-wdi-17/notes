# animals.rb

# Require pry so we can open a REPL when done
require "pry"

class Animal
  attr_accessor :kind
  def initialize(kind)
    @kind = kind
    @state = "awake"
  end

  def eat(food)
    if @state == "awake"
      puts "NOM-nom!!"
      puts "(#{@kind} has eaten #{food})"
    else
      puts "SLEEPING"
    end
    self
  end
  
  def sleep
    @state = "sleeping"
  end
  
  def wake
    @state = "awake"
  end
end

# In this example, we've included the inherited class "Person" here in this same file.
class Person < Animal

    def initialize(age, gender, name)
        # call the super initialize
        super("person")
        @age = age
        @gender = gender
        @name = name
    end

end
