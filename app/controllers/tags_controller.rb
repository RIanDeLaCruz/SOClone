class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by_title(params[:title])
    @qs = @tag.questions 
  end
end
