class Trade < ApplicationRecord
  belongs_to :portfolio
  before_save :calculate_total

  def calculate_total
    self.total = stock_price * shares + commission
  end
end
