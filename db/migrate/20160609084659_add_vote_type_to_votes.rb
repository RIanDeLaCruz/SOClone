class AddVoteTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :vote_value, :integer
    add_column :votes, :vote_type, :string
  end
end
