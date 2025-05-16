class CreateCalories < ActiveRecord::Migration[8.0]
  def change
    create_table :calories do |t|
      t.string :meal
      t.float :amount

      t.timestamps
    end
  end
end
