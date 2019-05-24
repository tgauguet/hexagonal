Rails.application.routes.draw do
  root 'welcome#index'
  resources :workstations, only: [:new, :create]
end
