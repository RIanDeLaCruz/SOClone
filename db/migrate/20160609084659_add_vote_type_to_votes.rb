class AddVoteTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :vote_value, :integer, default: 0
    add_column :votes, :vote_type, :string
  end
end
