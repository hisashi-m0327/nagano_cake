Rails.application.routes.draw do

  namespace :public do
    get 'addresses/index'
  end
  namespace :admin do
    get 'items/index'
    get 'items/show'
    get 'items/edit'
    get 'items/update'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    root to: "admin/sessions#new"
  end

  namespace :admin do
    resources :orders, only: [:index, :show]
    resources :items,  only: [:index, :show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end


  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  get "about" => "public/homes#about"

  namespace :public do
    resource :customers, only: [:show, :edit, :update]
    resource :cart_items, only: [:index, :update, :destroy]
    resources :items,  only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show]
  end

end

