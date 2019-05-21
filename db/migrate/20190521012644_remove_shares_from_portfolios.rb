class RemoveSharesFromPortfolios < ActiveRecord::Migration[5.2]
  def change
    remove_column :portfolios, :shares, :float
  end
end
