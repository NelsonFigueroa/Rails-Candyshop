Rails.application.routes.draw do

  devise_for :users

  # GET for about.html.erb in public controller
  get 'public/about'

  ### Will need to add different root if customer is authenticated

  # root route if user is authenticated
  devise_scope :user do
    authenticated :user do
      root 'shops#index', as: :authenticated_root
    end

    # root route if user is unauthenticated
    unauthenticated do
      # root 'devise/sessions#new', as: :unauthenticated_root
      root 'public#index', as: :unauthenticated_root
    end
  end

  resources :shops, :except => [:edit, :update] do
    member do
      get :delete
    end
  end

  resources :candies, :except => [:index, :show] do
    member do
      get :delete
    end
  end

  resources :shelves, :except => [:index, :show, :new, :edit, :update] do
    member do
      get :delete
    end
  end

end
