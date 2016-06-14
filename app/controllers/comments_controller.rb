class CommentsController < ApplicationController
  
  def create
    @answer = Answer.find params[:answer_id]
    @comment = @answer.comments.build comments_params
    @comment.user_id = session[:user_id]
    @comment.save
    redirect_to @answer.question
  end

  private
  
  def comments_params
    params.
      require(:comment).
      permit :body, :answer_id
  end
end

