class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.date :start_date
      t.date :end_date
      t.float :initial_value
      t.float :final_value

      t.timestamps
    end
  end
end
