Rails.application.routes.draw do
  namespace :feature_carrier_wave do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
