require 'spec_helper'

describe UserMailer do
  let(:user)        { FactoryGirl.create(:user, :password_reset_token => "anything") }
  let(:profile)     { FactoryGirl.create(:profile, :user_id => user.id) }

  let(:mail) { UserMailer.password_reset(user) }

  before {
    user
    profile
    mail
  }

  describe "password_reset" do
    it "send user password reset url" do
      mail.subject.should == "Check yourself and reset yourself"
      mail.to.should == [user.email]
      mail.from.should == ["oursolutionis@gmail.com"]
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end
end