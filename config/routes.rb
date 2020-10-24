# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'
  resources :heroes, only: %i[show index]
  resources :publisher, only: %i[show index]
  resources :race, only: %i[show index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
