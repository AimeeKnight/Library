class User
	attr_accessor :name, :num_books_checked_out, :status, :books_checked_out

	def initialize name
		@name = name
		@num_books_checked_out = 0
		@books_checked_out = []
		@status = "clear"
	end

end