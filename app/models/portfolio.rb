class Portfolio < ApplicationRecord
	belongs_to :player
	has_many :trades, dependent: :destroy
	accepts_nested_attributes_for :trades

	def shares
		trades.sum(:shares)
	end
end
