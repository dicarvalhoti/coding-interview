Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies, only: [] do
    resources :users, only: [:index]
  end

  resources :tweets, only: [:index]

  resources :users, param: :username, only: [:index, :show] do
    resources :tweets, only: [:index]
  end

  mount Core::Engine, at: '/app' if defined?(Core)

end
