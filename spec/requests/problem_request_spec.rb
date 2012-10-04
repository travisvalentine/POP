require 'spec_helper'

describe Problem do
  let(:user)                  { FactoryGirl.create(:user) }

  let(:profile)               { FactoryGirl.create(:profile, :user_id => user.id) }

  let(:problem)               { FactoryGirl.create(:problem, :user_id => user.id) }

  let(:problem_with_upvote)   { FactoryGirl.create( :problem,
                                                    :user_id => user.id,
                                                    :up_votes => 1,
                                                    :down_votes => 0
                                                  ) }

  let(:problem_without_votes) { FactoryGirl.create( :problem,
                                                    :user_id => user.id,
                                                    :up_votes => 0,
                                                    :down_votes => 0
                                                  ) }

  let(:solution)               { FactoryGirl.create(:solution,
                                                    :problem_id => problem.id,
                                                    :user_id => user.id) }

  let(:solution_without_votes) { FactoryGirl.create(:solution,
                                                    :problem_id => problem_without_votes.id,
                                                    :user_id => user.id) }

  let(:solution_with_upvote)   { FactoryGirl.create(:solution,
                                                    :problem_id => problem_with_upvote.id,
                                                    :user_id => user.id) }

  let(:problem_issue)          { problem.issues.create(:name => "Issue") }

  let(:problem_upvote_issue)   { problem_with_upvote.issues.create(:name => "Issue 2") }

  let(:problem_without_issue)  { problem_without_votes.issues.create(:name => "Issue 3") }

  before {
    user
    profile
  }

  context "as an authenticated user" do
    before(:each) do
      login_as(user)
      problem
      solution
      problem_issue
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
        within(".vote.big") do
          page.should have_selector("img[alt=Up-large]")
        end
      end

      it "allows a user to upvote the problem" do
        within(".vote.big") do
          page.should have_selector "#upvote_big"
        end
      end

      it "shows an arrow to downvote the problem" do
        within(".vote.big") do
          page.should have_selector("img[alt=Down-large]")
        end
      end

      it "allows a user to downvote the problem" do
        within(".vote.big") do
          page.should have_selector "#downvote_big"
        end
      end
    end

    context "that has not been voted" do
      before(:each) {
        problem_without_votes
        solution_without_votes
        problem_without_issue
        visit problem_path(problem_without_votes)
      }

      it "adds an upvote when voted up" do
        page.find("#upvote_big").click
        within(".vote.big h1") do
          page.should have_content("1")
        end
      end

      it "redirects back to the problem when voted on" do
        page.find("#upvote_big").click
        current_path.should == problem_path(problem_without_votes)
      end

    end

    context "that has already been voted up" do
      before(:each) {
        problem_with_upvote
        solution_with_upvote
        problem_upvote_issue
        visit problem_path(problem_with_upvote)
      }

      it "has an upvote" do
        problem_with_upvote.up_votes.should == 1
      end

      it "removes the up vote when clicked up again" do
        page.find("#upvote_big").click
        within(".vote.big h1") do
          page.should have_content("2")
        end
        page.find("#upvote_big").click
        within(".vote.big h1") do
          page.should have_content("1")
        end
      end

    end

  end

end