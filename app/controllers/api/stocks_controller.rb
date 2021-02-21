class Api::StocksController < ApplicationController
  def random
    random_stock = Stock.random_stock
    render json: {
      "symbol": random_stock.symbol,
      "prices": random_stock.random_dates
    }
  end
end
