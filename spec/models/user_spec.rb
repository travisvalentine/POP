require 'spec_helper'

describe User do
  let(:user)        { FactoryGirl.create(:user) }
  let(:profile)     { FactoryGirl.create(:profile, :user_id => user.id) }

  let(:auth)        { TwitterOauthHash.default }

  let(:user2)       { FactoryGirl.create(:user, :email => "test@testing.com") }
  let(:profile2)    { FactoryGirl.create(:profile,
                                         :name => "Not Taken",
                                         :user_id => user2.id) }

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
      profile2
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

  describe "#create_politicians_from_address" do
    it "creates politicians from the Sunlight API" do
      response = {:senior_senator => double("sunlight_legislator",
                                            :title      => "Sen",
                                            :firstname  => "John",
                                            :lastname   => "Kerry",
                                            :party      => "D",
                                            :twitter_id => "JohnKerry",
                                            :fec_id     => "S4MA00069"),
                  :junior_senator => double("sunlight_legislator",
                                            :title      => "Sen",
                                            :firstname  => "Scott",
                                            :lastname   => "Brown",
                                            :party      => "R",
                                            :twitter_id => "USSenScottBrown",
                                            :fec_id     => "S0MA00109"),
                  :representative => double("sunlight_legislator",
                                            :title      => "Rep",
                                            :firstname  => "Barney",
                                            :lastname   => "Frank",
                                            :party      => "D",
                                            :twitter_id => "",
                                            :fec_id     => "H0MA04036")}
      address = "550 Chestnut St. Waban, MA 02468"
      Sunlight::Legislator.stub(:all_for).with(:address => address).and_return(response)
      expect{user.create_politicians_from_address(address)}.to change{user.politicians.count}.by(3)
      user.politicians.map(&:short_title).should include("Sen", "Sen", "Rep")
      user.politicians.map(&:first_name).should include("John", "Scott", "Barney")
      user.politicians.map(&:last_name).should include("Kerry", "Brown", "Frank")
      user.politicians.map(&:party).should include("D", "R")
      user.politicians.map(&:twitter).should include("JohnKerry", "USSenScottBrown", "")
      user.politicians.map(&:fec_id).should include("S4MA00069", "S0MA00109", "H0MA04036")
    end

    it "creates a new association but not a new record for existing politicians" do
      response = {:senior_senator => double("sunlight_legislator",
                                            :title      => "Sen",
                                            :firstname  => "John",
                                            :lastname   => "Kerry",
                                            :party      => "D",
                                            :twitter_id => "JohnKerry",
                                            :fec_id     => "S4MA00069"),
                  :junior_senator => double("sunlight_legislator",
                                            :title      => "Sen",
                                            :firstname  => "Scott",
                                            :lastname   => "Brown",
                                            :party      => "R",
                                            :twitter_id => "USSenScottBrown",
                                            :fec_id     => "S0MA00109"),
                  :representative => double("sunlight_legislator",
                                            :title      => "Rep",
                                            :firstname  => "Barney",
                                            :lastname   => "Frank",
                                            :party      => "D",
                                            :twitter_id => "",
                                            :fec_id     => "H0MA04036")}
      address = "550 Chestnut St. Waban, MA 02468"
      Sunlight::Legislator.stub(:all_for).with(:address => address).and_return(response)
      user.create_politicians_from_address(address)
      expect{user2.create_politicians_from_address(address)}.to_not change{Politician.count}.by(3)
      user2.politicians.count.should == 3
    end
  end


end
