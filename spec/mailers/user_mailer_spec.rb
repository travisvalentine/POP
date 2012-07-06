describe UserMailer do
  describe "password_reset" do
    let!(:user) { FactoryGirl.create(:user, :password_reset_token => "anything") }
    let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }
    let!(:mail) { UserMailer.password_reset(user) }

    it "send user password reset url" do
      mail.subject.should == "Check yourself and reset yourself"
      mail.to.should == [user.email]
      mail.from.should == ["hungryopensource@gmail.com"]
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end
end