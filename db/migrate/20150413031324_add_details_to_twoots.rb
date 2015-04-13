class AddDetailsToTwoots < ActiveRecord::Migration
  def change
    add_column :twoots, :username, :string
    add_column :twoots, :handle, :string
    add_column :twoots, :avatar_url, :string
  end
end
