Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'shops#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
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
