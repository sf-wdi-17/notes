load './MotorVehicle.rb'

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
