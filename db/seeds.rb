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