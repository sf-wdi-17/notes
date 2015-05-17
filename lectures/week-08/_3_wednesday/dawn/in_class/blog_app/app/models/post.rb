class Post < ActiveRecord::Base
	validates :title, presence: true

	def add
		1 + 1
	end
end
