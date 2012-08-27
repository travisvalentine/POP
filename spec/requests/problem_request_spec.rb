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

    context "who wants to vote on a problem" do
      before(:each) do
        visit problem_path(problem)
      end

      it "has links to vote up and down a problem" do
        page.should have_selector ".vote"
      end

      it "shows an arrow to upvote the problem" do
        within(".vote") do
          page.should have_selector "#upvote_big"
        end
      end

      it "allows a user to upvote the problem" do
        within(".vote") do
          page.should have_selector "#upvote_big"
        end
      end

      it "shows an arrow to downvote the problem" do
        within(".vote") do
          page.should have_selector "#downvote_big"
        end
      end

      it "allows a user to downvote the problem" do
        within(".vote") do
          page.should have_selector "#downvote_big"
        end
      end      
    end
  end

end