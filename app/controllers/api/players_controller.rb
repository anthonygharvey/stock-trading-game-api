class Api::PlayersController < ApplicationController
  PORTFOLIO_PARAMS = %i[stock initial_balance cash shares share_value total_value].freeze
  TRADE_PARAMS = %i[date order_type stock_symbol shares stock_price commission].freeze
  def new
    player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      render json: {
        "player": @player,
        "portfolio": @player.portfolio,
        "trades": @player.portfolio.trades
      }
    else
      render json: { message: @player.errors }, status: 400
    end
  end

  private

  def player_params
    params.require(:player).permit(:user_name,
                                   portfolio_attributes: [PORTFOLIO_PARAMS,
                                                          trades_attributes: [TRADE_PARAMS]])
  end
end
