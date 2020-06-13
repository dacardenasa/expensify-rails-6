Rails.application.routes.draw do
  root 'dashboards#index'

  get "expenses/filter/:value", to: "expenses#filter", as: "filter"

  resources :expenses, only: [:index, :new, :create, :show, :update, :destroy]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :expenses, only: [:index, :create, :update, :destroy] 
    end
  end

end
