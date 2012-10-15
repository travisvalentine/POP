class CommentsController < ApplicationController
  before_filter :authenticate

  def new
    @comment = Comment.new
  end

  def create
    @solution = Solution.find(params[:comment][:solution_id])
    @comment = @solution.comments.create(params[:comment])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(:back, :notice => 'Comment was successfully created.') }
      else
        format.html { redirect_to(:back, :notice => "There was an error.") }
      end
    end

  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to(:back, :notice => 'Comment deleted.')
  end

end