# bucket_o_mammals/mammal.rb

require "pry"

class Mammal

	def initialize(num_legs,has_hair,species,weight,length,place_of_origin)
		@num_legs = num_legs
		@has_hair = has_hair
		@species = species
		@weight = weight
		@length = length
		@place_of_origin = place_of_origin
	end

	def kill
		puts "Kill!!!!"
		self
	end

	def make_noise(noise)
		puts noise
		self
	end

	def reproduce
		puts "reproduce"
		self
	end

	def move
		puts "moving"
		self
	end

end


binding.pry # Starts up a pry REPL so you can play with this class
