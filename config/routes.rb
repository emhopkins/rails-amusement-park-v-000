Rails.application.routes.draw do

	root 'users#home'
	get '/signin' => 'sessions#new'
  	post '/sessions' => 'sessions#create'
  	get '/logout' => 'sessions#destroy' 
	resources :users
	resources :attractions


end