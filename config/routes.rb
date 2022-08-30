Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :authors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'readers/home#index'

  get '/blog/:id' => 'readers/posts#show', as: :blog_post
  get '/author/:id' => 'authors#show', as: :author_profile

  resources :moderators do
    member do
      patch :publish
      put :publish
      get :publish
    end
  end

  resources :likes, only: %i[create destroy]
  resources :reports, only: %i[create destroy]

  resources :comments do
    resources :likes, only: %i[create destroy]
  end

  scope module: 'authors' do
    resources :posts do
      resources :comments, only: %i[create]
      member do
        patch :submit
        put :submit
        get :submit
      end
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
