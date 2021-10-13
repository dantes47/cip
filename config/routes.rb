# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  get 'home/index'
  get 'home/about'
  get 'home/info'
  get 'home/contact'

  root 'home#index'

  resources :customers do
    collection { post :import }
  end
end
