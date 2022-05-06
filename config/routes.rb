Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'home#index'
  get 'users', to: 'home#users'
  #root 'profiles#index'
  resources :profiles
  
  resources :posts do
    member do
          get :flop
    end
      resources :comments do
        
      end
  end

  resources :users do 
    resources :relationships, only: [:create]
  end

  
  resources :relationships, only: [:destroy]

end
