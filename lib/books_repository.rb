require_relative './books'

class BooksRepository

  def find(id)
    sql = 'SELECT title, author_name FROM books WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    item = result[0]

    book = Books.new
    book.title = item['title']
    book.author_name = item['author_name']
    return book
  end

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