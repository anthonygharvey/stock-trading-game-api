class Portfolio < ApplicationRecord
  belongs_to :player
  has_many :trades, dependent: :destroy
  accepts_nested_attributes_for :trades
  before_save :percentage_change

  def shares
    trades.sum(:shares)
  end

  def percentage_change
    self.percentage_change = total_value / initial_balance - 1
  end
end
