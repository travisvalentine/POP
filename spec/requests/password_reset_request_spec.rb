require 'spec_helper'

describe "Password Reset" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }

  context "when a user tries to reset their password" do
    before(:each) do
      visit login_path
    end

    it "they see a forgot password link" do
      page.should have_link "Forgot your password?"
    end

    it "can fill in their email to receive a password reset" do
      click_link 'Forgot your password?'
      fill_in 'email', :with => user.email
      click_button 'Reset Password'
      page.should have_content "Check your email for password reset instructions."
    end

    it "raises record not found when password token is invalid" do
      lambda {
        visit edit_password_reset_path("invalid")
      }.should raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  context "when a user updates their password" do
    it "changes their password and logs them in when password matches confirmation" do
      user.send_password_reset
      visit edit_password_reset_path(user.password_reset_token)
      fill_in 'user_password', :with => "123abc"
      click_button 'Reset Password'
      page.should have_content("Password doesn't match confirmation")
      fill_in 'user_password', :with => "123abc"
      fill_in 'user_password_confirmation', :with => "123abc"
      click_button 'Reset Password'
      current_path.should == profile_path(user.profile)
      page.should have_content "#{user.name}"
    end
  end
end