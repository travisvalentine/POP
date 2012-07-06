require 'spec_helper'

describe Solution do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:profile) { FactoryGirl.create(:profile, :user_id => user.id) }
  let!(:problem) { FactoryGirl.create(:problem, :user_id => user.id) }
  let!(:solution) { FactoryGirl.create(:solution, :problem_id => problem.id, :user_id => user.id) }

  context "belongs to problem" do
    it "is included in a problem's solutions" do
      problem.solutions.should include(solution)
    end
  end
end