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

  describe '.request' do
    it 'changes the column requested of a specific space from false to true' do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      new_space = Space.request(id: space.id)
      expect(new_space.request).to eq true
    end
  end

  describe '.confirm_request' do
    it 'changes the column of a space confirmed from false to true' do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      user_two = User.create(username: 'charlotte', email: 'charlotte@me.com', password: '12345')
      space = Space.create(name: 'house', description: 'fancy house', price: '100', start_date: '2022/02/22', end_date: '2023/02/27', user_id: user.id)
      Space.request(id: space.id, requested_by_id: user_two.id)
      Space.confirm_request(id: space.id)
      new_space = Space.find(id: space.id)
      expect(new_space.confirmed).to eq 't'
    end
  end
end


