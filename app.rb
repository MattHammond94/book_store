require_relative 'lib/database_connection'
require_relative 'lib/books_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM books;'
# result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .

# repo = BooksRepository.new

# repo.all.each do |record|
#   p "#{record.id} - #{record.title} - #{record.author_name}"
# end

books = BooksRepository.new
book = books.find(4)
puts book.title