# main.rb
# This file requires all files in this directory, and then starts a pry REPL
# so you can play with these classes

require "pry"

# This statement includes all files before we start pry
Dir["*.rb"].each do |file|
	require_relative file
end


binding.pry