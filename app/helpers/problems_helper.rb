module ProblemsHelper
  def upvote_problem(problem, image)
    if logged_in? and current_user.up_voted?(problem)
      link_to image_tag(image), existing_problem_votes_path(:id => problem.id), :id => "upvote_big", :method => :post
    else
      link_to image_tag(image), problem_upvotes_path(:id => problem.id), :id => "upvote_big", :method => :post
    end
  end

  def downvote_problem(problem, image)
    if logged_in? and current_user.down_voted?(problem)
      link_to image_tag(image), existing_problem_votes_path(:id => problem.id), :id => "downvote_big", :method => :post
    else
      link_to image_tag(image), problem_downvotes_path(:id => problem.id), :id => "downvote_big", :method => :post
    end
  end
end