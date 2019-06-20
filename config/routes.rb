Rails.application.routes.draw do
  resources :rooms, only: [:index]
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations', omniauth_callbacks: 'callbacks' }
  resources :bookings, only: [:index, :create, :destroy]
  match '/bookings/download', to: 'bookings#download', via: :get
  match '/bookings/accept', to: "bookings#accept", via: :post
  match '/admin/dashboard', to: 'users#dashboard', via: :get
  resources :users, only: [:update]
  match '/search-address', to: 'users#search_address', via: :post, :defaults => { :format => 'json' }

  authenticated :user do
    root 'rooms#index'
  end
  unauthenticated :user do
    root 'welcome#index'
  end
end
