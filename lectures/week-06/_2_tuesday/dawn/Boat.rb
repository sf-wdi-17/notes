load './MotorVehicle.rb'

class Boat < MotorVehicle
    attr_accessor :draft, :max_weight, :call_sign, :engine_type, :propulsion_type, :sails, :propellers, :angle_propeller

    def initialize(length, width, height, mass, draft, max_weight, call_sign, engine_type, propulsion_type, sails, propellers, angle_propeller)
        super("Boat", length, width, height, mass)

        @draft = draft
        @max_weight = max_weight
        @call_sign = call_sign
        @engine_type = engine_type
        @propulsion_type = propulsion_type
        @sails = sails
        @propellers = propellers
        @angle_propeller = angle_propeller
        @rlsail = 0
        @rlpropeller = 0
        @towcap = 0
        @rudder = 0
        @radio = 0
    end

    def float(level)
        @float += level        
    end

    def tow(cap)
        @towcap += cap    
    end

    def cb_radio(channel)
        @radio += channel
    end

    def turn_rudder(position)
        @rudder += position
    end

    def raise_lower_sail(height)
        @rlsail += height 
    end

    def raise_lower_propeller(angel)
        @rlpropeller += angel 
    end
end