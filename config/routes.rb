Rails.application.routes.draw do
  # devise_for :customers, controllers: {
  #   sessions:      'customers/sessions',
  #   passwords:     'customers/passwords',
  #   registrations: 'customers/registrations'
  # }

  namespace :admin do
    root 'homes#top'
    resources :items
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :edit, :update, :show]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end

  scope module: 'public' do
    post "/orders/confirm" => "orders#confirm", as: "confirm_order"
    get "/orders/complete" => "orders#complete", as: "complete_order"
    resources :orders, only:[:new, :create, :index, :show]
    delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :cart_items, only:[:index, :update, :destroy, :create]
    resources :items, only:[:index, :show]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :homes, only:[:top]
    get "/customers/mypage" => "customers#show", as: "customer"
    get 'customers/mypage/:id/edit' => "customers#edit", as: "edit_customer"
    get 'customers/confirm_withdrawal' => "customers#confirm", as: "confirm_withdrawal_customer"
    patch "/customers/withdrawal" => "customers#withdrawal", as: "withdrawal_customer"
    resources :customers, only:[:update]
    root 'homes#top'
    get "/about" => "homes#about", as: "about"
  end

  devise_for :customers, skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: 'admin/sessions',
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end