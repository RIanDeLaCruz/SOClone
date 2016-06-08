class VotesController < ApplicationController
  def upvote
    @vote = Vote.new
    @vote.type = "upvote"
    @vote.votable_id = params[:id]
    if @vote.save
      @redirect_q = Question.find(params[:id])
     redirect_to @redirect_q
    end 
  end

  def downvote
  end

  private 
    def vote_params
      # params.require(:votes).permit(:type, :votable_id, :user_id)
    end
end
