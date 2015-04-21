require 'pry'

class MotorVehicle
	attr_reader :type, :length, :width, :height, :mass

	def initialize(type, length, width, height, mass)
		@type = type
		@length = length
		@width = width
		@height = height
		@mass = mass
		@speed = 0
		@degree = 0 # The direction the vehicle is traveling
		puts "We made a vehicle"
	end

	def accelerate(change)
		@speed += change
		self
	end

	def decelerate(change)
		accelerate(-1 * change)
	end

	def turn(degree)
		@degree = degree
	end
end

mike = MotorVehicle.new("Bike", 10,2,1,2)
#brett = Car.new(12,3,4,5,true,4,"thing",...)

class Car < MotorVehicle
	attr_reader :car_phone, :color, :doors, :engine_type, :transmission

	def initialize(is_convertible, doors, engine_type, transmission, color, make, model, car_phone)
		super("Taco", 1, 2,3,4)
		@is_convertible = is_convertible
		@doors = doors
		@engine_type = engine_type
		@transmission = transmission
		@color = color
		@car_phone = car_phone
		@gear = 0
	end

	def lock_doors
		super
		@doors_locked = true
		self
	end

	def unlock_doors
		@doors_locked = false
		self
	end

	def answer_car_phone
		puts "Sup"
		self
	end

	def change_gears(gear)
		if (gear - @gear > 1)
			puts "GRRREASDFSDG GRID"
		else
			@gear = gear
		end
		self
	end
end



class Foo
	def initialize(foo,bar)
		@foo = foo
		@bar = bar
	end
end

class Zaz < Foo
	attr_reader :foo, :bar

	def self.sizzle
		puts "I'm cool"
	end

	def thing
		puts "I'm also cool"
		self
	end
end

Zaz.sizzle # => I'm cool

snap = Zaz.new("Mike", "Brett")
snap.thing  # => 





















binding.pry