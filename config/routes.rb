Rails.application.routes.draw do
 

  devise_for :admins

  root 'home#index'
  resources :home, only: [:index]
  # resources :home, only: [:index] do
  #   collection do
  #     get :import
  #   end
  # end
end
