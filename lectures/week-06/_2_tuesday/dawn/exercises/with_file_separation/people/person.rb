# people/person.rb

require_relative "animal.rb"

class Person < Animal
    @@banned_foods = /person|people|human|humans|woman|man|girl|lady|boy|guy|children|child|baby|babies|toddlers/i

    attr_accessor :age
    def self.banned_foods
      @@banned_foods
    end
    def initialize(age, gender, name)
        # call the super initialize
        super("person")
        @age = age
        @gender = gender
        @name = name
    end

    # stop cannibalism!
    def eat(food)
      # Question: Why do banned foods have a '@@' before it? What's the diff between '@' and '@@'?
      unless @@banned_foods.match(food)
        super(food)
      else
        puts "(cannibalism is not allowed!!)"
      end
      self
    end
end




