class AddIsguestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isguest, :boolean
  end
end
