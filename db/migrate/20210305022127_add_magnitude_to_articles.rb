class AddMagnitudeToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :magnitude, :float
  end
end
