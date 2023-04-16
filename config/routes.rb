Rails.application.routes.draw do

  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

   namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end


  namespace :admin do
    resources :genres, only: [:index, :new, :create, :edit, :update]
  end

  scope module: :public do
    resources :addresses, only: [:index, :edit, :new, :create, :update, :destroy]
  end

  scope module: :public do
    post 'order/confirm/:id' => 'orders#confirm', as: 'confirm_order'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :orders, only: [:new, :index, :show, :create]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  scope module: :public do
    resources :customers, only: [:show, :edit, :update]
    get 'unsubscribe/:id' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'withdraw/:id' => 'customers#withdraw', as: 'withdraw_customer'
  end

  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resources :cart_items, only: [:index, :create, :update, :destroy]
  end
end
