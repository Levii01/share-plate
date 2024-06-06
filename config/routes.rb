# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :user,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }
  get 'up' => 'rails/health#show', as: :rails_health_check
  root to: 'home#index'

  get 'home/index'
  namespace :users do
    namespace :registrations do
      get 'chose_profile/index'
      get 'chose_profile/create'
    end
    resources :panel, only: %i[index]
  end
end
