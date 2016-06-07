class Question < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  has_many :answers
  has_many :comments

  def tag_list
    self.tags.map{ |t| t.title }.join(',')
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/,\s+/)
    tag_names.each do |tag|
      if(Tag.find_by title: tag)
        _new_tag = Tag.new(title: tag)
        self.tags << _new_tag
      else
        _new_tag = Tag.create(title: tag)
        self.tags << _new_tag
      end
    end
  end
end
