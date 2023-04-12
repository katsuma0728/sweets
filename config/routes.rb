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
    resources :items, only: [:index, :edit]
  end

  scope module: :public do
    resources :shipping_address, only: [:index, :edit]
  end

  scope module: :public do
    resources :orders, only: [:new, :complete, :index, :show]
  end

  scope module: :public do
    resources :items, only: [:index]
  end

  scope module: :public do
    resources :customers, only: [:show, :edit, :unsubscribe]
  end

  scope module: :public do
    resources :cart_items, only: [:index]
  end
end
