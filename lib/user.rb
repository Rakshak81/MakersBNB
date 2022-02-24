require 'pg'

class User

attr_reader :id, :username, :email, :password

  def initialize(id:, username:, email:, password:)
    @id = id
    @username = username
    @email = email
    @password = password
  end

  def self.identify(username:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    result = connection.exec(
      "SELECT * FROM users WHERE username='#{username}' AND password='#{password}';").first
      if result
      User.new(id: result['id'], username: result['username'], email: result['email'], password: result['password'])
      else nil
      end
  end

  def self.create(username:, email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    
    result = connection.exec_params(
      "INSERT INTO users (username, email, password)
    VALUES($1, $2, $3) RETURNING id, username, email, password;", [username, email, password]).first
      User.new(id: result['id'], username: result['username'], email: result['email'], password: result['password'])
  end

  
end