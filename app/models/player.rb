class Player < ApplicationRecord
  has_one :portfolio, required: true, dependent: :destroy
  has_many :trades, through: :portfolio
  accepts_nested_attributes_for :portfolio
end
