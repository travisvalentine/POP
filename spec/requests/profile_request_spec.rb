require 'spec_helper'

describe "Profile Show" do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { FactoryGirl.create(
                      :profile,
                      :user_id => user.id,
                      :address => "1600 Pennsylvania Ave NW Washington DC 20005")
                }
  let(:problem) { FactoryGirl.create(:problem, :user_id => user.id) }

  context "who is authenticated" do
    use_vcr_cassette

    before(:each) do
      user
      profile
      login_as(user)
      visit profile_path(profile)
    end

    it "has Members of Congress" do
      page.should have_content("Representative: Eleanor Norton (D) @EleanorNorton")
    end
  end

end