Rails.application.routes.draw do

  root 'shops#index'
  # get 'candies/index'
  # get 'shelves/index'

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
