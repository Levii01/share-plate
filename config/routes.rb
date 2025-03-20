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
    namespace :beneficiaries do
      resources :offers, only: %i[index show]
      resources :reservations, only: %i[index create show update destroy]
    end
    resource :beneficiary, only: %i[edit update]

    namespace :food_providers do
      resources :offers
    end
    resource :food_provider, only: %i[edit update]

    namespace :registrations do
      resource :account_types, only: %i[edit update]
      resource :food_providers, only: %i[show new edit create update]
      resource :beneficiaries, only: %i[show new edit create update]
    end
    resources :panel, only: %i[index]
  end
end
