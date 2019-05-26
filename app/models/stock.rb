class Stock < ApplicationRecord
	require 'json'
	validates :symbol, uniqueness: true
	before_save :get_prices, if: :unique_symbol

	def unique_symbol
		!Stock.pluck(:symbol).include?(self.symbol)
	end

	def get_prices
		response = RestClient.get 'https://www.alphavantage.co/query', {params: {
			function: 'TIME_SERIES_DAILY_ADJUSTED',
			symbol: "#{symbol}",
			outputsize: "full",
			apikey: ENV['ALPHA_VANTAGE_API_KEY']
		}}
		stock = JSON.parse(response)
		self.prices = stock["Time Series (Daily)"].map do |k,v|
			{date: k.to_date, price: v.values[4].to_f}
		end
	end
end
