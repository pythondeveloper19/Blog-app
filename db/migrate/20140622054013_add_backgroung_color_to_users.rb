class AddBackgroungColorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bg_color, :string
  end
end
