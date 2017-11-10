Rails.application.routes.draw do
  # get 'projects/index'
  devise_for :users
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    post :import, on: :member
    # resources :words
    post :add_language, on: :member
    resources :words, only: [:index, :create]
  end
  root 'projects#index'
end
