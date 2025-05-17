class CreateDailyGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_goals do |t|
      t.date :date
      t.float :goal

      t.timestamps
    end
  end
end
