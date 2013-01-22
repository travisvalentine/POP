module SolutionsHelper
  def upvote_solution(solution, image)
    if logged_in? and current_user.up_voted?(solution)
      link_to image_tag(image), existing_solution_votes_path(:id => solution.id), :method => :post
    else
      link_to image_tag(image), solution_upvotes_path(:id => solution.id), :method => :post
    end
  end

  def downvote_solution(solution, image)
    if logged_in? and current_user.down_voted?(solution)
      link_to image_tag(image), existing_solution_votes_path(:id => solution.id), :method => :post
    else
      link_to image_tag(image), solution_downvotes_path(:id => solution.id), :method => :post
    end
  end
end
