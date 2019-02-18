class CreateStockInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_infos do |t|
      t.string :symbol
      t.date :start_date
      t.date :end_date
      t.float :initial_value
      t.float :final_value
      t.float :rate_of_return
      t.float :max_drawdown

      t.timestamps
    end
  end
end
