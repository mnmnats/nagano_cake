Rails.application.routes.draw do
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about',as:'about'
    patch '/customers/withdraw' => 'customers#destroy'
    get '/customers/unsubscribe' => 'customers#unsubscribe'

    resources :customers, :addresses, :cart_items, :items, :orders
  end
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
 root to: 'homes#top'
    resources :genres, :items, :customers, :order_details , :orders
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
