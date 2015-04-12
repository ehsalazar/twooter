class CreateTwoots < ActiveRecord::Migration
  def change
    create_table :twoots do |t|
      t.string :body, null: false, limit: 140

      t.timestamps null: false
    end
  end
end
