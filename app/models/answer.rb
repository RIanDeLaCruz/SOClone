class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  has_many :answers, :class_name => "Answer", :foreign_key => "comments"
  has_many :votes, :as => :votable
end
