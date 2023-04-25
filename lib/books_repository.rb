require_relative './books'

class BooksRepository

  def all
    result = DatabaseConnection.exec_params('SELECT * FROM books;', [])
  
    books = []

    result.each do |item|
      book = Books.new
      book.id = item['id']
      book.title = item['title']
      book.author_name = item['author_name']

      books << book
    end
    books
  end
end