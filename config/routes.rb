Rails.application.routes.draw do

  root 'shops#index'
  # get 'candies/index'
  # get 'shelves/index'

  resources :shops do
    member do
      get :delete
    end
  end

  resources :candies do
    member do
      get :delete
    end
  end

  resources :shelves do
    member do
      get :delete
    end
  end

end
