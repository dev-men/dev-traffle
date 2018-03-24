Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
     namespace :v1 do
       resources :registrations do
         collection do
           post :social
         end
       end
       resources :sessions, :only => [:create, :destroy]
       resources :products
     end
  end

  namespace :user do
    resources :profiles
    resources :dashboards, :only => [:show]
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
      end
    end
    resources :notifications
  end

  namespace :admin do
    resources :homes
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
    resources :categories
    resources :products do
      collection do
        get :approved_products
        get :unapproved_products
        get :my_products
      end
      member do
        get :approve_product
      end
    end
  end

  devise_for :users, path: 'users', controllers: { registrations: 'user/registrations', sessions: 'user/sessions', omniauth_callbacks: 'user/omniauth_callbacks' } #omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_for :admins, path: 'traffle-auth-admins'

  resources :homes do
    collection do
      post :search
      get :products
      get :contact
      get :play
      get :how_to_play
      get :real_estate
      get :electronics
      get :phone_and_tablets
      get :automobiles
      get :featured_items
      get :promoted_items
      get :items_by_location
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
