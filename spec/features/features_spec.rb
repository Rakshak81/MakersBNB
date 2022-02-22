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
    expect(page).to have_selector(:link_or_button, 'Submit')
  end

  scenario 'users signs up and is directed to spaces' do
    visit '/'
    fill_in('username', with: "eddiearnold")
    fill_in('password', with: "12345")
    fill_in('password confirmation', with: "12345")
    fill_in('email', with: "eddie@me.com")
    click_button 'Submit'
    expect(page).to have_current_path '/spaces/index'
  end

  scenario 'An already signed up user logs in' do
    visit '/'
    click_button 'login'
    # expect(page).to have_current_path '/sessions/new'
    fill_in('username', with: "eddiearnold")
    fill_in('password', with: "12345")
    click_button 'Submit'
    expect(page).to have_current_path '/spaces/index'

  end
end

feature 'spaces' do
  scenario 'visit spaces page' do
    visit '/spaces/index'
    # expect(page).to have_content "sunny camping site"
    # expect(page).to have_content "a sunny field to spend your holiday"
    expect(page).to have_selector(:link_or_button, 'sign out')
    expect(page).to have_selector(:link_or_button, 'list a space')
    expect(page).to have_selector(:link_or_button, 'list available spaces')
    expect(page).to have_field 'available from'
    expect(page).to have_field 'available to'

  end
end
feature 'list a space' do
  scenario 'a user a space to the spaces table' do 
    visit '/spaces/new'
    fill_in('name', with: "house")
    fill_in('description', with: 'fancy home')
    fill_in('price', with: '100')
    fill_in('start_date', with: '2022-02-22')
    fill_in('end_date', with: '2023-02-27')
    click_button 'list my space'
    expect(page).to have_current_path '/spaces/new'
    expect(page).to have_content "house"
    expect(page).to have_content 'fancy home'

  end
end