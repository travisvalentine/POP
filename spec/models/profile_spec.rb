require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }

  let(:auth)    { TwitterOauthHash.default }

  before {
    user
    profile
    auth
  }

  describe ".create_with_omniauth(user_id, auth)" do
    it "creates a Profile from the auth hash and assigns it to the User" do
      pending
      profile = Profile.create_with_omniauth(user.id, auth)
      profile.user_id.should  == user.id
      profile.image.should    == "http://a0.twimg.com/profile_images/131me.jpg"
      profile.location.should == "Washington, DC"
      profile.name.should     == "A User"
      profile.bio.should      == "This is my bio"
      profile.twitter.should  == "user"
    end
  end

end
