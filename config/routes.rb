Rails.application.routes.draw do
  resources :rooms
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  resources :bookings, only: [:destroy, :delete]
  match '/waiting-list', to: 'bookings#index', via: :get
  match '/bookings/download', to: 'bookings#download', via: :get
  match '/users/:id/reconfirm', to: 'users#reconfirm', via: :get
  match '/bookings/accept', to: "bookings#accept", via: :post

  authenticated :user do
    root 'users#dashboard'
  end
  root 'welcome#index'
end
