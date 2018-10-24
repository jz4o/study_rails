Rails.application.routes.draw do
  root 'menu#index'

  resource :user_session, only: :create
  get    'login',  to: 'user_sessions#new'
  delete 'logout', to: 'user_sessions#destroy'

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
