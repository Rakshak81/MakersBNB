feature 'homepage' do
  scenario 'we see makersbnb on front page' do
    visit ('/')
    expect(page).to have_content "Welcome to Makers BNB"
  end
end