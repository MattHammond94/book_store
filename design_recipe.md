# Book Store Model and Repository Classes Design Recipe

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

TRUNCATE TABLE books RESTART IDENTITY;

INSERT INTO books(title, author_name) VALUES('Fear and Loathing in Las Vegas', 'Hunter.S Thompson');
INSERT INTO books(title, author_name) VALUES('Lord of the Rings', 'J.R. Tolkein');
INSERT INTO books(title, author_name) VALUES('The Demon Haunted World', 'Carl Sagan');
INSERT INTO books(title, author_name) VALUES('Alice in Wonderland', 'Lewis Carrol');


psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: books

# Model class
# (in lib/books.rb)

class books
  
end

# Repository class
# (in lib/book_repository.rb)
class BookRepository
end


## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.
``` ruby
# EXAMPLE
# Table name: books

# Model class
# (in lib/books.rb)

class Books

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_name
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# book = Book.new
# book.name = 'LOTR'
# book.name

# You may choose to test-drive this class, 
# but unless it contains any more logic than the example above, it is probably not needed.

```

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: books

# Repository class
# (in lib/books_repository.rb)

class BooksRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT title, author_name FROM books WHERE id = $1;

    # Returns a single book object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(book)
    
  # end

end
```

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test.
```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.
```ruby
# EXAMPLE

# file: spec/books_repository_spec.rb

 def reset_albums_table
    seed_sql = File.read('')
    connection = PG.connect({ host: '127.0.0.1', dbname: '' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_albums_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour
_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._