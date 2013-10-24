class Book
	#a symbol is a special class in ruby that is used to define a constant named label
	attr_accessor :title, :author, :description, :status, :date_checked_out, :due_date, :checked_out_by

	def initialize title, author, description, available = true
		@title = title
		@author = author
		@description = description
		@status = "available"
		@date_checked_out
		@due_date
		@checked_out_by
	end

end