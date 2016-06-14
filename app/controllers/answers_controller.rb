class AnswersController < ApplicationController
  
  def new
    @question_id = params[:question_id]
  end

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.build answers_params
    @answer.user_id = session[:user_id]
    @answer.save
    redirect_to @question
  end

  private

  def answers_params
    params.
      require :answer.
      permit :body, :question_id, :user_id
  end
end
