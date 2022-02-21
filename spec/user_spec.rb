require_relative '../lib/user'

describe User do
  describe ".create" do
    it "creates a new user" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')

      expect(user).to be_a User
      expect(user.username).to eq 'eddiearnold'
    end
  end
end

