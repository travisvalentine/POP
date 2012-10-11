require 'spec_helper'

describe User do
  let(:user)     { FactoryGirl.create(:user) }
  let(:profile)  { FactoryGirl.create(:profile, :user_id => user.id) }
  let(:problem)  { FactoryGirl.create(:problem, :user_id => user.id) }
  let(:solution) { FactoryGirl.create(:problem, :user_id => user.id) }

  let(:auth)     { TwitterOauthHash.default }

  before {
    user
    profile
  }

  context "who is unauthenticated" do
    describe "and visits their settings page" do
      it "gets redirected to login" do
        visit settings_path(user.profile)
        current_path.should == login_path
        page.should have_content "Please log in to continue"
      end
    end
  end

  context "who authenticates with twitter" do
    use_vcr_cassette

    describe "and isn't a user yet" do
      it "creates the user from twitter auth and redirects them to complete their profile" do
        visit root_path
        click_link_or_button("Sign up with Twitter")
        current_path.should == welcome_path
        page.should have_content "Welcome, @example"
      end
    end
  end

  context "who is authenticated" do
    use_vcr_cassette

    before(:each) do
      login_as(user)
      profile
    end

    describe "and visits their profile page" do
      before(:each) do
        problem
        visit profile_path(profile)
      end

      it "sees their name" do
        page.should have_content profile.name
      end

      it "sees their twitter" do
        page.should have_content profile.twitter
      end

      it "sees their party affiliation" do
        page.should have_content profile.party_affiliation
      end

      it "sees their problems" do
        page.should have_content "My problems"
        page.should have_link problem.body
      end
    end

    context "and navigating the site from the header" do

      it "has the app name with a link to the homepage" do
        page.find(".brand").click
        current_path.should == problems_path
      end

      it "links to the current user's profile" do
        within "#user_profile" do
          page.should have_link "#{profile.name}"
          click_link_or_button "#{profile.name}"
        end
        current_path.should == profile_path(profile)
      end

      it "links to the current user's settings" do
        within "ul[aria-labelledby='user_settings']" do
          page.should have_link "Edit Profile"
          click_link_or_button "Edit Profile"
        end
        page.should have_content "#{profile.name}"
        page.should have_content "#{user.email}"
        page.should have_link "Delete Account"
      end

      it "links to log out" do
        within "ul[aria-labelledby='user_settings']" do
          page.should have_link "Log Out"
          click_link_or_button "Log Out"
        end
        current_path.should == root_path
      end
    end
  end

  context "who is unauthenticated" do
    let(:new_user1) { FactoryGirl.build(:user) }
    let(:new_user2) { FactoryGirl.build(:user) }
    let(:profile1) { FactoryGirl.build(:profile, :user_id => user.id) }
    let(:profile2) { FactoryGirl.build(:profile, :user_id => new_user2.id) }

    it "can JOIN from the home page" do
      visit root_path
      page.should have_content "Be a part of the solution"
      page.should have_selector("form#new_user")
    end

    describe "signing up" do
      before(:each) do
        visit root_path
        fill_signup_form_as(new_user1, profile)
      end

      it "sees signup fields on the signup page" do
        page.should have_button "JOIN"
        page.should have_content "What's your Birthday?"
        page.should have_content "What's your Party affiliation?"
      end

      describe "cannot JOIN" do
        it "with an empty email address" do
          pending
          fill_in "user_email", :with => ""
          expect { click_button "JOIN" }.to change { User.count }.by(0)
          page.should have_content "Email can't be blank"
        end

        it "with an already-used email address" do
          pending
          fill_signup_form_as(user, profile)
          expect { click_button "JOIN" }.to change { User.count }.by(0)
          page.should have_content "Email has already been taken"
        end

        it "with an invalid email address" do
          pending
          fill_in "user_email", :with => "test"
          expect { click_button "JOIN" }.to change { User.count }.by(0)
          page.should have_content "Email is invalid"
        end

        it "with an empty password" do
          pending
          fill_in "user_password", :with => ""
          expect { click_button "JOIN" }.to change { User.count }.by(0)
          page.should have_content "Password can't be blank"
        end

        it "with too short of a password" do
          pending
          fill_in "user_password", :with => "tes"
          expect { click_button "JOIN" }.to change { User.count }.by(0)
          page.should have_content "Password is too short"
        end
      end
    end

    describe "when signing up" do
      before(:each) do
        visit root_path
        fill_in 'user_profile_attributes_name', :with => 'Citizen Kane'
        fill_in 'user_email', :with => 'disgruntled@usa.gov'
        fill_in 'user_password', :with => 'password'
        fill_in 'user_profile_attributes_bio', :with => 'This is my bio'
        page.select 'March', :from => 'user_profile_attributes_birthday_2i'
        page.select '16', :from => 'user_profile_attributes_birthday_3i'
        page.select '1983', :from => 'user_profile_attributes_birthday_1i'
        page.select 'Democrat', :from => 'user_profile_attributes_party_affiliation'
      end

      it "both new user and new user's profile are persisted" do
        expect { click_button "JOIN" }.to change { User.count && Profile.count }.by(1)
      end
    end
  end

end