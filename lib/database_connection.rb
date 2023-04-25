require 'pg'

# This whole class' role is to use PG to interact with our chosen DB using SQL

class DatabaseConnection
  
  # The database name is taken as an argument - host is always the root ip as below 
  # This method connects to our chosen database using PG ruby gem 

  def self.connect(database_name)
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name }) 
  end

  # This method executes an SQL query (that is taken as an arg)
  # on the database, providing some optional parameters
  # If there is no database name given as an argument it raises an error
  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end