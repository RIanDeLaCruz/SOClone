class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  has_many :answers
  has_many :comments
end
