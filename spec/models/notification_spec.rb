require 'spec_helper'

describe Notification do
  let(:user)      { FactoryGirl.create(:user, :email => "1390@testing.com") }
  let(:profile)   { FactoryGirl.create(:profile,
                                       :name => "First Profile",
                                       :user_id => user.id) }

  let(:user2)     { FactoryGirl.create(:user, :email => "3109@testing.com") }
  let(:profile2)  { FactoryGirl.create(:profile,
                                       :name => "Second Profile",
                                       :user_id => user2.id) }

  let(:problem)   { FactoryGirl.create(:problem) }
  let(:solution)  { FactoryGirl.create(:solution, :user_id => user.id) }
  before {
    user
    profile
    user2
    profile2
    problem
    solution
  }

  describe ".create_from_comment(comment_body, user_id, solution_id)" do
    it "creates a notification from a solution's new comment" do
      pending
      comment = solution.comments.create!(
        :body => "Does this add a new notification",
        :user_id => user2.id
      )
      raise comment.inspect
    end
  end

  describe ".create_from_solution(comment_body, user_id, problem_id)" do
    it "creates a notification from a problem's new solution" do
      pending
    end
  end

end
