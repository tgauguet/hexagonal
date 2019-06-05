Rails.application.routes.draw do
  resources :rooms
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  resources :bookings, only: [:destroy, :delete, :index]
  match '/bookings/download', to: 'bookings#download', via: :get
  match '/users/:id/reconfirm', to: 'users#reconfirm', via: :get
  match '/bookings/accept', to: "bookings#accept", via: :post
  match '/admin/dashboard', to: 'users#dashboard', via: :get

  authenticated :user do
    root 'rooms#index'
  end
  root 'welcome#index'
end
