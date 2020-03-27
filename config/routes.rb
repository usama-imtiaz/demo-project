Rails.application.routes.draw do
  put :add_to_cart, controller: :cart, action: :add_to_cart
  put :remove_from_cart, controller: :cart, action: :remove_from_cart

  devise_for :users, path: :users
  resources :users do
    resources :profiles, only: [:index]
    resources :products, except: %i[index show]
  end

  resources :products, only: %i[index show] do
    get :autocomplete, on: :collection
    resources :comments, only: %i[edit update create destroy]
  end

  resources :cart, only: %i[index create edit destroy]

  resources :coupons, only: %i[index create] do
    get :get_coupons , on: :collection
    post :apply_coupon, on: :collection
  end

  scope :charges do
    resources :charges, only: %i[new create show]
    get :success, to: 'charges#success', as: :charges_success
    get :cancel,  to: 'charges#cancel', as: :charges_cancel
  end

  root to: 'home#index'
end
