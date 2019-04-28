Rails.application.routes.draw do
  devise_for :users

  root 'suppliers#index'

  resources :suppliers, only: [:show]

  post 'import_new_data', to: 'suppliers#import_new_data'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
