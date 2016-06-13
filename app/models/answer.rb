class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_many :comments, :class_name => "Answer", :foreign_key => "comments_id"
  belongs_to :parent_post, :class_name => "Answer"
  has_many :votes, :as => :votable

  accepts_nested_attributes_for :comments
end
