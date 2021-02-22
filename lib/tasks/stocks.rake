namespace :stocks do
  task :add_historical_prices_for, [:stocks] => [:environment] do |_t, args|
    desc 'adds historical stock prices using the Alpha Vantage API'
    Array(args[:stocks]).each do |stock|
      retries ||= 0
      puts("Adding: #{stock}")
      Stock.create(symbol: stock)
      sleep(10) # avoid Alpha Vantage API rate throtttling
      puts("Finished adding: #{stock}")
    rescue StandardError => e
      puts "#{stock}: #{e.message}"
      retry if (retries += 1) < 4
    end
  end
end
