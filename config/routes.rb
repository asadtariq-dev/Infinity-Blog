# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :authors, controllers: { sessions: 'authors/sessions' }
  root to: 'home#index'

  resources :authors, only: %i[show], as: :author_profile
  resources :likes, only: %i[create destroy]
  resources :reports, only: %i[create destroy]
  resources :suggestions, only: %i[index], as: :author_suggestions

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :suggestions, only: %i[create edit update destroy]
    member do
      get :submit
      put :submit
    end
  end

  authenticate :author, ->(user) { user.moderator? } do
    resources :moderators, only: %i[index show destroy] do
      member do
        get :publish_post
        put :publish_post
      end
    end
  end

  get '*path', to: 'application#routing_error'
end
