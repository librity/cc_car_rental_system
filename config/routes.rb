# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :customers
  resources :car_models
  resources :cars

  resources :rentals do
    collection do
      match :search, via: :get, as: :search_by_token
    end
  end
end
