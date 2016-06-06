class QuestionsController < ApplicationController
  def new

  end
  def create
    # render plain: params[:question].inspect
    @question = Question.new(params[:question])
    if(@question.save)
      params[:question][:tags].split(',').each do |tag|
          @question.tag.create
      end
    else
    end
  end
end
