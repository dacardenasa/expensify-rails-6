Rails.application.routes.draw do
  root 'dashboards#index'
  resources :expenses, only: [:index, :new, :create, :show, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
