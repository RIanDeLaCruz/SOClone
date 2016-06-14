class Question < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :answers, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :votes, :as => :votable

  has_and_belongs_to_many :tags





  def total_votes
    self.votes.sum :vote_value
  end





  def tag_list
    # self.tags.map {|t| t.title}.join(',')
    mapped = self.tags.map do |t|
      t.title
    end
    mapped.join ','
  end

  def tag_list= new_value
    tag_names = new_value.split /,\s+/
    self.tags.destroy_all
    tag_names.each do |tag|
      if Tag.find_by title: tag
        new_tag = Tag.new title: tag
        self.tags << _new_tag
      else
        new_tag = Tag.create title: tag
        self.tags << new_tag
      end
    end
  end
end
