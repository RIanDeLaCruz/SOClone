class Vote < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :votable, 
             :polymorphic => true

  scope :upvotes, ->{ where :vote_type => 'upvote' }
  scope :downvotes, ->{ where :vote_type => 'downvote' }
end

