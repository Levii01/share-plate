# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :beneficiaries
  # resources :food_providers
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
      resource :account_types, only: %i[edit update]
      resource :food_providers
      resource :beneficiaries
    end
    resources :panel, only: %i[index]
  end
end
