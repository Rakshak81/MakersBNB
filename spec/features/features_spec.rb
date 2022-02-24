require_relative 'web_helpers'

feature 'homepage' do
  scenario 'we see makersbnb on front page' do
    visit ('/')
    expect(page).to have_content "Welcome to Makers BNB"
  end

  scenario 'Enable User to Sign-Up' do
    visit '/'
    expect(page).to have_field "email"
    expect(page).to have_field "password"
    expect(page).to have_field "password confirmation"
    expect(page).to have_field "username"
    expect(page).to have_selector(:link_or_button, 'Sign-up')
  end

  scenario 'users signs up and is directed to spaces' do
    visit '/'
    login
    expect(page).to have_current_path '/spaces/index'
  end

  xscenario 'An already signed up user logs in' do
    visit '/'
    click_button 'Login'
    # expect(page).to have_current_path '/sessions/new'
    fill_in('username', with: "eddiearnold")
    fill_in('password', with: "12345")
    find_button('login').click
    expect(page).to have_current_path '/spaces/index'

  end
end

feature 'spaces' do
  scenario 'visit spaces page' do
    visit '/spaces/index'
    # expect(page).to have_content "sunny camping site"
    # expect(page).to have_content "a sunny field to spend your holiday"
    expect(page).to have_selector(:link_or_button, 'Sign-out')
    expect(page).to have_selector(:link_or_button, 'List a space')
    expect(page).to have_selector(:link_or_button, 'List available spaces')
    expect(page).to have_field 'available from'
    expect(page).to have_field 'available to'

  end
end
feature 'list a space' do
  scenario 'a user adds a space to the spaces table' do 
    login
    click_link('List a space', href: 'http://localhost:9292/spaces/new')
    add_space
    expect(page).to have_current_path '/spaces/new'
    expect(page).to have_content "house"
    expect(page).to have_content 'fancy home'
  end
end

  feature 'view a list of spaces' do
    scenario 'a user views the list of available spaces' do
    login
    click_link('List a space', href: 'http://localhost:9292/spaces/new')
    add_space
    # click_link('list a space', href: 'http://localhost:9292/spaces/new')
    # add_space_2
   expect(page).to have_content 'house'
  #  expect(page).to have_content 'house2'
  end
end

  xfeature 'request a space' do
    scenario 'user clicks on button to request a space and this notified the host_user' do
      login
      click_link('list a space', href: 'http://localhost:9292/spaces/new')
      add_space
      click_button 'Request Space'
      expect(page).to have_content 'Space requested'
    end
  end
      
