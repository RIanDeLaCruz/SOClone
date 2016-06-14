class AddCommentsColumnToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :comments_id, :integer
  end
end
