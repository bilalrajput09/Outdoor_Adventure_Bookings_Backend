Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'login', to: 'users#login'
      post 'signup', to: 'users#signup'
      post 'create_adventure', to: 'adventures#create'
      get 'signout', to: 'users#signout'
      get 'current_user', to: 'users#current_user'
      get 'adventures', to: 'adventures#index'
      resources :reservations, only: [:create]
      post 'fetch_reservations', to: 'reservations#fetch_reservations'
      delete 'delete_reservation', to: 'reservations#destroy'
    end
  end
end
