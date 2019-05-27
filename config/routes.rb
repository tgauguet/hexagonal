Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  match '/waiting-list', to: 'requests#index', via: :get
  match '/users/:id/reconfirm', to: 'users#reconfirm', via: :get
  root 'welcome#index'
end
