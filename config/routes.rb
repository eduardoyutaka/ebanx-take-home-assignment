Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/balance', to: 'balances#show'
  post '/event', to: 'events#create'
  post '/reset', to: 'events#reset'
end
