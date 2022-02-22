require 'pg'

def setup_test_database

  p "Setting up test database..."

  connection = PG.connect(dbname: 'makersbnb_manager_test')

  # Clear the chitter table
  connection.exec("TRUNCATE users, spaces;")

end