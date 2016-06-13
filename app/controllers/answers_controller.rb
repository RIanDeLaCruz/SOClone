class AnswersController < ApplicationController
  def new
    @question_id = params[:question_id]
  end

  def create
    @answer = Answer.new(answers_params)
    @answer.question_id = params[:question_id]
    @answer.user_id = session[:user_id]
    @answer.save
    @question = Question.find(params[:question_id])
    redirect_to @question
  end

  def edit
    @answer = Answer.find(params[:id])
    @new_comment = @answer.comments.build 
  end
 
  def update
    @answer = Answer.find(params[:id])
    @answer.assign_attributes(answers_params)
    @answer.user_id = session[:user_id]
    @answer.save
    redirect_to @answer.question 
  end

  def index
  end

  private
    def answers_params
      params.require(:answer).permit(:body, :question_id, :user_id, :comments_attributes => [:body])
    end
end
