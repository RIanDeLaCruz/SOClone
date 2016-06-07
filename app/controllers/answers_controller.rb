class AnswersController < ApplicationController
  def new
    @question_id = params[:question_id]
  end

  def create
    @answer = Answer.new(answers_params)
    @answer.question_id = params[:question_id]
    @answer.save
    @question = Question.find(params[:question_id])
    redirect_to @question
  end

  def edit
  end

  def index
  end

  private
    def answers_params
      params.require(:answer).permit(:body, :question_id)
    end
end
