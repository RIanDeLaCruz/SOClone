class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_many :comments, :class_name => "Answer", :foreign_key => "comments"
  belongs_to :parent_answer, :class_name => "Answer"
  has_many :votes, :as => :votable
end
