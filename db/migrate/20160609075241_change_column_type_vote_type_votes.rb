class ChangeColumnTypeVoteTypeVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :vote_type
  end
end