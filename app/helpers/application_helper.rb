module ApplicationHelper
  def homepage?
    request.fullpath == root_path
  end

  def index_active
    if request.fullpath == "/problems"
      content_tag(:li, link_to('Problems', problems_path), :class => "active")
    else
      content_tag(:li, link_to('Problems', problems_path))
    end
  end
end
