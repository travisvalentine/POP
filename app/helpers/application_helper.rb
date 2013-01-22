module ApplicationHelper

  def index_active
    if request.fullpath == problems_path || request.fullpath == root_path
      content_tag(:li, link_to('All Problems', problems_path), :class => "active")
    else
      content_tag(:li, link_to('All Problems', problems_path))
    end
  end
end
