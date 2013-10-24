require_relative 'library'
require_relative 'book'
require_relative 'user'

myLibrary = Library.new('books.csv')
aimee = User.new('Aimee')

# myLibrary.add_book "Bible", "God", "Christian"
# myLibrary.get_book "Bible"
# myLibrary.checkout_book aimee, "Bible"