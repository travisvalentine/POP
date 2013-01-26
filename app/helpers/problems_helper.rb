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

  def votes_text(votes_count)
    case
    when votes_count == 0, votes_count > 1
      "Votes"
    else
      "Vote"
    end
  end

  def solutions_text(solutions_count)
    case
    when solutions_count == 0, solutions_count > 1
      "Solutions"
    else
      "Solution"
    end
  end
end