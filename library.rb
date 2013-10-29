class Library
	attr_accessor :books

	def initialize lib_file = false
		@lib_file = lib_file
		@books = []

		if @lib_file
			File.open(@lib_file).each_line do |line|
				fields = line.split(',')
					@books << Book.new(fields[0].strip.to_s, fields[1].strip.to_s, fields[2].strip.to_s)
			end
		end
	end

	def add_book title, author, description
		@books << Book.new(title, author, description)
	end

	def get_book title
		@books.find { |book| book.title == title }
	end

	def checkout_book user, title
		book = get_book title
		if book.status == book.statuses[0] && (book.reserved_by[0] == user || book.reserved_by.size == 0)
			if user.num_books_checked_out >= 2
				puts "You have #{user.num_books_checked_out} books checkout. You may not checkout more than 2 at a time."
			elsif user_has_overdue_books user
				puts "You have overdue books."
			else
				book.status = book.statuses[1]
				book.checked_out_date = Time.new
				book.due_date = book.checked_out_date + (7*24+60*60)
				#due_date_str = book.due_date.strftime("%m/%d/%y")
				book.checked_out_by = user
				user.num_books_checked_out += 1
				user.books_checked_out << book
				puts "#{user.name}, you've checked out the book titled #{book.title}."
			end
		end
	end

	def return_book user, title
		book = get_book title
		book.status = book.statuses[0]
		book.checked_out_date = 0
		book.due_date = 0
		book.checked_out_by = nil
		user.num_books_checked_out -= 1
		user.books_checked_out.delete book
		puts "#{user.name}, Thanks for returning the book titled #{book.title}."
	end

	def user_has_overdue_books user
		if user.books_checked_out.size > 0
			user.books_checked_out.each do |book|
				current = Time.new
				if book.due_date < current && book.checked_out_by === user 
					user.status = user.statuses[1]
					puts "#{user.name}, the book titled '#{book.title}' is overdue"
				else
					puts "#{user.name}, you don't have any overdue books"	
					false
				end
			end
		end
	end

	def overdue_books
		books_with_due_dates = @books.select { |book| book.due_date != 0}
		if books_with_due_dates.size != 0
			current = Time.new
			overdue_books = books_with_due_dates.select { |book| book.due_date < current.to_i }
			puts "#{overdue_books}"
		else
			puts "There are no overdue books"
		end
	end

	def who_has_what
		checked_out_books = @books.select {|book| book.checked_out_by != nil && book.due_date != 0	}
		if checked_out_books.size != 0
			checked_out_books.each do |book|
				puts "#{book.title} is checked out by #{book.checked_out_by}"
				puts "#{book.title} is due #{book.due_date}"
			end
		else
			puts "There are no books currently checked out"
		end
	end

	def schedule_checkout user, title
		book = get_book title
		if book.status != book.statuses[0]
			book.reserved_by << user
		else
			puts "#{book.title} isn't checked out and can be reserved now."
		end
	end

	def extension user, title
		book = get_book title
		if book.checked_out_by == user
			book.due_date += (7*24+60*60)
			due_date_str = book.due_date.strftime("%m/%d/%y")
			puts "The due date for #{book.title} has been extended to #{due_date_str}"
		else
			puts "#{user.name}, you will need to check out #{book.title} before requesting an extension"
		end
	end

end