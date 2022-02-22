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
end