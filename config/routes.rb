Rails.application.routes.draw do
  resources :rooms
  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'confirmations' }
  resources :requests, only: [:destroy, :delete]
  match '/waiting-list', to: 'requests#index', via: :get
  match '/requests/download', to: 'requests#download', via: :get
  match '/users/:id/reconfirm', to: 'users#reconfirm', via: :get
  match '/requests/accept', to: "requests#accept", via: :post

  authenticated :user do
    root 'users#dashboard'
  end
  root 'welcome#index'
end
