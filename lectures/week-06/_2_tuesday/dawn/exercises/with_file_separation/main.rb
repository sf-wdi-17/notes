# with_file_separation/main.rb

=begin
Description:

This file reads all of the classes in this directory into ruby using require_relative,
and then uses binding.pry to start a REPL so you can play with them.	
	
=end


require "pry"

# This statement gets all files in current directory
Dir["*"].each do |d|
	unless d == "main.rb" # We don't want to require this file again
		Dir["#{d}/*.rb"].each do |file|
			require_relative "#{d}/file"
		end
	end
end

# Start a pry REPL
binding.pry