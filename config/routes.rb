Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
    passwords: 'users/passwords', registrations: 'users/registrations' }

  resources :users, only: [:show, :new]

  root 'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
end
