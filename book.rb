class Book
	#a symbol is a special class in ruby that is used to define a constant named label
	attr_accessor :title, :author, :description, :status, :statuses, :checked_out_date, 
								:due_date, :checked_out_by, :reserved_by, :rating, :review, 
								:year_published, :edition

	def initialize title, author, description, year_published = nil, edition = nil 
		@title = title
		@author = author
		@description = description
		@statuses = ["available", "checked out", "overdue", "lost"]
		@status = @statuses[0]
		@checked_out_date = 0
		@due_date = 0
		@checked_out_by
		@reserved_by = []
		@rating
		@review
		@year_published
		@edition
	end

end