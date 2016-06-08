class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :type
      t.references :user, index: true, foreign_key: true
      t.references :votable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
