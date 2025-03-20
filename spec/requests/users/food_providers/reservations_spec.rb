# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::FoodProviders::Reservations', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/food_providers/reservations/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/users/food_providers/reservations/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/food_providers/reservations/show'
      expect(response).to have_http_status(:success)
    end
  end
end
