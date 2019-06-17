Rails.application.routes.draw do
  resources :rooms, only: [:index]
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  resources :bookings, only: [:destroy, :index, :create]
  match '/bookings/download', to: 'bookings#download', via: :get
  match '/bookings/accept', to: "bookings#accept", via: :post
  match '/admin/dashboard', to: 'users#dashboard', via: :get

  authenticated :user do
    root 'rooms#index'
  end
  unauthenticated :user do
    root 'welcome#index'
  end
end
