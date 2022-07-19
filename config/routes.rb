# == Route Map
#

Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    get '/' => 'homes#top'
    get "orders/history/:id" => "orders#history", as: "order_history"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :items, only: [:index, :show] do
      collection do
        get "genre_search" => "items#genre_search"
      end
    end

    resource :customers do
      get '/my_page' => 'customers#show'
      get '/information/edit' => 'customers#edit'
      patch '/information' => 'customers#update'
      get '/unsubscribe' => 'customers#unsubscribe'
      patch '/withdraw' => 'customers#withdraw'
    end

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete :destroy_all, on: :collection
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post '/confirm' => 'orders#confirm'
        get '/complete' => 'orders#complete'
      end
    end

    resources :addresses, except: [:new, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
