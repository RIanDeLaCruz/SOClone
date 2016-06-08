class VotesController < ApplicationController
  def upvote
    @vote = Vote.new
    @vote.type = "upvote"
    # Change the method of getting the votable_id
    # As it stands, the votable_id is assigned to the question
    # Method should be to get the id of the either the Answer or the Question
    @vote.votable_id = if params[:question_id].present? then params[:question_id] else params[:answer_id] end
    @vote.votable_type =  if params[:question_id].present? then 'Question' else 'Answer' end

    if @vote.save
      if params[:question_id].present?
        redirect_q = Question.find(params[:question_id])
        redirect_to redirect_q
      else
        q_id = Answer.where(id: params[:answer_id]).pluck("question_id")
        redirect_q = Question.find(q_id) 
        redirect_to redirect_q
      end

    end 
  end

  def downvote
    @vote = Vote.new
    @vote.type = "downvote"
    @vote.votable_id = if params[:question_id].present? then params[:question_id] else params[:answer_id] end
    @vote.votable_type =  if params[:question_id].present? then 'Question' else 'Answer' end

    if @vote.save
      if params[:question_id].present?
        redirect_q = Question.find(params[:question_id])
        redirect_to redirect_q
      else
        q_id = Answer.where(id: params[:answer_id]).pluck("question_id")
        redirect_q = Question.find(q_id) 
        redirect_to redirect_q
      end

    end 
  end

  private 
    def vote_params
      # params.require(:votes).permit(:type, :votable_id, :user_id)
    end
end
