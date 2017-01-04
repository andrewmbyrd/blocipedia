Rails.application.routes.draw do

  get 'welcome/index'

  get 'welcome/about'

  root to: 'welcome#index'

  devise_for :users, controllers: { sessions: 'users/sessions' } do

  end

  devise_scope :user do
    get "premium", to: "users/registrations#premium", as: "premium_registration"
    put "upgrade", to: "users/registrations#upgrade", as: "upgrade"
    get "standard", to: "users/registrations#standard", as: "standard_reverting"
    put "downgrade", to: "users/registrations#downgrade", as: "downgrade"
  end
  resources :wikis

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
