Rails.application.routes.draw do
  devise_for :users
  get 'tasks/index'
  root to: "tasks#index"

  resources :tasks do
    resources :notes, only: [:create], controller: 'tasks/notes'
  end

  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
