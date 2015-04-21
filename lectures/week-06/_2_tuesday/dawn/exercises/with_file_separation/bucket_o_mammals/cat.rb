# bucket_o_mammals/cat.rb

require_relative "mammal"

class Cat < Mammal

	def initialize(breed,color,weight,length,place_of_origin)
		super(4,true,"kitty",weight,length,place_of_origin)
		@breed = breed
		@color = color
	end

	def meow
		make_noise("Meow")
	end

end