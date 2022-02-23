class Space
  attr_reader :name, :description, :price, :start_date, :end_date, :user_id, :id, :requested, :confirmed


  def initialize(id:, name:, description:, price:, start_date:, end_date:, user_id:, requested:, confirmed:)
  @id = id
  @name = name
  @description = description
  @price = price
  @start_date = start_date
  @end_date = end_date
  @user_id = user_id
  @requested = requested
  @confirmed = confirmed
  end

  def self.create(name:, description:, price:, start_date:, end_date:, user_id:)
  if ENV['ENVIRONMENT'] == 'test'
    connection = PG.connect(dbname: 'makersbnb_manager_test')
  else
    connection = PG.connect(dbname: 'makersbnb_manager')
  end
  
  result = connection.exec("INSERT INTO spaces(name, description, price, start_date, end_date, user_id) 
           VALUES('#{name}', '#{description}', '#{price}', '#{start_date}', '#{end_date}', '#{user_id}')
            RETURNING id, name, description, price, start_date, end_date, user_id, requested, confirmed;").first
   Space.new(id: result['id'], name: result['name'], description: result['description'], price: result['price'],
    start_date: result['start_date'], end_date: result['end_date'], user_id: result['user_id'], requested: result['requested'], confirmed: result['confirmed'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    result = connection.exec("SELECT * FROM spaces WHERE confirmed = false")
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'],
        start_date: space['start_date'], end_date: space['end_date'], user_id: space['user_id'], requested: space['requested'], confirmed: space['confirmed'])
    end
  end

  def self.find_by(available_from:, available_to:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    result = connection.exec("SELECT * FROM spaces
      WHERE start_date >= '#{available_from}' 
      AND end_date < '#{available_to}'
      AND confirmed = false")
      result.map do |space|
        Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'],
          start_date: space['start_date'], end_date: space['end_date'], user_id: space['user_id'], requested: space['requested'], confirmed: space['confirmed'])
      end
  end

  def self.request(id:, requested_by_id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    connection.exec("UPDATE spaces SET requested = TRUE, requested_by_id = '#{requested_by_id}'
    WHERE id = '#{id}'")
  end


def self.requests_made(requested_by_id:)
  if ENV['ENVIRONMENT'] == 'test'
    connection = PG.connect(dbname: 'makersbnb_manager_test')
  else
    connection = PG.connect(dbname: 'makersbnb_manager')
  end
  result = connection.exec("SELECT * FROM spaces WHERE requested_by_id = '#{requested_by_id}' and requested = TRUE")
  result.map do |space|
  Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'],
    start_date: space['start_date'], end_date: space['end_date'], user_id: space['user_id'], requested: space['requested'], confirmed: space['confirmed'])
  end
end

def self.requests_to_confirm(user_id:)
  if ENV['ENVIRONMENT'] == 'test'
    connection = PG.connect(dbname: 'makersbnb_manager_test')
  else
    connection = PG.connect(dbname: 'makersbnb_manager')
  end
result = connection.exec("SELECT * FROM spaces WHERE user_id = '#{user_id}' and requested = true and confirmed = false")
result.map do |space|
  Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'],
    start_date: space['start_date'], end_date: space['end_date'], user_id: space['user_id'], requested: space['requested'], confirmed: space['confirmed'])
    end
  end

  def self.confirm_request(id:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    connection.exec("UPDATE spaces SET confirmed = TRUE WHERE id = '#{id}'")
  end
end

