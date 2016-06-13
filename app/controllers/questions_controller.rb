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
    
    @upvotes = Vote.where(votable_id: params[:id], 
                          vote_type: "upvote"
                         ).pluck("id, vote_value")
    
    @downvotes = Vote.where(votable_id: params[:id], 
                            vote_type: "downvote"
                           ).pluck("id, vote_value")

    @total_vote_query= Vote.where(votable_id: params[:id], 
                                  user_id: session[:user_id]
                                 ).pluck("vote_value")
    @total_votes  = 0
    @total_vote_query.each do |vote|
      @total_votes += vote
    end

    @answer_upvotes = []
    @answer_downvotes = []
    @answers.each do |answer| 
      @answer_upvotes += answer.votes.upvotes.pluck("vote_value")
      # raise @answer_upvotes.inspect
      @answer_downvotes += answer.votes.downvotes.pluck("vote_value")
    end
    # raise @answer_upvotes.inspect
    @answer_total = 0
    @answer_upvotes.each do |upvote|
      @answer_total += upvote
    end 
    @answer_downvotes.each do |downvote|
      @answer_total += downvote
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def question_params
      params.require(:question).permit(:title, :content, :tag_list, :user_id)
    end
end
