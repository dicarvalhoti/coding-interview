Core::Engine.routes.draw do

  resources :companies do 
    get :add, on: :collection
    get :edit, on: :member
    delete :delete, on: :member
    post :update_data, on: :member
  end

  root to: "companies#index", as: :home_app
end
