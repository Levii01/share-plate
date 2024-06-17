# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodProvidersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/food_providers').to route_to('food_providers#index')
    end

    it 'routes to #new' do
      expect(get: '/food_providers/new').to route_to('food_providers#new')
    end

    it 'routes to #new' do
      expect(get: '/food_providers/1').to route_to('food_providers#new', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/food_providers/1/edit').to route_to('food_providers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/food_providers').to route_to('food_providers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/food_providers/1').to route_to('food_providers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/food_providers/1').to route_to('food_providers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/food_providers/1').to route_to('food_providers#destroy', id: '1')
    end
  end
end
