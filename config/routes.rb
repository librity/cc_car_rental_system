# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :manufacturers
  resources :subsidiaries, only: %i[index show new create]
  resources :car_categories, only: %i[index show new create]
  resources :customers, only: %i[index show new create]
end
