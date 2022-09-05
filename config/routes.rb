Rails.application.routes.draw do
  devise_for :authors
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
      resources :suggestions, only: %i[create destroy]
      member do
        patch :submit
        put :submit
        get :submit
      end
    end
  end

  get '*path', to: 'application#routing_error'
end
