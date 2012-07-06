require 'spec_helper'

describe SessionsController do
  let!(:user)     { FactoryGirl.create(:user) }
  let!(:profile)  { FactoryGirl.create(:profile, :user_id => user.id) }

  describe "'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "'create'" do
    it "returns http success" do
      pending
    end
  end


end