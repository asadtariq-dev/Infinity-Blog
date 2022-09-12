# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :authors

  root to: 'home#index'

  resources :authors, only: %i[show], as: :author_profile
  resources :likes, only: %i[create destroy]
  resources :reports, only: %i[create destroy]
  resources :suggestions, only: %i[index], as: :author_suggestions

  resources :posts do
    resources :comments, only: %i[create]
    resources :suggestions, only: %i[create edit update destroy]
    member do
      patch :submit
      put :submit
      get :submit
    end
  end

  resources :moderators do
    member do
      patch :publish
      put :publish
      get :publish
    end
  end

  get '*path', to: 'application#routing_error'
end
