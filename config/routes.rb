Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :items, only: [:index, :show]

    resource :customers do
      get '/my_page' => 'customers#show'
      get '/information/edit' => 'customers#edit'
      patch '/information' => 'customers#update'
      get '/unsubscribe' => 'customers#unsubscribe'
      patch '/withdraw' => 'customers#withdraw'
    end

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete :delete_all, on: :collection
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post '/confirm' => 'orders#confirm'
        get '/complete' => 'orders#complete'
      end
    end

    resources :addresses, except: [:new, :show]
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
