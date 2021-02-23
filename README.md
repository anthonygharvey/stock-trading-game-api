![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg 'Made With Ruby')

## Description

A Ruby on Rails API to for the Anonymous Stock Game (<a href="https://github.com/anthonygharvey/stock-trading-game-client">repo</a>), which is built with React and Redux.

The API saves historical stock prices from the <a href="https://www.alphavantage.co/documentation/" target="_blank">Alpha Vantage API</a> and exposes several endpoints to the React frontend: `random_stock`, `save_game` and `leaderboard`.

The `random_stock` endpoint returns a random stock and random 100 consecutive days of prices.

The `save_game` endpoint accepts `POST` requests from the React frontend to save a player’s game information, including username, portfolio data and data for each trade.

The `leaderboard` endpoint returns a list of the top 10 players based on portfolio percentage gain.

## Local Installation

The API saves historical stock prices in order to avoid unnecessary requests to the Alpha Vantage API.

To install and run the API on your local machine:

1. Click the green Clone or download button above and click the copy to clipboard button
2. From your terminal, run `git clone [paste the link from step 1]`
3. Then run `cd stock-trading-game-api` to navigate to the stock-trading-game-api directory
4. Run `bundle install` to install the necessary gems and dependencies
5. Run `rails db:migrate` to perform the database migrations
6. Run `rake db:seed` to seed a sample of 5 stocks and their historical prices
7. Run `rails s -p 4000` to start the local rails server (you can choose any port number; I chose 4000 to avoid a conflict with the default port 3000 for the React frontend)

### Rake Tasks

**Note**: The rake tasks require an Alpha Vantage API key, which can be obtained for free [here](https://www.alphavantage.co/support/#api-key). Create a `.env` file at the root level and add:

`ALPHA_VANTAGE_API_KEY=<Your API key>`

To add historical prices for the Dow Jones stocks using an Alpha Vantage API key, run:
`bundle exec rake stocks:add_dow_jones_historical_prices`

To add historical prices for individual stocks, pass comma-separated ticker symbols to the `add_historical_prices_for` rake task:

`bundle exec rake stocks:add_historical_prices_for[<ticker symbol or symbols>]`

Examples:
`bundle exec rake stocks:add_historical_prices_for[AMZN]`

`bundle exec rake stocks:add_historical_prices_for[AMZN,TSLA]`
