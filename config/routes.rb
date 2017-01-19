Rails.application.routes.draw do
  resources :jobs
  post '/category', to: 'categories#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
