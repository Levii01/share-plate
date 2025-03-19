# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Beneficiaries::Reservations', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/beneficiaries/reservations/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/users/beneficiaries/reservations/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/beneficiaries/reservations/show'
      expect(response).to have_http_status(:success)
    end
  end
end
