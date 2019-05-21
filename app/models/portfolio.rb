class Portfolio < ApplicationRecord
	belongs_to :player
	has_many :trades, dependent: :destroy

	def shares
		trades.sum(:shares)
	end
end
