require_relative '../lib/user'

describe User do
  describe ".create" do
    it "creates a new user" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')

      expect(user).to be_a User
      expect(user.username).to eq 'eddiearnold'
    end
  end

  describe ".identify" do
    it "checks the database for the user with the specified username and password" do
      user = User.create(username: 'eddiearnold', email: 'eddiearnold@me.com', password: '12345')
      identified_user = User.identify(username: user.username, password: user.password)
      expect(identified_user.username).to eq 'eddiearnold'
      expect(identified_user.id).to eq user.id
      expect(identified_user.password).to eq '12345'
    end
  end
end

