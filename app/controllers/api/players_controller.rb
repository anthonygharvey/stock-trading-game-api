class Api::PlayersController < ApplicationController
	PORTFOLIO_PARAMS = %i(stock initial_balance cash shares share_value total_value)
	def new
		player = Player.new
	end

	def create
		@player = Player.new(player_params)
		build_portfolio
		if @player.save
			render json: {
				"player": @player,
				"portfolio": @player.portfolio,
				"trades": @player.portfolio.trades
			}
		else
			render json: {message: @player.errors}, status: 400
		end
	end

	private

	def build_portfolio
		@player.build_portfolio(portfolio_params)
	end

	def player_params
		params.require(:player).permit(:user_name)
	end

	def portfolio_params
		params.require(:portfolio).permit(PORTFOLIO_PARAMS)
	end
end