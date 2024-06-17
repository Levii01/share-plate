# frozen_string_literal: true

json.extract! food_provider, :id, :name, :type, :state, :user_id, :address, :nip, :phone, :email, :description,
              :opening_time, :active, :created_at, :updated_at
json.url food_provider_url(food_provider, format: :json)
