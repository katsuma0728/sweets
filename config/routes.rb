Rails.application.routes.draw do

  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  resources :items, only: [:index, :edit]

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

end
