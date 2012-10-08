# delete
Profile.delete_all
User.delete_all
Issue.delete_all
Problem.delete_all
Solution.delete_all

# issues
ISSUES = %w(
  Civil\ Rights
  Defense
  Disabilities
  Economy
  Education
  Energy\ &\ Environment
  Ethics
  Fiscal\ Responsibility
  Foreign\ Policy
  Health\ Care
  Homeland\ Security
  Immigration
  Rural
  Seniors\ &\ Social\ Security
  Service
  Taxes
  Technology
  Urban\ Policy
  Veterans
  Women
)

ISSUES.each do |issue|
  Issue.create!(:name => issue)
end

if Rails.env.development?
  test = FactoryGirl.create(:user, :email => "test@testing.com")
  test_profile = FactoryGirl.create(:profile,
                                    :name => "Testing Account",
                                    :user_id => test.id)

  user = FactoryGirl.create(:user)
  user_profile = FactoryGirl.create(:profile,
                                    :name => "Random Account",
                                    :user_id => user.id)

  20.times do
    user.problems.create(:body => Faker::Lorem::paragraph(sentence_count=2))
  end

  user.problems.each do |p|
    p.solutions.create(:body => Faker::Lorem::paragraph(sentence_count=2))
  end
end