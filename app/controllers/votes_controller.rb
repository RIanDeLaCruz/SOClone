class VotesController < ApplicationController
  def upvote
    @vote = Vote.new
    @vote.vote_type = "upvote"

    @vote.votable_id = if params[:question_id].present? then params[:question_id] else params[:answer_id] end
    @vote.votable_type =  if params[:question_id].present? then 'Question' else 'Answer' end
    @vote.user_id = session[:user_id]
    @vote.vote_value = 1
    
    _check_vote = Vote.find_by(votable_id: @vote.votable_id, user_id: session[:user_id], vote_type: "upvote") 
    _all_votes_for_question = Vote.where(votable_id: @vote.votable_id, user_id: session[:user_id]).pluck("vote_value")  
    if _check_vote == nil
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
    else
      _total = 0
      _all_votes_for_question.each do |vote|
        # raise _all_votes_for_question.inspect
        if vote != nil
          _total += vote
        end
      end
      if _total == 0 || _total == -1
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
      else
        flash[:message] = "You can only downvote #{_total}"
      end 
    end
  end

  def downvote
    @vote = Vote.new
    @vote.vote_type = "downvote"
    @vote.votable_id = if params[:question_id].present? then params[:question_id] else params[:answer_id] end
    @vote.votable_type =  if params[:question_id].present? then 'Question' else 'Answer' end
    @vote.user_id = session[:user_id]
    @vote.vote_value = -1
    
    _check_vote = Vote.find_by(votable_id: @vote.votable_id, 
                               user_id: session[:user_id], 
                               vote_type: "downvote")
    _all_votes_for_question = Vote.where(votable_id: @vote.votable_id, 
                                         user_id: session[:user_id]
                                        ).pluck("vote_value")  
    if _check_vote == nil
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
    else 
      _total = 0
      _all_votes_for_question.each do |vote|
        if vote != nil
          _total += vote
        end
      end
      if _total == 0 || _total == 1
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
      else
        flash[:message] = "You can only downvote #{_total}"
      end
    end 
  end

  private 
    def vote_params
      # params.require(:votes).permit(:type, :votable_id, :user_id)
    end
end
