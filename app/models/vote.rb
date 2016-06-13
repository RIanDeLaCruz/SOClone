class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, 
             :polymorphic => true
  # enum vote_type: [1, -1]

  scope :upvotes, ->{ where :vote_type => "upvote" }
  scope :downvotes, ->{ where :vote_type => "downvote" }
end
