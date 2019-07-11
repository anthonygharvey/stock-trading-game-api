class Stock < ApplicationRecord
	require 'json'
	serialize :prices, Array
	before_validation :get_prices, if: :unique_symbol
	validates :symbol, uniqueness: true
	validates :prices, length: {
		minimum: 100,
		message: "A stock must have at least 100 days of prices"
	}

	DOW = ['JNJ', 'DIS', 'MSFT', 'PG', 'PFE', 'IBM', 'INTC', 'MMM', 'MRK', 'WBA', 'CSCO', 'AAPL', 'XOM', 'UNH', 'KO', 'CAT', 'GS', 'NKE', 'MCD', 'TRV', 'V', 'CVX', 'UTX', 'VZ', 'WMT', 'HD', 'AXP', 'JPM', 'DOW', 'BA', 'DWDP'].freeze

	def self.random_stock
		Stock.find(pluck(:id).sample)
	end

	def random_dates
		start = prices.index(prices[0..-100].sample)
		prices[start...start+100]
	end

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

	def self.add_stocks(stocks)
		Array(stocks).each do |stock|
			puts("ABOUT TO ADD: #{stock}")
			sleep(10)
			Stock.create(symbol: stock)
			puts("JUST ADDED: #{stock}")
		end
	end
end
