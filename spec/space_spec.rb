require_relative '../lib/space'

describe Space do
  describe '.create' do
    it "adds new space to the spaces table" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      expect(space.name).to eq 'house'
      expect(space.description).to eq 'fancy house'
      expect(space.user_id).to eq user.id
    end
  end

  describe '.all' do
    it "returns an array of spaces from the database" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
    space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/25', end_date: '2023/02/27', user_id: user.id)
    Space.create(name: 'cottage', description: 'cosy getaway', price: '200', start_date: '2022/02/27', end_date: '2023/03/05', user_id: user.id)

      spaces = Space.all

      expect(spaces.length). to eq 2
      expect(space.name).to eq "house"
      expect(space.description).to eq "fancy house"
      expect(space.price).to eq "100"
      expect(spaces.last.user_id).to eq user.id
    end
  end

 xdescribe '.find_by' do
  it "returns an array of spaces within a date range" do
    user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
    space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/01/25', end_date: '2022/01/27', user_id: user.id)
    Space.create(name: 'cottage', description: 'cosy getaway', price: '200', start_date: '2022/02/27', end_date: '2023/03/05', user_id: user.id)
    spaces = Space.find_by(available_from: '2020-01-01', available_to: '2024-01-30')
  
    expect(spaces.length). to eq 1
    expect(space.name).to eq "house"
    expect(space.description).to eq "fancy house"
    expect(space.price).to eq "100"
  end
 end

  describe '.request' do
    it 'changes the column requested of a specific space from false to true' do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      user_two = User.create(username: 'charlotte', email: 'charlotte@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      Space.request(id: space.id, requested_by_id: user_two.id)
      updated_space = Space.find(id: space.id)
      expect(updated_space.requested).to eq 't'
    end
  end

describe '.requests_made' do
  it 'returns an array of spaces that have been reuqested' do
    user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
    user_two = User.create(username: 'charlotte', email: 'charlotte@me.com', password: '12345')
    space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
    Space.create(name: 'cottage', description: 'cosy getaway', price: '200', start_date: '2022/02/27', end_date: '2023/03/05', user_id: user.id)
      Space.request(id: space.id, requested_by_id: user_two.id)
      spaces = Space.requests_made(requested_by_id: user_two.id)
      expect(spaces.length).to eq 1
  end 
end

  describe '.confirm_request' do
    it 'changes the column of a space confirmed from false to true' do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      user_two = User.create(username: 'charlotte', email: 'charlotte@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      Space.request(id: space.id, requested_by_id: user_two.id)
      Space.confirm_request(id: space.id)
      updated_space = Space.find(id: space.id)
      expect(updated_space.confirmed).to eq 't'
    end
  end

  describe '.find' do
    it "returns a instance of a space that is saved in the database" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      space_found = Space.find(id: space.id)
      expect(space_found.name).to eq 'house'
    end
  end
end


