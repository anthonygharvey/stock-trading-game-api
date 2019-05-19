class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
		create_table :portfolios do |t|
			t.integer :initial_balance
			t.float :cash
			t.float :shares
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
