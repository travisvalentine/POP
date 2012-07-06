module UserRequestHelpers
  def login_as(user)
    visit(login_path)
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_link_or_button "Log In"
  end

  def fill_login_form_as(user)
    visit(login_path)
    fill_in "email", :with => user.email
    fill_in "password", :with =>
      FactoryGirl.attributes_for(:user)[:password]
  end

  def fill_signup_form_as(user, profile)
    fill_in "user_profile_attributes_first_name", :with => profile.first_name
    fill_in "user_profile_attributes_last_name", :with => profile.last_name
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with =>
      FactoryGirl.attributes_for(:user)[:password]
    fill_in "user_profile_attributes_bio", :with => profile.bio
    select("January", :from => "user_profile_attributes_birthday_2i")
    select("1", :from => "user_profile_attributes_birthday_3i")
    select("1990", :from => "user_profile_attributes_birthday_1i")
    select("Independent", :from => "user_profile_attributes_party_affiliation")
  end

  def fill_password_change_form_for(user)
    fill_in "Password", :with =>
      FactoryGirl.attributes_for(:user)[:password]
    fill_in "Password confirmation", :with =>
      FactoryGirl.attributes_for(:user)[:password]
  end

  def logout
    visit logout_path
  end
end
