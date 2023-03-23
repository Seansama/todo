Rails.application.routes.draw do
  resources :users
  resources :tasks
  post '/login' => 'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
