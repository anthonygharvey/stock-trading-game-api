require 'pastel'

namespace :stocks do
  task add_dow_jones_historical_prices: :environment do
    desc 'adds historical prices for the stocks in the Dow Jones Industrial Average'
    DOW = %w[JNJ DIS MSFT PG PFE IBM INTC MMM MRK WBA CSCO AAPL XOM UNH KO CAT GS NKE MCD TRV V CVX UTX VZ WMT HD AXP JPM DOW BA DWDP].freeze
    Rake::Task['stocks:add_historical_prices_for'].invoke(DOW)
  end

  task :add_historical_prices_for, [:stock] => [:environment] do |_t, args|
    desc 'adds historical stock prices using the Alpha Vantage API'
    stocks = args.stock.class == Array ? args.stock : args.extras.unshift(args.stock)

    def random_spinner_for(stock)
      pastel = Pastel.new
      random_dot_token = TTY::Formats::FORMATS.keys[8..16].sample
      options = { format: random_dot_token, hide_cursor: false, success_mark: pastel.green('✔') }
      TTY::Spinner.new(":spinner Adding #{stock}", options)
    end

    stocks.each do |stock|
      retries ||= 0
      spinner = random_spinner_for(stock)
      spinner.auto_spin
      Stock.create(symbol: stock)
      sleep(10) # avoid Alpha Vantage API rate throtttling
      spinner.success
    rescue StandardError => e
      spinner.error("(error} #{e.message}")
      retry if (retries += 1) < 4
    end
  end
end
