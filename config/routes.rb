Rails.application.routes.draw do
	namespace :api do
		get 'random_stock', to: 'stocks#random'
	end
end
