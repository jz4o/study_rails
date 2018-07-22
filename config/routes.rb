Rails.application.routes.draw do
  root 'menu#index'

  get 'menu', to: 'menu#index'
  get 'menu/:index', to: 'menu#show', param: :index, as: :show_menu

  namespace :feature_active_record do
    resources :parents
  end
  namespace :feature_carrier_wave do
    resources :users do
      post :confirm, on: :collection
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
