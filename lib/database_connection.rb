require 'pg'

class DatabaseConnection
 
  #Trying for heroku
  def self.connect
    # If the environment variable (set by Heroku)
  # is present, use this to open the connection.
    if ENV['DATABASE_URL'] != nil
      @connection = PG.connect(ENV['DATABASE_URL'])
      return
    elsif ENV['ENV'] == 'test'
      database_name = 'chitter_test'
     else
       database_name = 'chitter'
     end
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name, user: 'jean', password: 'test123' })
  end

  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end