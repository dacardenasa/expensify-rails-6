Rails.application.routes.draw do
  root 'dashboards#index'
  post "expenses/filter/:value", to: "expenses#filter", as: "filter"
  resources :expenses, only: [:index, :new, :create, :show, :update, :destroy]
end
