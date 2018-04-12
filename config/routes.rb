Rails.application.routes.draw do

  resources :contacts, :only => [:index, :show, :new, :create, :destroy]
  resources :errors, :only => [:index]

  namespace :api, defaults: {format: :json} do
       namespace :v1 do
         resources :transactions do
           collection do
             post :verify
           end
         end
         resources :carts
         resources :notifications
         resources :customers
         resources :contacts, :only => [:create]
         resources :registrations do
           collection do
             post :social
             post :profile_image
             post :change_password
           end
         end
         resources :sessions, :only => [:create, :destroy]
         resources :products do
           collection do
             get :real_estate
             get :electronics
             get :phone_and_tablets
             get :automobiles
             get :featured_items
             get :promoted_items
             post :search
           end
         end
       end
  end

  namespace :user do
    resources :profiles
    resources :transactions, :only=> [:index]
    resources :dashboards do
      member do
        post :change_image
        get :wallet_charge
        post :add
      end
    end
    resources :products do
      collection do
        get :approved
        get :unapproved
      end
    end
    resources :tickets do
      member do
        post :add_ticket
      end
    end
    resources :carts do
      member do
        post :add_to_cart
      end
      collection do
        get :empty_cart
        get :check_out
        post :pay
        get :move_next
      end
    end
    resources :notifications do
      member do
        get :select_winner
        get :select_one_option
        get :received
        get :tickets
        get :read
      end
    end
    resources :withdraws do
      collection do
        get :request_for_withdraw

      end
    end
  end

  namespace :admin do
    resources :homes
    resources :requests do
      member do
        get :transfer
      end
    end
    resources :users do
      collection do
        get :all_blocked_users
      end
      member do
        get :block_user
        get :remove_user
        get :product_detail
        get :unblock_user
      end
    end
    resources :products do
      collection do
        get :approved_products
        get :unapproved_products
        get :my_products
        get :select_raffle_items
        get :all_raffle_items
      end
      member do
        get :approve_product
        get :decline_product
        get :mark_raffle
        get :marked_raffle
      end
    end
    resources :promotions
  end

  devise_for :users, path: 'users', controllers: { registrations: 'user/registrations', sessions: 'user/sessions', omniauth_callbacks: 'user/omniauth_callbacks' } #omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_for :admins, path: 'traffle-auth-admins', controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations'}

  resources :newsletters
  resources :homes do
    collection do
      post :search
      get :play
      get :how_to_play
      get :real_estate
      get :electronics
      get :phone_and_tablets
      get :automobiles
      get :featured_items
      get :promoted_items
      get :terms
      get :raffle_items
    end
  end

  authenticated :user do
    root :to => 'homes#index'
  end
  authenticated :admin do
    #root :to => 'admin/stocks#index'
    root :to => 'admin/homes#index'
  end

  root to: 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
