Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  devise_scope :admin do
    root to: "admin/sessions#new"
  end
  
  get "about" => "public/homes#about"

  namespace :admin do
    root to: "homes#top"
  end

  resources :items, only: [:index]

  resource :customers, only: [:show, :edit, :update]

  resources :addresses, only: [:index]

  resources :orders, only: [:index]


end
