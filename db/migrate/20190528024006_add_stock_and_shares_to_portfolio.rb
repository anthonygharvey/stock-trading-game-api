class AddStockAndSharesToPortfolio < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolios, :stock, :string
    add_column :portfolios, :shares, :integer
    add_column :portfolios, :share_value, :float
    add_column :portfolios, :total_value, :float
  end
end
