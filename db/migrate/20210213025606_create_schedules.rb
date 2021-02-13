class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
