Rails.application.routes.draw do
  namespace :api do
    get 'random_stock', to: 'stocks#random'
    post 'save_game', to: 'players#create'
    get 'leaderboard', to: 'portfolios#leaderboard'
  end
end
