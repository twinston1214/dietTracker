class CreateCalorieEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :calorie_entries do |t|
      t.string :Meal
      t.float :Calories

      t.timestamps
    end
  end
end
