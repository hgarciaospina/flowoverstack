module LoginMacros
  def login(user)
    visit root_path
    click_link 'Ingresar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Ingresar'
  end
end