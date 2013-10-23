class User
	attr_accessor :name, :num_books_checked_out

	def initialize name
		@name = name
		@num_books_checked_out = 0
	end

end