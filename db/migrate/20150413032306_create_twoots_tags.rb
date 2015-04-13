class CreateTwootsTags < ActiveRecord::Migration
  def change
    create_table :twoots_tags do |t|
      t.belongs_to :twoot
      t.belongs_to :hashtag

      t.timestamps null: false
    end
  end
end
