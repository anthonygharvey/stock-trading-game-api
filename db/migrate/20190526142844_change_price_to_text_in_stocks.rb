class ChangePriceToTextInStocks < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :prices, :text
  end
end
