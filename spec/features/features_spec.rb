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
end