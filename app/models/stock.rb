class Stock < ApplicationRecord
	require 'json'
	serialize :prices, Array
	validates :symbol, uniqueness: true
	before_save :get_prices, if: :unique_symbol

	DOW = ['JNJ', 'DIS', 'MSFT', 'PG', 'PFE', 'IBM', 'INTC' 'MMM', 'MRK', 'WBA', 'CSCO', 'AAPL', 'XOM', 'UNH', 'KO', 'CAT', 'GS', 'NKE', 'MCD', 'TRV', 'V', 'CVX', 'UTX', 'VZ', 'WMT', 'HD', 'AXP', 'JPM', 'DOW', 'BA', 'DWDP'].freeze

	private

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

	def self.add_dow
		DOW.each do |stock|
			puts("ABOUT TO ADD: #{stock}")
			sleep(10)
			Stock.create(symbol: stock)
			puts("JUST ADDED: #{stock}")
		end
	end
end
