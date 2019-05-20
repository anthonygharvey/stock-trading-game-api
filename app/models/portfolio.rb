class Portfolio < ApplicationRecord
	belongs_to :player
	has_many :trades, dependent: :destroy
end
