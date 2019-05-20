class Player < ApplicationRecord
	has_one :portfolio, dependent: :destroy
	has_many :trades, through: :portfolio
end
