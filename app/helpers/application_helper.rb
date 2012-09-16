module ApplicationHelper
  def homepage?
    request.fullpath == root_path
  end
end
