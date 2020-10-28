# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'
  resources :heroes, only: %i[show index]
  resources :publishers, only: %i[show index]
  resources :races, only: %i[show index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "search", to: "heroes#search", as: "search" # search_path
end
