# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations::ChoseProfiles', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/registrations/account_types/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/users/registrations/account_types/create'
      expect(response).to have_http_status(:success)
    end
  end
end
