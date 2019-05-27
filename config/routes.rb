Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  match '/users/:id/reconfirm', to: 'users#reconfirm', via: :get
  root 'welcome#index'
end
