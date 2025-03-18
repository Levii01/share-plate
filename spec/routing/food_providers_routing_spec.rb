# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Registrations::FoodProvidersController, type: :routing do
  describe 'routing' do
    context 'when routes to' do
      it '#index' do
        expect(get: '/food_providers').to route_to('food_providers#index')
      end

      it '#new' do
        expect(get: '/food_providers/new').to route_to('food_providers#new')
      end

      it '#show' do
        expect(get: '/food_providers/1').to route_to('food_providers#show', id: '1')
      end

      it '#edit' do
        expect(get: '/food_providers/1/edit').to route_to('food_providers#edit', id: '1')
      end

      it '#create' do
        expect(post: '/food_providers').to route_to('food_providers#create')
      end

      it '#update via PUT' do
        expect(put: '/food_providers/1').to route_to('food_providers#update', id: '1')
      end

      it '#update via PATCH' do
        expect(patch: '/food_providers/1').to route_to('food_providers#update', id: '1')
      end

      it '#destroy' do
        expect(delete: '/food_providers/1').to route_to('food_providers#destroy', id: '1')
      end
    end
  end
end
