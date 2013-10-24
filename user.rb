class User
	attr_accessor :name, :num_books_checked_out, :statuses, :status, :books_checked_out

	def initialize name
		@name = name
		@num_books_checked_out = 0
		@books_checked_out = []
		@statuses = ["clear", "books_overdue"]
		@status = @statuses[0]
	end

end