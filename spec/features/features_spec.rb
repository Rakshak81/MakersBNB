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
    expect(page).to have_current_path '/spaces'
  end

  scenario 'An already signed up user logs in' do
    visit '/'
    click_button 'login'
    # expect(page).to have_current_path '/sessions/new'
    fill_in('username', with: "eddiearnold")
    fill_in('password', with: "12345")
    click_button 'Submit'
    expect(page).to have_current_path '/spaces'

  end
end