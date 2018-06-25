Rails.application.routes.draw do

  devise_for :customers
  devise_for :users

  # GET for about.html.erb in public controller
  get 'public/about'

  devise_scope :customer do
    # root route if customer is authenticated
    authenticated :customer do
      root 'customer#index', as: :authenticated_customer
    end
  end

  devise_scope :user do
    # root route if user is authenticated
    authenticated :user do
      root 'shops#index', as: :authenticated_user
    end

    # root route if user is unauthenticated
    unauthenticated do
      root 'public#index', as: :unauthenticated_user
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

  # For customers
  resources :customer, :except => [:new, :create] do
    member do
      get :delete
    end
  end

end
