Rails.application.routes.draw do
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
    end
  end
end
