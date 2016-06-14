class VotesController < ApplicationController
  def upvote
     if params[:question_id]
        @question = Question.find(params[:question_id])
        @voteable = @question
     else
       @answer = Answer.find(params[:answer_id])
       @question = @answer.question
       @voteable = @answer
     end
     
     @vote = @voteable.votes.find_or_create_by(votable_id: @voteable.id, user_id: session[:user_id])
     @vote.user_id = session[:user_id]

     @vote.vote_value = @vote.vote_value.to_i+1

     @vote.save if @vote.vote_value <= 1

     redirect_to @question
  end

  def downvote
    if params[:question_id]
      @question = Question.find(params[:question_id])
      @voteable = @question
    else
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
      @voteable = @answer
    end
     
    @vote = @voteable.votes.find_or_create_by(votable_id: @voteable.id, user_id: session[:user_id])
    @vote.user_id = session[:user_id]

    @vote.vote_value = @vote.vote_value.to_i-1

    @vote.save if @vote.vote_value >= -1

     redirect_to @question
  end

  private 
    def vote_params
      # params.require(:votes).permit(:type, :votable_id, :user_id)
    end
end
