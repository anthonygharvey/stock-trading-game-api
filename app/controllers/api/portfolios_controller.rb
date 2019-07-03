class Api::PortfoliosController < ApplicationController
	def leaderboard
		@top_10 = Portfolio.order(percentage_change: :desc).limit(10).joins(:player).select("players.id, players.user_name, stock, total_value, percentage_change, initial_balance, players.created_at")

		render :json => @top_10
	end
end