require 'spec_helper'

describe User do
  let(:user)        { FactoryGirl.create(:user) }
  let(:profile)     { FactoryGirl.create(:profile, :user_id => user.id) }

  let(:auth)        { TwitterOauthHash.default }

  let(:user2)       { FactoryGirl.create(:user, :email => "test@testing.com") }
  let(:update_auth) { TwitterOauthHash.updated_auth }

  before {
    user
    profile
    auth
  }

  describe ".create_from_auth(auth)" do
    it "creates a user from the auth hash" do
      user = User.create_with_omniauth(auth)
      user.provider.should == "twitter"
      user.uid.should == "31983"
    end
  end

  describe "#update_from_omniauth(auth)" do
    before {
      user2
      update_auth
    }

    it "updates the user's auth tokens from the auth hash" do
      user2.update_from_omniauth(update_auth)
      user2.oauth_token.should == "53190u09u31"
      user2.oauth_secret.should == "zjiwoj1830420ojdfalj13"
    end
  end

  describe "#send_password_reset" do

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end

  describe "#age" do
    it "calculates a user's age" do
      pending
    end
  end

  describe "#legal" do
    it "returns false if less than 13" do
      pending
    end
  end


end