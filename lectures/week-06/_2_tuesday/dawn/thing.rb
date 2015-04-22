require 'pry'

def each(arr)
	i = 0
	while i < arr.length
		yield(arr[i])
		i += 1
	end
end

binding.pry