class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.date :date
      t.string :order_type
			t.string :stock_symbol
			t.float :shares
      t.float :stock_price
			t.float :commission
			t.float :total
			t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
