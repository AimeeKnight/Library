class Library
	attr_accessor :books

	def initialize lib_file = false
		@lib_file = lib_file
		@books = []

		if @lib_file
			File.open(@lib_file).each_line do |line|
				fields = line.split(',')
					@books << Book.new(fields[0], fields[1], fields[2])
			end
		end
	end

	def add_book book
		@books << book
	end

	def get_book title
		@books.select.first { |book| book.title == title }
	end

	def checkout_book user, book_title
		if user.num_books_checked_out >= 2
			puts "You have #{user.num_books_checked_out} books checkout. You may not checkout more than 2 at a time."
		elsif user_has_overdue_books user
			puts "You have overdue books."
		else
			book = get_book book_title
			book.status = "checkedout"
			book.date_checked_out = Time.new
			book.due_date = book.date_checked_out + (7*24+60*60)
			book.checked_out_by = user
			user.num_books_checked_out += 1
			user.books_checked_out << book
		end
	end

	def return_book user, book_title
		book = get_book book_title
		book.status = "available"
		book.date_checked_out = nil
		book.due_date = nil
		book.checked_out_user = nil
		user.num_books_checked_out -= 1
	end

	def user_has_overdue_books user
		if user.books_checked_out.size > 0
			user.books_checked_out.each do |book|
				current = Time.new
				if book.due_date < current && book.checked_out_by === user 
					user.status = "books overdue"
				end
			end
		end
	end


end