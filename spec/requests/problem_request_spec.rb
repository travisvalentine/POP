require 'spec_helper'

describe Problem do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }
  let!(:problem) { FactoryGirl.create(:problem, :user_id => user.id) }
  let!(:solution) { FactoryGirl.create(:solution, :problem_id => problem.id, :user_id => user.id) }

  context "as an authenticated user" do
    before(:each) do
      login_as(user)
    end

    it "shows the problem title and it's solution" do
      visit problem_path(problem)
      page.should have_content problem.body
      page.should have_content solution.body
    end

  end
end