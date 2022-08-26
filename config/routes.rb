Rails.application.routes.draw do
  devise_for :authors
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "readers/home#index"

  scope module: 'authors' do
    resources :posts do
      member do
        patch :publish
        put :publish
        get :publish
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
