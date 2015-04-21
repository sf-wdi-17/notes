# bucket_o_mammals/dog.rb

require_relative "mammal"

class Dog < Mammal

	def initialize(breed,color,weight,length,place_of_origin)
		super(4,true,"k9",weight,length,place_of_origin)
		@breed = breed
		@color = color
	end

	def bark
		make_noise("Bark")
		self
	end

	def whimper
		make_noise("whimper")
		self
	end
end