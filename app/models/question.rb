class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  has_many :answers
  has_many :comments

  def tag_list
    self.tags.map{ |t| t.name }.join(',')
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/,\s+/)
  end
end
