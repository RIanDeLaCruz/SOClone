class QuestionsController < ApplicationController
  def new

  end
  def create
    # render plain: params[:question].inspect
    # @question = Question.new(params[:question])
    @question = Question.new(question_params)
    @question.save
    redirect_to @question
  end
  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id]).pluck(:body)
  end
  private
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def question_params
      params.require(:question).permit(:title, :content, :tags, :tag_list)
    end
end
