module IssuesHelper
  def issues_list
    Issue.all.map(&:name)
  end
end
