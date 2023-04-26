require 'books_repository'

describe BooksRepository do

  def reset_books_table
    seed_sql = File.read('spec/seeds_bookstore.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bookstore_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  it 'Should return the correct value for individual method calls after data has been tranfserred from DB' do
    repo = BooksRepository.new
    list = repo.all
    expect(list.length).to eq 4
    expect(list.last.title).to eq 'Alice in Wonderland'
    expect(list.first.author_name).to eq 'Hunter.S Thompson'
    expect(list.first.id).to eq "1"
  end
end

describe BooksRepository do
  def reset_books_table
    seed_sql = File.read('spec/seeds_bookstore.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bookstore_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_books_table
  end

  it 'Should return the title and author of book at id given to find as argument' do
    repo = BooksRepository.new
    book = repo.find(1)
    expect(book.title).to eq 'Fear and Loathing in Las Vegas'
  end
end

describe BooksRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_empty.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bookstore_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end
  
  it 'Should return an empty array when DB is empty' do
    repo = BooksRepository.new
    expect(repo.all).to eq []
  end
end