class AddPercentageChangeToPortfolio < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolios, :percentage_change, :float
  end
end
