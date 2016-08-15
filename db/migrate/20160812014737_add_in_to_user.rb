class AddInToUser < ActiveRecord::Migration
  def change
    add_column :users, :introduction, :string
  end
end
