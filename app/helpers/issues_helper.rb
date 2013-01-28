module IssuesHelper
  def current_issue?(issue)
    request.fullpath == issue_path(issue)
  end
end
