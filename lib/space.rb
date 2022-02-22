class Space
  attr_reader :name, :description, :price, :start_date, :end_date, :user_id, :id


  def initialize(id:, name:, description:, price:, start_date:, end_date:, user_id:)
  @id = id
  @name = name
  @description = description
  @price = price
  @start_date = start_date
  @end_date = end_date
  @user_id = user_id
  end

  def self.create(name:, description:, price:, start_date:, end_date:, user_id:)
  if ENV['ENVIRONMENT'] == 'test'
    connection = PG.connect(dbname: 'makersbnb_manager_test')
  else
    connection = PG.connect(dbname: 'makersbnb_manager')
  end
  
  result = connection.exec("INSERT INTO spaces(name, description, price, start_date, end_date, user_id) 
           VALUES('#{name}', '#{description}', '#{price}', '#{start_date}', '#{end_date}', '#{user_id}')
            RETURNING id, name, description, price, start_date, end_date, user_id;").first
   Space.new(id: result['id'], name: result['name'], description: result['description'], price: result['price'], start_date: result['start_date'], end_date: result['end_date'], user_id: result['user_id'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_manager_test')
    else
      connection = PG.connect(dbname: 'makersbnb_manager')
    end
    result = connection.exec("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'], start_date: space['start_date'], end_date: space['end_date'], user_id: space['user_id'])
    end
  end
end