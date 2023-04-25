require 'books_repository'

describe BooksRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_bookstore.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'bookstore_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  it 'Should' do
    repo = BooksRepository.new
    list = repo.all
    expect(list.length).to eq 4
    expect(list.last.title).to eq 'Alice in Wonderland'
    expect(list.first.author_name).to eq 'Hunter.S Thompson'
    expect(list.first.id).to eq "1"
  end
end