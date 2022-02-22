def login
    visit '/'
    fill_in('username', with: "eddiearnold")
    fill_in('password', with: "12345")
    fill_in('password confirmation', with: "12345")
    fill_in('email', with: "eddie@me.com")
    click_button 'Submit'
  end

  def add_space
    # visit '/spaces/new'
    fill_in('name', with: "house")
    fill_in('description', with: 'fancy home')
    fill_in('price', with: '100')
    fill_in('start_date', with: '2022-02-22')
    fill_in('end_date', with: '2023-02-27')
    click_button 'list my space'
end

def add_space_2
  # visit '/spaces/new'
  fill_in('name', with: "house2")
  fill_in('description', with: 'fancy home2')
  fill_in('price', with: '100')
  fill_in('start_date', with: '2022-02-22')
  fill_in('end_date', with: '2023-02-27')
  click_button 'list my space'
end