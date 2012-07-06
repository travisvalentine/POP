require 'spec_helper'

describe ProblemsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }
  let!(:problem) { FactoryGirl.create(:problem) }
  let!(:solution) { FactoryGirl.create(:solution, :problem_id => problem.id) }

  context "as an authenticated user" do
    before(:each) do
      login_as(user)
    end

  end
end