class Stock < ApplicationRecord
  require 'json'
  serialize :prices, Array
  before_validation :fetch_prices, if: :unique_symbol
  validates :symbol, uniqueness: true
  validates :prices, length: {
    minimum: 100,
    message: 'A stock must have at least 100 days of prices'
  }

  def self.random_stock
    Stock.find(pluck(:id).sample)
  end

  def random_dates
    start = prices.index(prices[0..-100].sample)
    prices[start...start + 100]
  end

  private

  def unique_symbol
    !Stock.pluck(:symbol).include?(symbol)
  end

  def fetch_prices
    response = RestClient.get 'https://www.alphavantage.co/query', { params: {
      function: 'TIME_SERIES_DAILY_ADJUSTED',
      symbol: symbol.to_s,
      outputsize: 'full',
      apikey: ENV['ALPHA_VANTAGE_API_KEY']
    } }
    stock = JSON.parse(response)
    self.prices = stock['Time Series (Daily)'].map do |k, v|
      { date: k.to_date, price: v.values[4].to_f }
    end
  end
end
