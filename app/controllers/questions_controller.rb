class QuestionsController < ApplicationController
  def new

  end
  def create
    # render plain: params[:question].inspect
    # @question = Question.new(params[:question])
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.save
    redirect_to @question
  end
  def index
    @questions = Question.all
  end
  def show
    _counter = 0
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
    @upvotes = Vote.where(votable_id: params[:id], vote_type: "upvote").pluck("id, vote_value")
    @downvotes = Vote.where(votable_id: params[:id], vote_type: "downvote").pluck("id, vote_value")

    @total_vote_query= Vote.where(votable_id: params[:id], user_id: session[:user_id]).pluck("vote_value")
    @total_votes  = 0
    @total_vote_query.each do |vote|
      @total_votes += vote
    end
    @answers_upvotes = []
    @answers_downvotes = []
    @answers.each do |answer|
      @answers_upvotes << Vote.where(votable_id: answer.id, vote_type: "upvote", votable_type: "Answer").ids
      @answers_downvotes << Vote.where(votable_id: answer.id, vote_type: "downvote", votable_type: "Answer").ids
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end

  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def question_params
      params.require(:question).permit(:title, :content, :tags, :tag_list, :user_id)
    end
end
